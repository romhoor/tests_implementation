# Testing Process for Abstract and Inherited Classes

This document describes the testing procedure proposed for MATLAB (C++ style) classes and their concrete subclasses.

## Main idea

When a base class is abstract, two different verification risks appear:

1. does the implemented code in the abstract base class work correctly?
2. do the concrete subclasses actually satisfy that inherited base-class contract?

These two questions are related, but they are not the same test target. They lead to a TODO list for every new C++-style component:

- Does construction produce a valid object?
- Are all required parameters forwarded/stored correctly?
- Are defaults explicit and tested?
- Are units, ranges, dimensions, and enum values validated?
- Are invalid inputs rejected predictably?
- Are invariants preserved after every public call?
- Does behavior remain correct across repeated calls and mode transitions?
- Can the component be substituted wherever its interface/base type is expected?
- Is the behavior the same on the compiled path?


## Step 1. Test the abstract base class through a dummy subclass

An abstract class cannot be instantiated directly. Because of that, the base class must be tested indirectly through a minimal dummy concrete subclass created only for testing.

Purpose of the dummy subclass:

* make the abstract parent instantiable
* implement the protected abstract computation hooks with trivial bodies only 
* avoid mixing base-class tests with real subclasses logic

In this repository:

* abstract base class `Shape`
* dummy helper class `dummyShape`

The base contract test file is `test_base_contract_Shape.m`.

That file should test only the concrete behavior implemented directly in the abstract parent.

Examples:

* constructor behavior
* default values
* getter behavior
* setter behavior
* shared validation owned by the abstract parent

It should not test subclass-specific formulas such as square area formulas or circle perimeter formulas, because those do not belong to the abstract parent.

## Step 2. Test the inherited contract on real concrete subclasses

After the base-class behavior is verified, the same inherited contract should be checked on every real concrete subclass.

Purpose of these tests:

* confirm that concrete subclasses respect the inherited base-class behavior
* verify that constructor forwarding is correct
* verify that inherited getters and setters behave correctly on real objects
* verify that each real subclass satisfies the parent-owned public contract

In this repository:

* the derived contract test file is `test_derived_contract_Shape.m`
* the list of participating concrete subclasses is defined in `get_derived_shape_contract_cases.m`

The derived contract tests do not need one separate test file per shape, the generic contract runner is reused for all registered subclasses.

## Important distinction

The base contract test and the derived contract test may contain very similar assertions, but they do not mean the same thing, the test intention is different.

Base contract test:

* target = the abstract parent implementation itself
* helper object = dummy subclass
* focus = parent-owned behavior and validation

Derived contract test:

* target = every real concrete subclass
* helper object = real subclass instance
* focus = substitution: each child must behave like a valid `Shape`

## Liskov substitution view

These derived contract tests are also a practical way to think about the Liskov Substitution Principle.

### Definition

A subtype should be usable anywhere its base type is expected, without breaking the correctness of the program.

### Behavioral substitutability

For this to be true:

* a subclass should be able to replace the base class in client code
* program behavior should remain correct after substitution
* substitution should not introduce unexpected behavior changes
* client code should not need special knowledge of the concrete subtype

### Contract requirements

The subtype must respect the contract of the parent type:

* it must not require more than the parent requires (preconditions cannot be strengthened)
* it must not promise less than the parent promises (postconditions cannot be weakened)
* it must preserve parent invariants
* it must not violate the expected object-history behavior

### What the tests mean

For this project, the practical substitution test is:

* if `S` is a subtype of `Shape`
* then an object of type `Shape` should be replaceable by an object of type `S`
* without breaking the parent-level expectations

That is exactly why the derived contract suite exists. It checks that each real subclass still behaves like a valid `Shape`, not just like a MATLAB class with the right method names.

#### !!! This also applies to indirect descendants.

For example, if a class inherits from `Square`, and `Square` already inherits
from `Shape`, then that new class should still be tested against the `Shape`
contract. The contract belongs to the full subtype chain, not only to the
direct children of the abstract parent.

# Proposed Baseline Procedure

## This is the proposed baseline of tests that we want to have regardless of the requirements.

A component does not need every test family in the same depth, but every component must be evaluated against this checklist and the applicable baseline tests must be implemented intentionally, not implicitly skipped.

1. Construction contract

- valid construction produces a usable object
- invalid or forbidden configuration produces predictable invalid state
- defaults are explicit and stable

2. Public API contract

- getters/setters or public methods preserve invariants
- repeated calls are stable
- lifecycle order is valid

3. Invalid-input behavior

- bad values are rejected, ignored, or flagged predictably
- no silent corruption

4. History/state behavior

- first call
- repeated call
- reset/re-entry/mode change if relevant

5. Serialization/interface contract

- struct conversion, bus conversion, enum conversion, codegen struct export
- no field-order or semantic mismatch

6. Base/derived substitutability

- abstract parent behavior tested once through dummy subclass
- same parent-owned contract exercised on all real subclasses

7. Cross-path consistency where applicable
   - MATLAB vs MEX
   - MATLAB vs SIL
   - simulation bus vs shared-type conversion path



## Procedure for a new abstract base class

1. implement the abstract base class
2. identify which rules truly belong to the parent class
3. keep shared validation and public contract methods in the parent when possible
4. let subclasses implement only the shape-specific computation hooks
5. create a minimal dummy subclass only for testing
6. write a base contract test that checks only the concrete logic implemented in the abstract parent
7. create one generic derived contract test runner
8. register each real subclass in a dedicated test registry file
9. run the same inherited contract checks on every real subclass

## Procedure for a new concrete subclass

1. implement the concrete subclass
2. implement only the subclass-specific computation hooks and data
3. make sure it correctly forwards base-class constructor inputs when needed
4. add the subclass to the derived-contract registry file
5. run the generic derived contract suite
6. later add subclass-specific unit tests for its own geometry formulas and special behavior

# Practical (wrong) examples
#### Constructor parameter is accepted but not actually applied

What goes wrong:
A class exposes something like Controller(gain, sampleTime, saturationLimit), but one parameter is forgotten during initialization or forwarded in the wrong order. The object is created successfully, most methods run, and simple unit tests on individual math helpers may still pass. But the component is not the one the caller asked for.

Why contract/interface tests catch it first:
A contract test checks object-level guarantees immediately after construction:

- the stored configuration matches the requested inputs
- defaults are explicit
- invalid combinations are rejected
- public behavior reflects the configured parameters

Typical tests:

- Construct with non-default values and verify getters/public behavior reflect those exact values.
- Construct through all supported factory/constructor paths and confirm equivalent configurations behave the same.
- Verify omitted mandatory parameters fail early.

Why unit tests may miss it:
A unit test of computeOutput() might use only default construction or test the formula in isolation, so
the broken initialization path is never exercised.

#### Interface uses valid types but wrong semantics

What goes wrong:
The interface says setAngle(double) or setScale(double), and the code accepts the value, but one side assumes degrees while another assumes radians, or milliseconds vs seconds, meters vs millimeters. Everything compiles, all types match, values are finite, and local algorithm tests can still pass with carefully chosen inputs.

Typical tests:

- Verify documented physical invariants under known reference inputs.
- Verify equivalent inputs expressed through different legitimate API paths produce consistent results.
- Add boundary/representative cases that would clearly diverge if units are wrong.
- Reject out-of-contract values or impossible ranges.

Why unit tests may miss it:
Local algorithm tests often assume the caller already gave correct units. They verify “correct math on provided inputs,” not “correct interpretation of the interface.”

#### Component is correct on first call but breaks the history/state contract

What goes wrong:
A class or module has hidden internal state: initialization flags, cached values, previous-cycle data, mode flags, latched faults. The first call works, but repeated use, reset, re-entry, or mode switching produces incorrect behavior because state was not initialized, cleared, or transitioned correctly.

Why contract/interface tests catch it first:
The contract of many embedded components is not just input/output for one call. It includes lifecycle:

- after construction
- after reset
- after N cycles
- after mode change
- after fault clear
- after reinitialization

Typical tests:

- Verify first-cycle behavior.
- Verify repeated identical calls remain stable when they should.
- Verify reset() truly restores the documented initial state.
- Verify forbidden call sequences fail predictably.
- Verify mode transitions preserve invariants.

Why unit tests may miss it:
File-level tests often exercise one function once with mocked data. They do not model object history or call ordering, which is where embedded software often fails.

# DSW

Situation at 24/03/2026
- docking_software classes: 65
- simulator classes: 40
- shared_types classes: 11

| Family | File Path | Direct Subclasses | Notes |
|--------|-----------|-------------------|-------|
| Logging | `docking_software/lib/logging/LoggingMixIn.m` | 2 | SimpleState, Transition; ~32 total with composite states |
| SimpleState | `docking_software/state_machine/fsm_lib/SimpleState.m` | 13 | 17 with base; 16 descendants through CompositeState |
| Transition | `docking_software/state_machine/fsm_lib/Transition.m` | 14 | 15 with base |
| OutputBusBase | `simulator/buses/OutputBusBase.m` | 8 | — |
| ConfigBase | `simulator/config/ConfigBase.m` | — | Effective family size: 8 |
| FromStructMixIn | `shared_types/FromStructMixIn.m` | 3 | — |
| ToStructMixIn | `shared_types/ToStructMixIn.m` | 1 | — |

## Repository-wide baseline test families

We should not invent tests class by class from intuition. We should define mandatory baseline suites by component family. In this repo, that means at least: FSM state, transition, config, bus, shared-type conversion contracts, and cross-path consistency tests.

Requirements will later add more targeted tests, but these baseline suites must always exist regardless of requirements.

### DSW classes testing proposal

1. SimpleState base contract `SimpleState.m`. Real-subclasses `SyncLarState.m` `PreGraspState.m` ...

Base-class tests through a dummy subclass should verify:

- state_id must not be NONE_STATE_ID
- constructor sets has_valid_configuration correctly
- enter() sets is_active = true only if on_entry() succeeds
- exit() leaves state active if on_exit() fails
- update() fails cleanly when configuration is invalid
- repeated update() calls do not corrupt state


2. Transition base contract `Transition.m`. Real-subclass contracts `PreGraspToGrasp.m` `DockingToAborting.m`.

Base-class tests through a dummy transition should verify:

- transition_id cannot be the protected default
- invalid construction makes evaluate() return errored and not triggered
- valid construction allows evaluation
- evaluate() wrapper preserves deterministic output semantics


3. ConfigBase family `ConfigBase.m`

Baseline tests for each config subclass should verify:

- defaults are explicit
- constructor arguments are applied correctly
- to_codegen_struct() includes expected fields
- string and timeseries are excluded as intended
- seeded configs are reproducible when they should be

example `NavigationConfig.m`

Concrete tests:

- same noise_seed gives same generated seeds and same initial bias values
- default values are stable
- output struct contains the intended codegen-safe properties only

### Note on LoggingMixIn scope

Logging should be tested once at the base level. Then rely on SimpleState and Transition contract tests to exercise it indirectly. This avoids a derived-contract sweep over ~32 classes at the logging level itself.

---

# Current Coverage and Gaps

## What Already Exists

TestState.m, TestTransition.m, and TestCompositeState.m are useful foundation tests for the FSM framework. They already exercise important parent-level behavior, but they are not yet organized as a complete, reusable base-contract plus derived-contract methodology. In other words, they are not churn; they are the starting point for formalization.

### Existing FSM Tests

| Test File | What It Tests | Coverage Type | Gap |
|-----------|---------------|---------------|-----|
| `TestState.m` | Parent-level behavior of generated concrete `SimpleState` implementations | Base-class + happy-path | Missing: invalid state_id, failed lifecycle branches, repeated calls, invalid construction |
| `TestTransition.m` | Parent-level behavior of generated concrete `Transition` implementations | Base-class + unit hybrid | Missing: invalid transition_id, failing on_evaluation paths, derived substitution tests |
| `TestCompositeState.m` | Orchestration/lifecycle behavior of `CompositeState` container | Framework contract + lightweight scenario | Missing: error recovery, complex state progressions, edge cases |

#### Detailed Status

**TestState.m:**
- ✅ Dynamically generates temporary concrete states
- ✅ Tests: `get_name()`, `get_id()`, `is_active` lifecycle, `enter()`/`update()`/`exit()` happy-path
- ❌ Missing: `state_id == NONE_STATE_ID` rejection, failed branch handling, invalid construction detection, repeated-call edge cases

**TestTransition.m:**
- ✅ Tests: constructor parameter storage, `evaluate()` happy-path, instance independence, repeated calls, inheritance verification
- ✅ Blends constructor, inheritance, and behavioral checks
- ❌ Missing: `transition_id == NONE_TRANSITION_ID` rejection, invalid construction with `is_errored = true`, failing `on_evaluation()` semantics, derived real-transition substitution tests

**TestCompositeState.m:**
- ✅ Tests: child state/transition wiring, initial state storage, `has_valid_configuration`, state lifecycle, multi-state progressions
- ✅ Most "integration-like" of the three; tests orchestration semantics
- ❌ Missing: error recovery scenarios, complex failure modes, mode transition edge cases

The existing tests are **good and useful foundations**, but:

- Focused on a few core families (FSM library)
- Mostly happy-path; limited edge-case coverage
- Not consistently split into "base contract" and "derived contract"
- Not applied systematically across all 7+ inheritance families (Logging, SimpleState, Transition, OutputBusBase, ConfigBase, FromStructMixIn, ToStructMixIn)
- Not clearly framed as mandatory baseline policy

**The proposal does not contradict the existing tests. It formalizes and extends them.**
