# Testing an Abstract Base Class in MATLAB

## Core idea

When a class is abstract, you usually cannot instantiate it directly.
That means you cannot test it as a normal object.
Instead, you test two different things:

1. the **concrete behavior already implemented in the abstract base class**
2. the **contract that future subclasses must satisfy**

---

## What can be tested immediately

If the abstract base class already contains real code, that code can be tested now.
Typical examples are:

* constructor logic
* property validation
* setters and getters
* shared utility methods
* common invariant checks

Since the base class is abstract, these tests are usually executed through a very small **dummy concrete subclass** created only for testing.

---

## Why a dummy subclass is useful

A dummy subclass is a minimal concrete class that implements the abstract methods with trivial bodies.
Its purpose is not to test real geometry or real business logic.
Its purpose is simply to let the test instantiate the abstract parent and exercise the parent code.

This is especially useful when the parent already contains implemented behavior such as a `ScaleFactor` property, validation rules, or shared methods.

---

## Example: `Shape`

Suppose `Shape` is abstract and defines:

* `area(obj)` as abstract
* `perimeter(obj)` as abstract
* a concrete `ScaleFactor`
* a concrete constructor or setter for the scale

Then:

* `area` and `perimeter` cannot be meaningfully tested yet if no real subclasses exist
* `ScaleFactor` behavior can already be tested now

Examples of tests that make sense immediately:

* default scale factor is correct
* valid scale values are accepted
* invalid values are rejected
* getter returns the stored value
* setter updates the value correctly

---

## Contract tests for future subclasses

Even if `Triangle` and `Rectangle` do not exist yet, the expected contract can already be written down.

For example, future subclasses of `Shape` may be required to satisfy rules such as:

* `area()` returns a finite scalar
* `area()` is nonnegative
* `perimeter()` returns a finite scalar
* `perimeter()` is nonnegative
* scaling by factor `k` changes area and perimeter consistently

These tests may be prepared now, but they become truly useful once real subclasses exist.

---

## Recommended test split

A clean structure is:

### 1. Base behavior tests

Test the concrete code already present in the abstract parent.
Use a dummy subclass.

Implementation idea:

* create one minimal concrete subclass such as `dummyShape`
* let that dummy implement abstract methods with trivial return values only
* use it only to instantiate `Shape`
* test only inherited behavior here: constructor, default values, setter, getter

### 2. Contract tests

Write reusable tests that every future real subclass must pass.

Implementation idea:

* these tests describe what all real `Shape` subclasses must satisfy
* examples: `area()` returns a finite nonnegative scalar, `perimeter()` returns a finite nonnegative scalar
* run the same contract checks on `Rectangle`, `Triangle`, and every other real subclass later

### 3. Concrete subclass tests

Once `Triangle`, `Rectangle`, and others exist, test their specific formulas and behavior.

Implementation idea:

* test only subclass-specific logic here
* examples: rectangle area formula, triangle perimeter formula, scaling rules specific to that class

---

## Practical rule

When writing an abstract base class, ask:

* **What code exists already?** → test it now with a dummy subclass.
* **What promises does this base class make?** → write contract tests for future subclasses.

For the current `Shape` example:

* `dummyShape` exists only to make the abstract parent instantiable in tests
* `test_base_contract_Shape` should test only the concrete behavior already implemented in `Shape`
* it should not test real geometry formulas, because those belong to future concrete subclasses

---

## Current directories architecture

* `classes_base/` contains abstract or shared base classes such as `Shape`
* `classes_derived/` contains real concrete subclasses such as `Square`
* `tests/tests_base/` contains tests for base-class behavior and helper classes used only for testing
* `tests/tests_base/test_base_contract_Shape.m` is the base-contract test file for the concrete behavior implemented in `Shape`
* `tests/tests_base/dummyShape.m` is the minimal concrete helper class used only to instantiate `Shape` during tests
* `tests/tests_derived/` is the place for tests of real subclasses such as `Square`
* `tests/tests_derived/test_derived_contract_Shape.m` is a parameterized test that runs the inherited `Shape` contract checks on every listed concrete subclass
* `tests/tests_derived/get_derived_shape_contract_cases.m` is the file to update when a concrete subclass is added or removed
* each field in `get_derived_shape_contract_cases.m` defines how that subclass is constructed for contract testing
* each field name in `get_derived_shape_contract_cases.m` becomes a separate reported shape case in the test results

---

## Short summary

For an abstract class in MATLAB:

* test its existing concrete behavior now
* use a tiny dummy subclass to instantiate it indirectly
* define the behavioral contract that all future subclasses must satisfy
* run that contract suite later on every real subclass
