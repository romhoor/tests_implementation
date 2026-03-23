# MATLAB Codegen Architecture Note

## Purpose

This note is for the DSW team.

Its goal is simple:

- show, with a concrete local example, how quickly class/inheritance-based MATLAB design turns into a testing problem of its own;
- connect that to the existing MATLAB -> MEX -> C verification path already present in this repo;

It is a note about paying object-oriented overhead where the target artifact is generated C and the real engineering priorities are determinism, traceability, bounded behavior, and straightforward verification.

## 1. The Local Warning Sign: `test_implementation/`

The `test_implementation/` tree is a useful warning sign because it shows is something more important for architecture:

even a toy abstract hierarchy immediately creates a second problem to solve and verify, namely the hierarchy itself.

The problem is not the mathematics.
The problem is that once this is modeled through inheritance, the team is no longer only testing geometry.
The team is also testing:

- abstract contract declaration;
- subclass realization of the contract;
- inherited method behavior through concrete subclasses;
- metadata shape of the class hierarchy;
- value semantics of the class hierarchy;
- negative-path behavior of inherited API;
- cross-class consistency.

### The testing burden is the real story

To test the abstract hierarchy, the repo needs:

- a helper concrete subclass just to exercise the base class
- metadata tests on the parent contract and inherited behavior tests through the helper subclasses
- cross-class behavioral tests
Only then we can proceed with
- per-class unit tests:


### What is "wrong" here
The architecture choice creates a verification surface that is disproportionate to the problem.

This is a 2-D shapes toy example.
There are no real hardware interfaces, no real concurrency issues, no deep mission logic.
Yet the test strategy already needs:

- metadata inspection of abstract members;
- explicit checks that subclasses inherit the expected methods;
- checks that inherited template methods call subclass behavior correctly;
- duplicated suites for different concrete subclasses;
- cross-class consistency checks.

That happens when the class hierarchy itself becomes part of the product risk.

### The repo already contains class generators just to test the framework

In the actual FSM test suite, the codebase goes a step further:

- ../tests/docking_software/fsm_lib/mocks/generate_state.m
- ../tests/docking_software/fsm_lib/mocks/generate_composite_state.m
- ../tests/docking_software/fsm_lib/mocks/generate_transition.m

These utilities generate temporary MATLAB classes from templates so that the framework can be tested against many artificial subclasses.
That is a very revealing symptom.

It means the verification target is no longer only the behavior of the real DSW states and transitions.
The verification target is now also:

- whether arbitrary generated subclasses behave correctly under the base classes;
- whether ID-bearing constant properties are accepted or rejected correctly;
- whether the framework still works for newly manufactured subclasses.

That disappears when the same information is represented as explicit data in structs and enums instead of class identity.

## 2. If We Choose Inheritance, Hierarchy Testing Comes First

This is the key engineering point.

With inheritance-heavy design, the first testing problem is not the business logic.
The first testing problem is whether the hierarchy is even safe to rely on.

Before trusting any unit test of the algorithm inside a subclass, the team has to establish:

- what the abstract contract really is;
- which parts are enforced by MATLAB syntax and which are only conventions;
- whether the subclass actually realizes the contract;
- whether inherited methods behave correctly through the subclass;
- whether multiple subclasses remain behaviorally compatible where common usage assumes they are;
- whether the intended semantics are value semantics or handle semantics;
- whether constructor, identity, and type tags remain consistent.
- whether global/persistent runtime state is reset correctly between tests.

In other words:

hierarchy correctness becomes prerequisite testing.

Only after that can the team start testing the actual application logic with confidence.

### The `uint8` abstract-constant trap

A particularly bad version of this pattern is when subtype identity is encoded as an abstract constant or constructor-dependent tag such as:

```matlab
properties (Abstract, Constant)
    TypeId (1,1) uint8
end
```

and higher-level logic assumes only a tiny subset of values is valid, for example `1, 2, 3, 4`.

At that point, the type contract is no longer just "this class implements these methods".
It is also "this class exposes a particular identity code and higher-level logic behaves correctly for it".

Then the test burden expands into questions such as:

- does each intended concrete class expose the right ID;
- are duplicate IDs rejected;
- are gaps rejected;
- are out-of-range values rejected;
- is constructor behavior coupled correctly to the ID;
- is downstream dispatch correct for every allowed ID;
- what happens if a new subclass appears with an unintended ID.

If one wants absolute confidence in that design, the conceptual test space is the full `uint8` domain: 256 values.
That is exactly what we should avoid in the codegen-facing DSW core.

## 3. This Gets Worse In MATLAB Codegen

The DSW already shows the cost of carrying class structure into codegen.

### Codegen is already forcing structure compromises

The HFSM base class says this explicitly:

- [`docking_software/state_machine/fsm_lib/CompositeState.m`] lines 27-35

It explains that:

- child states and transitions are stored as `cell` arrays;
- this is required for MATLAB codegen compatibility;
- each state and transition is its own class;
- classic arrays cannot be used because of type instability.

It then adds another workaround:

- [`docking_software/state_machine/fsm_lib/CompositeState.m`] lines 82-87

The comment there states that child states and transitions cannot be defined directly in properties because MATLAB codegen does not support handle classes being defined directly as properties in the intended way.

This is the important architectural lesson:

the class hierarchy is not helping code generation.
The class hierarchy is being bent around code-generation restrictions.

There is also an important completeness issue in the framework validation itself:
- [`docking_software/state_machine/fsm_lib/CompositeState.m`]: the `validate_fsm()` comment lists family-level checks such as unique state IDs, unique transition IDs, valid source/target references, and reachability, but the current implementation only enforces a subset of these checks.

That means some of the architectural contract is presently documented as intent rather than fully enforced behavior.
In a class-heavy framework, that gap matters a lot, because it pushes even more verification burden into tests and manual review.

### The current DSW core is assembled as many small class instances

At the root:

- [`docking_software/system/get_dsw.m`] lines 10-31
creates:

- `InitState`
- `DockingState`
- `DockedState`
- `AbortingState`
- transition objects
- a persistent `DockingSoftware` composite object

Inside docking:

- [`docking_software/state_machine/parent_state_machine/DockingState.m`] lines 18-44
builds:

- 6 child state objects
- 8 transition objects
- another `CompositeState` instance

This is a lot of object structure for a finite, known-at-compile-time control graph.

### Hidden shared state is then routed through manager classes

For example:

- [`docking_software/interface/InterfaceManager.m`] lines 15-48

This creates shared interface objects through persistent static accessors.
Then the step entry point uses them:
- [`docking_software/system/dsw_step.m`] lines 10-24
That means:

- control state is partly in the FSM object tree;
- I/O state is partly in manager-owned persistent objects;
- telemetry is written through manager calls after the FSM step.


There is a second singleton-like layer as well:

- [`docking_software/config/ConfigManager.m`]

That class exposes many `persistent ..._instance` accessors for common config, controller config, per-state config, and per-transition config.

So in practice the DSW core currently depends on:

- a persistent root FSM instance;
- persistent interface instances;
- persistent configuration instances.

This is closer to a global service-locator architecture than to a small explicit control kernel.


### The repo can already run tests against a generated compiled variant

- [`tests/run_sil_tests.m`]

The SIL path uses `matlabtest.coder.MEXReplacementTestSuite.fromFile(...)` to run tests against a generated MEX instead of the MATLAB implementation.

This is exactly the kind of workflow we should lean into:

- write tests once against a stable functional interface;
- run them on MATLAB;
- run them again on generated compiled code;
- compare behavior directly.

### The repo also runs the generated C outside MATLAB

- [`releases/c_test_runner/README.md`]

The C test runner executes the autogenerated C version of the docking software from recorded input data and validates outputs.

This matters a lot:
we do not need to hide behind MATLAB classes to get confidence.
We already have the machinery to verify the compiled result directly.

It is also worth noting that the test framework itself has to manage the hidden persistent state explicitly:

- [`tests/docking_software/fsm/_test_environment/test_framework/DSWIntegratedOpenLoopTestSet.m`]

That setup clears MEX libraries and clears the HFSM getter function between test cases specifically to reset persistent state.

Again, that is a legitimate workaround.
But it is also a sign that persistence and hidden shared instances are part of the runtime contract and therefore part of verification.

## 5. The Repo Already Signals A "Disciplined C" Target

The codegen configuration itself points in this direction:

- [`releases/dsw_codegen/get_codegen_config.m`] lines 31-51

Notable choices include:

- `TargetLangStandard = "C99 (ISO)"`
- dynamic memory disabled
- recursion disabled
- variable names preserved
- multi-instance code enabled
- many optimizations intentionally disabled

This is not the profile of a codebase trying to exploit rich runtime OO behavior.
It is the profile of a codebase that ultimately wants predictable, analyzable, stable C.

# !!! So the architecture of the MATLAB source should support that goal directly.

## 6. Space-Grade Principles That Matter Here

For the DSW core, the useful space-grade principles are not "use OOP" or "never use OOP".
The useful principles are:

- determinism;
- bounded execution;
- explicit state;
- explicit interfaces;
- static or clearly bounded memory behavior;
- traceability from design intent to generated artifact;
- simple failure modes;
- low incidental complexity;
- testability at multiple levels with stable interfaces.

Translated into code organization, that usually means:

- state stored in obvious structures;
- control flow visible in plain functions and `switch`/guard logic;
- algorithmic kernels separated from I/O;
- no hidden ownership games;
- no hidden dispatch semantics;
- no class identity being used as a proxy for control state.

That does not ban classes.
It simply says classes should earn their complexity.
For the codegen-facing DSW core, they currently do not.

## 7. Proposed Architecture For The DSW Core

The proposal is not to rewrite the whole repository in a single style.

The proposal is to refactor the **codegen-facing DSW core** into a data-oriented functional core while keeping the external API stable.

### Keep the existing external interface

Retain the current entrypoint model:

- `dsw_init`
- `set_dsw_cycle_inputs`
- `dsw_step`
- `get_dsw_cycle_outputs`

These already map cleanly to MATLAB, MEX, generated C, and the C test runner.

### Replace the internal OO graph with one explicit context

Use one main context struct, for example:

```matlab
ctx = struct( ...
    'config',          dsw_config, ...
    'inputs',          dsw_inputs, ...
    'outputs',         dsw_outputs, ...
    'telemetry',       dsw_tm, ...
    'mode',            uint8(ModeEnum.INIT), ...
    'phase',           uint8(PhaseEnum.SYNC_LAR), ...
    'is_active',       false, ...
    'last_error_code', uint8(0), ...
    'planner',         planner_state, ...
    'arm',             arm_state, ...
    'gripper',         gripper_state, ...
    'nav',             nav_state);
```

This context should hold what is currently spread across:

- the root FSM object;
- nested state objects;
- persistent interface-manager instances;
- telemetry update state;
- planner/runtime scratch state.

### Use explicit enums instead of class identity

Keep the conceptual split if it is useful:

- top-level mode:
  - `INIT`
  - `DOCKING`
  - `DOCKED`
  - `ABORTING`
- docking phase:
  - `SYNC_LAR`
  - `REACH_LAR`
  - `PRE_GRASP`
  - `GRASP`
  - `DOCKING_COMPLETING`
  - `DOCKING_FAILING`

But represent those as plain enum values in data, not as objects.

### Turn states and transitions into plain functions

Instead of:

- one class per state;
- one class per transition;
- generic composite-state machinery;

use plain functions such as:

```matlab
function ctx = dsw_step(ctx)
    switch ctx.mode
        case ModeEnum.INIT
            ctx = step_init(ctx);

        case ModeEnum.DOCKING
            ctx = step_docking(ctx);

        case ModeEnum.DOCKED
            ctx = step_docked(ctx);

        case ModeEnum.ABORTING
            ctx = step_aborting(ctx);
    end
end
```

and inside docking:

```matlab
function ctx = step_docking(ctx)
    switch ctx.phase
        case PhaseEnum.SYNC_LAR
            if can_sync_lar_to_docking_failing(ctx)
                ctx = enter_phase(ctx, PhaseEnum.DOCKING_FAILING);
            elseif can_sync_lar_to_reach_lar(ctx)
                ctx = enter_phase(ctx, PhaseEnum.REACH_LAR);
            else
                ctx = update_sync_lar(ctx);
            end

        case PhaseEnum.REACH_LAR
            ...
    end
end
```

This is not primitive -> it is explicit.

### Move interfaces from singleton-like managers into explicit data flow

Instead of using:

- `InterfaceManager.get_if_fsw()`
- `InterfaceManager.get_if_docking_arm()`
- `InterfaceManager.get_if_gripper()`
- `InterfaceManager.get_if_navigation()`

the codegen core should operate on explicit input structs and output structs.

### Keep the math stack procedural

The planner, FK, Jacobian, and IK are already much closer to the right shape.

Those should remain as:

- pure or near-pure functions where possible;
- explicit inputs and outputs;
- no hidden polymorphism;
- easy MATLAB/MEX/C equivalence targets.

## 8. What This Changes In The Test Strategy

### Practical comparison: OO burden vs C-style burden

For the codegen-facing DSW core, the test burden difference is not academic.
It is operational.

| Concern | Inheritance-heavy MATLAB | C-style MATLAB / generated-C-friendly |
|---|---|---|
| Type/interface correctness | Must test abstract base contract, every subclass realization, and inherited behavior through subclasses | Usually one struct schema or one function contract test |
| `uint8` identity/tag validity | May require generating many fake subclasses to prove the framework accepts/rejects IDs correctly | One data-validation loop over numeric values |
| Example: only 4 IDs are legal in a `uint8` domain | Pressure to generate up to 256 classes and prove only the right ones are accepted | Pass `0..255` through one validator and assert only the allowed values pass |
| Cross-family consistency | Need tests that all derived classes preserve common semantics | Usually one dispatch table or enum-to-behavior map test |
| Constructor semantics | Need per-subclass constructor and base-constructor interaction tests | One initializer / validator test suite |
| Reset/isolation | Need tests that persistent singletons and class instances do not leak between cases | One explicit context reset test |
| Structural legality of the FSM | Need family-level tests over class constants and class composition | Need state-table / transition-table validation tests |
| Cost of adding a new state/transition | New class, new hierarchy tests, new family-compatibility risk | New enum/table row and normal behavior tests |

Engineering conclusion:

- in the OO shape, a lot of effort is spent proving the framework and its subtype family are not lying;
- in the C-style shape, almost all effort can be spent on the real behavior instead.

### If we keep inheritance in the core

Then the team must accept that hierarchy verification comes before ordinary functional verification.

The minimum burden includes:

- metadata tests for abstract members;
- subclass realization tests;
- inherited behavior tests through every concrete subclass;
- cross-subclass consistency tests;
- constructor and value/handle semantic tests;
- negative-path inheritance tests;
- ID/tag exhaustiveness where subtype identity is encoded in data-like constants;
- singleton/persistent-state reset tests to prove one subclass run does not contaminate the next one.

# !!!ONLY AFTER THAT it make sense to trust unit tests for the actual control logic.

### Preferred test strategy for a C-style MATLAB core

The recommended order is simpler and closer to the generated artifact:

1. Pure function tests

- FK
- Jacobian
- IK
- planner helpers
- geometry and frame transforms

2. Guard tests

- `can_sync_lar_to_reach_lar`
- `can_reach_lar_to_pre_grasp`
- failure guards
- completion guards

3. State-step tests

- one-step behavior for each mode/phase
- entry behavior
- telemetry updates
- error handling

4. Sequence tests

- nominal docking path
- fail path
- recovery / reset path

5. MATLAB vs MEX equivalence

- same test vectors
- same expected outputs
- same transition timing

6. Generated C integrated tests

- run recorded scenarios through the C test runner
- compare outputs and telemetry

This is a much better use of verification effort.
It tests the software behavior, not the mechanics of an object model.


## Migration Plan

This can be done incrementally.
For the DSW codegen path, MATLAB should be written in a disciplined C style:

- explicit data structs / buses;
- explicit enums for mode and phase;
- explicit `init`, `step`, `reset`, `get_outputs` functions;
- explicit transition guards and state actions as plain functions;
- no inheritance-heavy runtime core;
- no class hierarchy whose correctness has to be verified separately from the actual algorithm.

### Step 1: Freeze the public ABI

Do not break:

- `dsw_init`
- `set_dsw_cycle_inputs`
- `dsw_step`
- `get_dsw_cycle_outputs`

### Step 2: Introduce explicit context structs

Start by creating:

- `DSWContext`
- `DSWInputs`
- `DSWOutputs`
- `DSWTelemetry`
- `DSWConfig`

without removing the old implementation yet.

### Step 3: Move one concern at a time out of classes

Recommended order:

1. telemetry handling
2. interface-manager state
3. top-level mode/phase storage
4. transition guards
5. state entry/update functions

### Step 4: Keep the numeric kernels stable

Do not rewrite FK/Jacobian/IK just to change architecture.
Refactor the control shell around them first.

### Step 5: Reuse the existing verification ladder

Use:

- MATLAB unit tests
- SIL / MEX replacement tests
- C test runner scenarios

to prove the architectural refactor preserved behavior.


Classes can still be fine in tooling, visualization, test fixtures, and simulator-side convenience code.
They are a poor default for the code that is meant to become generated C and later be trusted as if it were hand-written embedded software.

## Final Recommendation

For this project, the right question is not:

"Can we design a sophisticated MATLAB class hierarchy?"

The right question is:

"What MATLAB structure gives us the shortest, clearest, most verifiable path to trusted generated C?"

In my opinion (Roman H)
For the DSW core, the answer is not inheritance-heavy OOP.
The answer is a disciplined C-style MATLAB architecture:

- explicit data;
- explicit state;
- explicit functions;
- direct MATLAB/MEX/C traceability;
- tests centered on behavior, not class mechanics.

That architecture is easier to read, easier to reason about, easier to port, easier to debug in generated C, and easier to justify in a space-grade verification context.
