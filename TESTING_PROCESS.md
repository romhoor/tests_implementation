# Testing Process for Abstract and Inherited Classes

This document describes the testing procedure used in this repository for
abstract base classes and their concrete subclasses.

## Main idea

When a base class is abstract, two different testing questions appear:

1. does the concrete code already implemented in the abstract base class work correctly?
2. do the real concrete subclasses actually satisfy that inherited base-class contract?

These two questions are related, but they are not the same test target.

## Step 1. Test the abstract base class through a dummy subclass

An abstract class cannot be instantiated directly.
Because of that, the base class must be tested indirectly through a minimal
dummy concrete subclass created only for testing.

Purpose of the dummy subclass:

* make the abstract parent instantiable
* implement abstract methods with trivial bodies only
* avoid mixing base-class tests with real geometry logic

In this repository:

* the abstract base class is `Shape`
* the dummy helper class is `tests/tests_base/dummyShape.m`

The base contract test file is:

* `tests/tests_base/test_base_contract_Shape.m`

That file should test only the concrete behavior implemented directly in the
abstract parent.

Examples:

* constructor behavior
* default values
* getter behavior
* setter behavior

It should not test subclass-specific formulas such as real `area()` or
`perimeter()` logic, because those do not belong to the abstract parent.

## Step 2. Test the inherited contract on real concrete subclasses

After the base-class behavior is verified, the same inherited contract should
be checked on every real concrete subclass.

Purpose of these tests:

* confirm that concrete subclasses still respect the inherited base-class behavior
* verify that constructor forwarding is correct
* verify that inherited getters and setters still behave correctly on real objects

In this repository:

* the derived contract test file is `tests/tests_derived/test_derived_contract_Shape.m`
* the list of participating concrete subclasses is defined in `tests/tests_derived/get_derived_shape_contract_cases.m`

This means the derived contract tests do not need one separate test file per
shape. Instead, the generic contract runner is reused for all registered
subclasses.

## Important distinction

The base contract test and the derived contract test may contain very similar
assertions, but they do not mean the same thing.

Base contract test:

* target = the abstract parent implementation itself
* helper object = dummy subclass

Derived contract test:

* target = every real concrete subclass
* helper object = real subclass instance

So even when the checks look almost identical, the test intention is different.

## Current project mapping

* `classes_base/Shape.m` = abstract parent class
* `tests/tests_base/dummyShape.m` = minimal helper subclass for base testing
* `tests/tests_base/test_base_contract_Shape.m` = tests for concrete behavior implemented in `Shape`
* `classes_derived/Square.m`, `classes_derived/Rectangle.m`, `classes_derived/Circle.m` = real concrete subclasses
* `tests/tests_derived/test_derived_contract_Shape.m` = generic inherited-contract test for all registered real subclasses
* `tests/tests_derived/get_derived_shape_contract_cases.m` = registry of concrete subclasses used in the derived contract suite

## Procedure for a new abstract base class

1. implement the abstract base class
2. identify which methods or properties already contain real concrete logic
3. create a minimal dummy subclass only for testing
4. write a base contract test that checks only the concrete logic implemented in the abstract parent
5. create one generic derived contract test runner
6. register each real subclass in a dedicated test registry file
7. run the same inherited contract checks on every real subclass

## Procedure for a new concrete subclass

1. implement the concrete subclass
2. make sure it correctly forwards base-class constructor inputs when needed
3. add the subclass to the derived-contract registry file
4. run the generic derived contract suite
5. later add subclass-specific unit tests for its own geometry formulas and special behavior

## Running the current tests

Run all current contract tests:

```matlab
clear classes
rehash
results = runtests({'tests/tests_base/test_base_contract_Shape.m', ...
                    'tests/tests_derived/test_derived_contract_Shape.m'});
table(results)
```
