  I would use these meanings consistently:

  - base = tests of logic implemented in the abstract/base class itself
  - contract = tests that every real subclass must satisfy
  - unit = tests of one concrete real class/function’s own behavior
  - integration = tests of multiple components working together
  - fixture or helper = test-only support code
  - dummy = minimal concrete class used only to instantiate an abstract parent
  - mock = controllable test class with custom behavior for exercising branches / observe calls / interactions or simulate collaborators