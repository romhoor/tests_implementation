I would use these meanings consistently:

- base = tests of logic implemented in the abstract/base class itself
- contract = tests that every real subclass must satisfy
- unit = tests of one concrete real class/function’s own behavior
- integration = tests of multiple components working together

- fixture = test-only support code
- dummy = minimal concrete class used only to instantiate an abstract parent
- stub = fixed-answer collaborator
- mock = controllable test class with custom behavior for exercising branches / observe calls / interactions or simulate collaborators


FOLDERS STRUCTURE
## project tree in tests/

I would not fully mirror the whole production tree 1:1. That usually becomes ugly and bureaucratic.
Instead, I propose a hybrid structure:

- mirror the codebase only at the component boundary
- then organize by test intent

So:
- first: what production area am I testing?
- second: what kind of test is this?

## Good rule

Mirror only enough of the project structure so a human can answer:
- “what code area does this test belong to?”

After that, switch to semantic folders like:
- base_contract
- contract
- unit
- integration
- stubs
- fixtures
- mocks

# !! Stubs/Fixtures/Mocks for now have a not very clear intent. they might be used everywhere between contract and intehgation tests.

For the FSM area, I would do something like this:

tests/
    docking_software/
    fsm_lib/
        fixtures/
        DummySimpleState.m
        DummyTransition.m
        DummyCompositeState.m
        FakeSimpleStateFailEntry.m
        FakeSimpleStateFailUpdate.m
        FakeSimpleStateFailExit.m
        FakeTransitionTriggered.m
        FakeTransitionNotTriggered.m

        base_contract/
        TestSimpleStateBaseContract.m
        TestTransitionBaseContract.m
        TestCompositeStateBaseContract.m

    fsm/
        fixtures/
        get_simple_state_contract_cases.m
        get_transition_contract_cases.m
        get_composite_state_contract_cases.m

        contract/
        TestSimpleStateContract.m
        TestTransitionContract.m
        TestCompositeStateContract.m

        unit/
        TestSyncLarState.m
        TestReachLarState.m
        TestPreGraspState.m
        TestGraspState.m
        TestSyncLarToReachLar.m
        TestSyncLarToDockingFailing.m
        TestDockingSoftware.m

        integration/
        TestIntegratedDSWOpenLoop.m
        TestIntegratedMockInLoopAllTests.m

        framework/
        TestDSWTestCaseBase.m
        TestDSWStateTestCase.m
        TestDSWTransitionTestCase.m
