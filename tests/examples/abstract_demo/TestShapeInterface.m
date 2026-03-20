classdef TestShapeInterface < matlab.unittest.TestCase
    %TESTSHAPE
    %
    % Unit tests for the abstract hierarchy.
    %
    % Main testing idea:
    %   - we do NOT instantiate the abstract superclass directly
    %   - we inspect its metadata
    %   - we test inherited concrete behavior through a tiny concrete subclass
    %
    % Current contract note:
    %   Shape declares Name as an abstract scalar string property.
    %   TestRectangle provides only the concrete value for Name, because
    %   MATLAB does not support repeating validation syntax on the subclass
    %   implementation of an inherited abstract property.

    methods (Test)
        function superclassIsMarkedAbstract(testCase)
            %SUPERCLASSISMARKEDABSTRACT
            %
            % MATLAB metadata lets us check the class definition itself.

            mc = ?Shape;

            testCase.verifyTrue( ...
                mc.Abstract, ...
                "The superclass should be abstract.");
        end

        function abstractContractContainsExpectedMembers(testCase)
            %ABSTRACTCONTRACTCONTAINSEXPECTEDMEMBERS
            %
            % Verify the interface from both sides together:
            %   - Shape is abstract and declares the abstract contract
            %   - TestRectangle is concrete and declares the expected
            %     concrete members that realize that contract

            parentMeta = ?Shape;
            childMeta = ?TestRectangle;

            testCase.verifyTrue( ...
                parentMeta.Abstract, ...
                "Shape should be abstract.");

            testCase.verifyFalse( ...
                childMeta.Abstract, ...
                "TestRectangle should be concrete.");

            abstractPropertyNames = string( ...
                {parentMeta.PropertyList([parentMeta.PropertyList.Abstract]).Name});
            abstractMethodNames = string( ...
                {parentMeta.MethodList([parentMeta.MethodList.Abstract]).Name});

            abstractNames = sort([abstractPropertyNames, abstractMethodNames]);

            expectedAbstractNames = sort(["Name", "area", "perimeter"]);

            testCase.verifyEqual( ...
                abstractNames, ...
                expectedAbstractNames, ...
                "Shape abstract members do not match the intended contract.");

            childPropertyNames = string({childMeta.PropertyList.Name});

            testCase.verifyTrue( ...
                ismember("Name", childPropertyNames), ...
                "TestRectangle should expose Name.");
            testCase.verifyTrue( ...
                ismember("Width", childPropertyNames), ...
                "TestRectangle should expose Width.");
            testCase.verifyTrue( ...
                ismember("Height", childPropertyNames), ...
                "TestRectangle should expose Height.");

            testCase.verifyTrue( ...
                ismethod("TestRectangle", "area"), ...
                "TestRectangle should implement area().");
            testCase.verifyTrue( ...
                ismethod("TestRectangle", "perimeter"), ...
                "TestRectangle should implement perimeter().");
            testCase.verifyTrue( ...
                ismethod("TestRectangle", "scaleBy"), ...
                "TestRectangle should inherit scaleBy().");
            testCase.verifyTrue( ...
                ismethod("TestRectangle", "summary"), ...
                "TestRectangle should inherit summary().");
        end

        function concreteSubclassImplementsTheContract(testCase)
            %CONCRETESUBCLASSIMPLEMENTSTHECONTRACT
            %
            % Smoke test:
            % If construction and core calls succeed, the subclass is at least
            % providing the required concrete pieces of the contract.

            r = TestRectangle(2, 3);

            testCase.verifyEqual(r.Name, "rectangle");
            testCase.verifyEqual(r.area(), 6);
            testCase.verifyEqual(r.perimeter(), 10);
        end

        function inheritedScaleStartsAtIdentity(testCase)
            %INHERITEDSCALESTARTSATIDENTITY
            %
            % Shared concrete state belongs to the superclass and is inherited
            % unchanged by the concrete subclass.

            r = TestRectangle(2, 3);

            testCase.verifyEqual(r.ScaleFactor, 1);
        end

        function inheritedScaleMethodChangesGeometry(testCase)
            %INHERITEDSCALEMETHODCHANGESGEOMETRY
            %
            % Original:
            %   width  = 2
            %   height = 3
            %   area   = 6
            %   perim  = 10
            %
            % After scaleBy(2):
            %   width  = 4
            %   height = 6
            %   area   = 24
            %   perim  = 20

            r = TestRectangle(2, 3);
            r = r.scaleBy(2);

            testCase.verifyEqual(r.ScaleFactor, 2);
            testCase.verifyEqual(r.area(), 24);
            testCase.verifyEqual(r.perimeter(), 20);
        end

        function inheritedTemplateMethodUsesSubclassImplementation(testCase)
            %INHERITEDTEMPLATEMETHODUSESSUBCLASSIMPLEMENTATION
            %
            % isAreaAtLeast() is implemented once in the superclass,
            % but it depends on area(), which is implemented by the subclass.
            % This is the key inherited-template-method behavior in the demo.

            r = TestRectangle(2, 3);

            testCase.verifyTrue(r.isAreaAtLeast(6));
            testCase.verifyTrue(r.isAreaAtLeast(5.99));
            testCase.verifyFalse(r.isAreaAtLeast(6.01));
        end

        function summaryCombinesAbstractAndConcretePieces(testCase)
            %SUMMARYCOMBINESABSTRACTANDCONCRETEPIECES
            %
            % summary() pulls together:
            %   - subclass property   -> Name
            %   - superclass property -> ScaleFactor
            %   - subclass methods    -> area, perimeter
            %
            % That makes it a good integration check for the full hierarchy.

            r = TestRectangle(2, 3);
            r = r.scaleBy(2);

            txt = r.summary();

            testCase.verifyClass(txt, "string");
            testCase.verifyTrue(contains(txt, "rectangle"));
            testCase.verifyTrue(contains(txt, "ScaleFactor=2"));
            testCase.verifyTrue(contains(txt, "Area=24"));
            testCase.verifyTrue(contains(txt, "Perimeter=20"));
        end

        function constructorRejectsBadWidth(testCase)
            %CONSTRUCTORREJECTSBADWIDTH
            %
            % Negative-path test:
            % verifyError expects a function handle.

            testCase.verifyError( ...
                @() TestRectangle(0, 3), ...
                "TestRectangle:InvalidWidth");
        end

        function constructorRejectsBadHeight(testCase)
            %CONSTRUCTORREJECTSBADHEIGHT
            %
            % Same idea for the second dimension.

            testCase.verifyError( ...
                @() TestRectangle(2, -1), ...
                "TestRectangle:InvalidHeight");
        end

        function scaleRejectsInvalidFactor(testCase)
            %SCALEREJECTSINVALIDFACTOR
            %
            % We first create a valid object, then verify the inherited method
            % rejects an invalid scale factor.

            r = TestRectangle(2, 3);

            testCase.verifyError( ...
                @() r.scaleBy(0), ...
                "Shape:InvalidScaleFactor");
        end

        function thresholdRejectsNegativeInput(testCase)
            %THRESHOLDREJECTSNEGATIVEINPUT
            %
            % Public API validation on another inherited superclass method.

            r = TestRectangle(2, 3);

            testCase.verifyError( ...
                @() r.isAreaAtLeast(-1), ...
                "Shape:InvalidAreaThreshold");
        end

        function valueClassBehaviorIsVisible(testCase)
            %VALUECLASSBEHAVIORISVISIBLE
            %
            % Since the class hierarchy does not inherit from handle,
            % assignment copies the value object semantics.
            %
            % Therefore:
            %   r1 stays unchanged
            %   r2 becomes the scaled one

            r1 = TestRectangle(2, 3);
            r2 = r1;

            r2 = r2.scaleBy(2);

            testCase.verifyEqual(r1.area(), 6);
            testCase.verifyEqual(r2.area(), 24);
        end
    end
end
