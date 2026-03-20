# Testing Abstract Shapes in MATLAB

This repository shows a simple way to test an abstract base class in MATLAB.

The base class is `Shape`, which cannot be instantiated directly because it
declares the abstract methods `area(obj)` and `perimeter(obj)`.

The project separates testing into two layers:

1. base-class behavior tests
2. derived-class contract tests

## Current structure

* `classes_base/` contains shared base classes (the abstract `Shape` class)
* `classes_derived/` contains real concrete shapes (`Square`, `Rectangle`, `Circle`)
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
* it implements `area()` and `perimeter()` with trivial return values
* it lets the tests instantiate the parent class indirectly

This means the base tests can focus only on the code that actually exists in
`Shape`, such as:

* constructor behavior
* default scale factor behavior
* getter behavior
* setter behavior

## Base contract tests

`tests/tests_base/test_base_contract_Shape.m` tests only the concrete logic
implemented directly in `Shape`.

These tests do not check geometry formulas, because `Shape` does not implement
them.

Current base checks include:

* default `ScaleFactor` is `1`
* explicit constructor input is stored correctly
* `getScaleFactor()` returns the stored value
* `setScaleFactor()` updates the object in place

## Derived contract tests

`tests/tests_derived/test_derived_contract_Shape.m` is a parameterized test.
It runs the inherited `Shape` contract checks against every concrete subclass
registered in `tests/tests_derived/get_derived_shape_contract_cases.m`.

Each entry in `get_derived_shape_contract_cases.m` defines:

* how to create a default object
* how to create that object with a chosen scale factor

This keeps the contract test generic while allowing each shape to have its own
constructor signature.

## Adding or removing a concrete shape

When a new concrete subclass is added:

1. implement the class in `classes_derived/`
2. add one entry to `tests/tests_derived/get_derived_shape_contract_cases.m`

When a concrete subclass is removed:

1. remove its class file
2. remove its entry from `tests/tests_derived/get_derived_shape_contract_cases.m`

The generic derived contract test file does not need to be changed for each
new shape.

## Running the tests

Run all current contract tests from the project root in MATLAB:

```matlab
clear classes
rehash
results = runtests({'tests/tests_base/test_base_contract_Shape.m', ...
                    'tests/tests_derived/test_derived_contract_Shape.m'});
table(results)
```

Run only the base-class contract tests:

```matlab
clear classes
rehash
results = runtests('tests/tests_base/test_base_contract_Shape.m');
table(results)
```

Run only the derived-class contract tests:

```matlab
clear classes
rehash
results = runtests('tests/tests_derived/test_derived_contract_Shape.m');
table(results)
```
