classdef TestShapeSquareInterface < matlab.unittest.TestCase
    %TESTSHAPESQUAREINTERFACE
    %
    % Tests for the abstract Shape hierarchy using a square subclass.
    %
    % The suite mixes:
    %   - metadata checks on the parent class contract
    %   - runtime checks through a tiny concrete square subclass

    methods (Test)
        function abstractContractContainsExpectedMembers(testCase)
            %ABSTRACTCONTRACTCONTAINSEXPECTEDMEMBERS
            %
            % Verify the interface from both sides together:
            %   - Shape is abstract and declares the abstract contract
            %   - TestSquare is concrete and declares the expected
            %     concrete members that realize that contract

            parentMeta = ?Shape;
            childMeta = ?TestSquare;

            testCase.verifyTrue( ...
                parentMeta.Abstract, ...
                "Shape should be abstract.");

            testCase.verifyFalse( ...
                childMeta.Abstract, ...
                "TestSquare should be concrete.");

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
                "TestSquare should expose Name.");
            testCase.verifyTrue( ...
                ismember("Side", childPropertyNames), ...
                "TestSquare should expose Side.");

            testCase.verifyTrue( ...
                ismethod("TestSquare", "area"), ...
                "TestSquare should implement area().");
            testCase.verifyTrue( ...
                ismethod("TestSquare", "perimeter"), ...
                "TestSquare should implement perimeter().");
            testCase.verifyTrue( ...
                ismethod("TestSquare", "scaleBy"), ...
                "TestSquare should inherit scaleBy().");
            testCase.verifyTrue( ...
                ismethod("TestSquare", "summary"), ...
                "TestSquare should inherit summary().");
        end

        function concreteSubclassImplementsTheContract(testCase)
            %CONCRETESUBCLASSIMPLEMENTSTHECONTRACT
            %
            % Construction and core calls show the subclass supplies the
            % concrete pieces required by Shape.

            s = TestSquare(2);

            testCase.verifyEqual(s.Name, "square");
            testCase.verifyEqual(s.area(), 4);
            testCase.verifyEqual(s.perimeter(), 8);
        end

        function inheritedScaleStartsAtIdentity(testCase)
            %INHERITEDSCALESTARTSATIDENTITY
            %
            % Shared superclass state is inherited by the concrete subclass.

            s = TestSquare(2);

            testCase.verifyEqual(s.ScaleFactor, 1);
        end

        function inheritedScaleMethodChangesGeometry(testCase)
            %INHERITEDSCALEMETHODCHANGESGEOMETRY
            %
            % Original:
            %   side  = 2
            %   area  = 4
            %   perim = 8
            %
            % After scaleBy(3):
            %   side  = 6
            %   area  = 36
            %   perim = 24

            s = TestSquare(2);
            s = s.scaleBy(3);

            testCase.verifyEqual(s.ScaleFactor, 3);
            testCase.verifyEqual(s.area(), 36);
            testCase.verifyEqual(s.perimeter(), 24);
        end

        function inheritedTemplateMethodUsesSubclassImplementation(testCase)
            %INHERITEDTEMPLATEMETHODUSESSUBCLASSIMPLEMENTATION
            %
            % isAreaAtLeast() is inherited from Shape but uses the square
            % subclass implementation of area().

            s = TestSquare(2);

            testCase.verifyTrue(s.isAreaAtLeast(4));
            testCase.verifyTrue(s.isAreaAtLeast(3.99));
            testCase.verifyFalse(s.isAreaAtLeast(4.01));
        end

        function summaryCombinesAbstractAndConcretePieces(testCase)
            %SUMMARYCOMBINESABSTRACTANDCONCRETEPIECES
            %
            % summary() integrates inherited state with square-specific
            % values returned through the abstract contract.

            s = TestSquare(2);
            s = s.scaleBy(3);

            txt = s.summary();

            testCase.verifyClass(txt, "string");
            testCase.verifyTrue(contains(txt, "square"));
            testCase.verifyTrue(contains(txt, "ScaleFactor=3"));
            testCase.verifyTrue(contains(txt, "Area=36"));
            testCase.verifyTrue(contains(txt, "Perimeter=24"));
        end

        function constructorRejectsBadSide(testCase)
            %CONSTRUCTORREJECTSBADSIDE
            %
            % Negative-path validation for the square side length.

            testCase.verifyError( ...
                @() TestSquare(0), ...
                "TestSquare:InvalidSide");
        end

        function scaleRejectsInvalidFactor(testCase)
            %SCALEREJECTSINVALIDFACTOR
            %
            % Inherited validation still applies through the concrete object.

            s = TestSquare(2);

            testCase.verifyError( ...
                @() s.scaleBy(0), ...
                "Shape:InvalidScaleFactor");
        end

        function thresholdRejectsNegativeInput(testCase)
            %THRESHOLDREJECTSNEGATIVEINPUT
            %
            % Another inherited API validation check.

            s = TestSquare(2);

            testCase.verifyError( ...
                @() s.isAreaAtLeast(-1), ...
                "Shape:InvalidAreaThreshold");
        end

        function valueClassBehaviorIsVisible(testCase)
            %VALUECLASSBEHAVIORISVISIBLE
            %
            % Value-class copying means the original object stays unchanged
            % when the copied value is reassigned after scaling.

            s1 = TestSquare(2);
            s2 = s1;

            s2 = s2.scaleBy(3);

            testCase.verifyEqual(s1.area(), 4);
            testCase.verifyEqual(s2.area(), 36);
        end
    end
end
