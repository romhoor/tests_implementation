# Testing Abstract Shapes in MATLAB

This repository shows a simple way to test an abstract base class in MATLAB.

The base class is `Shape`, which cannot be instantiated directly.

`Shape` owns the public contract:

* `getScaleFactor()` and `setScaleFactor()`
* `area()` returns a finite nonnegative scalar
* `perimeter()` returns a finite nonnegative scalar

Concrete subclasses do not implement the public contract directly.
They only implement the protected hooks:

* `computeArea()`
* `computePerimeter()`

This keeps responsibilities in the right place:

* `Shape` validates shared contract rules
* each child class computes only its own geometry

The project separates testing into two layers:

1. base-class behavior tests
2. derived-class contract tests

## Current structure

* `classes_base/` contains shared base classes (the abstract `Shape` class)
* `classes_derived/` contains real concrete shapes (`Square`, `Rectangle`, `Circle`)
* `classes_derived_broken/` contains intentionally wrong subclasses used to demonstrate contract failures
* `tests/tests_base/` contains tests for concrete behavior already implemented in the base class
* `tests/tests_base/dummyShape.m` is a minimal concrete helper used only to instantiate `Shape` in tests
* `tests/tests_base/test_base_contract_Shape.m` tests the concrete behavior implemented directly in `Shape`
* `tests/tests_derived/` contains contract tests for real concrete subclasses
* `tests/tests_derived/test_derived_contract_Shape.m` runs the inherited `Shape` contract checks on all registered concrete subclasses
* `tests/tests_derived/get_derived_shape_contract_cases.m` lists the concrete subclasses that participate in the derived contract tests

## Why `dummyShape` exists

`Shape` is abstract, so it cannot be instantiated directly.

`dummyShape` is the smallest possible concrete subclass:

* it exists only for testing
* it implements `computeArea()` and `computePerimeter()` with trivial return values
* it lets the tests instantiate the parent class indirectly

This means the base tests can focus only on the code that actually exists in
`Shape`, such as:

* constructor behavior
* default scale factor behavior
* getter behavior
* setter behavior
* parent-level validation of `area()` and `perimeter()`

## Base contract tests

`tests/tests_base/test_base_contract_Shape.m` tests only the concrete logic
implemented directly in `Shape`.

These tests do not check real geometry formulas, because those belong to the
concrete subclasses. They do check the public contract that `Shape` itself
owns and validates.

Current base checks include:

* default `ScaleFactor` is `1`
* explicit constructor input is stored correctly
* `getScaleFactor()` returns the stored value
* `setScaleFactor()` updates the object in place
* `area()` accepts a valid finite nonnegative value from the subclass hook
* `perimeter()` accepts a valid finite nonnegative value from the subclass hook

## Derived contract tests

`tests/tests_derived/test_derived_contract_Shape.m` is a parameterized test.
It runs the inherited `Shape` contract checks against every concrete subclass
registered in `tests/tests_derived/get_derived_shape_contract_cases.m`.

Each entry in `get_derived_shape_contract_cases.m` defines:

* how to create a default object
* how to create that object with a chosen scale factor

This keeps the contract test generic while allowing each shape to have its own
constructor signature.

The derived contract tests now also verify the public `Shape` output rules:

* `area()` must return a finite nonnegative scalar
* `perimeter()` must return a finite nonnegative scalar

## Adding or removing a concrete shape

When a new concrete subclass is added:

1. implement the class in `classes_derived/`
2. add one entry to `tests/tests_derived/get_derived_shape_contract_cases.m`

When a concrete subclass is removed:

1. remove its class file
2. remove its entry from `tests/tests_derived/get_derived_shape_contract_cases.m`

The generic derived contract test file does not need to be changed for each
new shape.

## Why this design is useful

This setup follows a simple rule: put shared rules where they belong.

So:

* `Shape` checks shared output rules once
* subclasses only compute shape-specific values
* the tests verify both the parent contract and the subclass substitution behavior

## Running the tests

Run all current contract tests from the project root in MATLAB:

```matlab
clear classes
rehash
results = runtests({'tests/tests_base/test_base_contract_Shape.m', ...
                    'tests/tests_derived/test_derived_contract_Shape.m'});
table(results)
```

Show the compact textual summary:

```matlab
clear classes
rehash
results = runtests({'tests/tests_base/test_base_contract_Shape.m', ...
                    'tests/tests_derived/test_derived_contract_Shape.m'});
disp(results)
```

Run only the base-class contract tests:

```matlab
clear classes
rehash
results = runtests('tests/tests_base/test_base_contract_Shape.m');
table(results)
```

Show only the failing base-class tests, if any:

```matlab
failedResults = results([results.Failed]);
table(failedResults)
```

Run only the derived-class contract tests:

```matlab
clear classes
rehash
results = runtests('tests/tests_derived/test_derived_contract_Shape.m');
table(results)
```

Show only the failing derived-class tests, if any:

```matlab
failedResults = results([results.Failed]);
table(failedResults)
```
