# Testing Process for Abstract and Inherited Classes

This document describes the testing procedure used in this repository for
abstract base classes and their concrete subclasses.

## Main idea

When a base class is abstract, two different testing questions appear:

1. does the concrete code already implemented in the abstract base class work correctly?
2. do the real concrete subclasses actually satisfy that inherited base-class contract?

These two questions are related, but they are not the same test target.

In this repository, shared rules are kept in the parent class whenever they
truly belong to the parent.

That means:

* `Shape` owns the public `area()` and `perimeter()` methods
* `Shape` validates shared output rules such as finite nonnegative scalar results
* each child class implements only `computeArea()` and `computePerimeter()`

## Step 1. Test the abstract base class through a dummy subclass

An abstract class cannot be instantiated directly.
Because of that, the base class must be tested indirectly through a minimal
dummy concrete subclass created only for testing.

Purpose of the dummy subclass:

* make the abstract parent instantiable
* implement the protected abstract computation hooks with trivial bodies only
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
* shared validation owned by the abstract parent

It should not test subclass-specific formulas such as square area formulas or
circle perimeter formulas, because those do not belong to the abstract parent.

## Step 2. Test the inherited contract on real concrete subclasses

After the base-class behavior is verified, the same inherited contract should
be checked on every real concrete subclass.

Purpose of these tests:

* confirm that concrete subclasses still respect the inherited base-class behavior
* verify that constructor forwarding is correct
* verify that inherited getters and setters still behave correctly on real objects
* verify that each real subclass satisfies the parent-owned public contract

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
* focus = parent-owned behavior and validation

Derived contract test:

* target = every real concrete subclass
* helper object = real subclass instance
* focus = substitution: each child must behave like a valid `Shape`

So even when the checks look almost identical, the test intention is different.

## Liskov substitution view

These derived contract tests are also a practical way to think about the
Liskov Substitution Principle.

### Definition

A subtype should be usable anywhere its base type is expected, without
breaking the correctness of the program.

### Behavioral substitutability

For this to be true:

* a subclass should be able to replace the base class in client code
* program behavior should remain correct after substitution
* substitution should not introduce unexpected behavior changes
* client code should not need special knowledge of the concrete subtype

### Contract requirements

The subtype must respect the contract of the parent type:

* it must not require more than the parent requires
* it must not promise less than the parent promises
* it must preserve parent invariants
* it must not violate the expected object-history behavior

In shorter terms:

* preconditions cannot be strengthened
* postconditions cannot be weakened
* invariants must be preserved
* history constraints must be respected

### What the tests mean

For this project, the practical substitution test is:

* if `S` is a subtype of `Shape`
* then an object of type `Shape` should be replaceable by an object of type `S`
* without breaking the parent-level expectations

That is exactly why the derived contract suite exists.
It checks that each real subclass still behaves like a valid `Shape`, not
just like a MATLAB class with the right method names.

This also applies to indirect descendants.

For example, if a class inherits from `Square`, and `Square` already inherits
from `Shape`, then that new class should still be tested against the `Shape`
contract. The contract belongs to the full subtype chain, not only to the
direct children of the abstract parent.

## Current project mapping

* `classes_base/Shape.m` = abstract parent class
* `tests/tests_base/dummyShape.m` = minimal helper subclass for base testing
* `tests/tests_base/test_base_contract_Shape.m` = tests for concrete behavior implemented in `Shape`
* `classes_derived/Square.m`, `classes_derived/Rectangle.m`, `classes_derived/Circle.m` = real concrete subclasses
* `classes_derived_broken/BrokenSquare.m` = intentionally wrong subclass used to demonstrate contract failures
* `tests/tests_derived/test_derived_contract_Shape.m` = generic inherited-contract test for all registered real subclasses
* `tests/tests_derived/get_derived_shape_contract_cases.m` = registry of concrete subclasses used in the derived contract suite

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

## Running the current tests

Run all current contract tests:

```matlab
clear classes
rehash
results = runtests({'tests/tests_base/test_base_contract_Shape.m', ...
                    'tests/tests_derived/test_derived_contract_Shape.m'});
table(results)
```
