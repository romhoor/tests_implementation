classdef TestSquareUnit < matlab.unittest.TestCase
    %TESTSQUAREUNIT Focused unit tests for shapes.derived.Square.

    properties (TestParameter)
        invalidSide = {0, -1, NaN, Inf, -Inf, 1 + 2i, [1 2], "bad"}
        validScaleFactor = {0.25, 2, 3, 8}
        invalidScaleFactor = {0, -1, NaN, Inf, [1 2], "bad"}
        invalidThreshold = {-1, -0.1, NaN, Inf, [1 2], "bad"}
    end

    methods (Test)
        function defaultConstructorBuildsUnitSquare(testCase)
            s = shapes.derived.Square();

            testCase.verifyEqual(s.Name, "square");
            testCase.verifyEqual(s.Side, 1);
            testCase.verifyEqual(s.ScaleFactor, 1);
            testCase.verifyEqual(s.area(), 1);
            testCase.verifyEqual(s.perimeter(), 4);
        end

        function constructorStoresProvidedSide(testCase)
            s = shapes.derived.Square(2.5);

            testCase.verifyEqual(s.Side, 2.5);
            testCase.verifyEqual(s.area(), 6.25);
            testCase.verifyEqual(s.perimeter(), 10);
        end

        function constructorRejectsWrongArity(testCase)
            testCase.verifyError( ...
                @() shapes.derived.Square(1, 2), ...
                "shapes:Square:ConstructorArity");
        end

        function constructorRejectsInvalidSide(testCase, invalidSide)
            testCase.verifyError( ...
                @() shapes.derived.Square(invalidSide), ...
                "shapes:Square:InvalidSide");
        end

        function scaleByUpdatesGeometry(testCase, validScaleFactor)
            s = shapes.derived.Square(2);
            scaled = s.scaleBy(validScaleFactor);

            testCase.verifyEqual(scaled.ScaleFactor, validScaleFactor, "AbsTol", 1e-12);
            testCase.verifyEqual(scaled.area(), 4 * validScaleFactor ^ 2, "AbsTol", 1e-12);
            testCase.verifyEqual(scaled.perimeter(), 8 * validScaleFactor, "AbsTol", 1e-12);
            testCase.verifyEqual(s.area(), 4);
        end

        function repeatedScalingCompoundsMultiplicatively(testCase)
            s = shapes.derived.Square(2);
            s = s.scaleBy(3);
            s = s.scaleBy(0.5);
            s = s.scaleBy(4);

            testCase.verifyEqual(s.ScaleFactor, 6, "AbsTol", 1e-12);
            testCase.verifyEqual(s.area(), 144, "AbsTol", 1e-12);
            testCase.verifyEqual(s.perimeter(), 48, "AbsTol", 1e-12);
        end

        function resetScaleRestoresOriginalGeometry(testCase)
            s = shapes.derived.Square(2);
            scaled = s.scaleBy(5);
            reset = scaled.resetScale();

            testCase.verifyEqual(reset.ScaleFactor, 1);
            testCase.verifyEqual(reset.area(), 4);
            testCase.verifyEqual(reset.perimeter(), 8);
            testCase.verifyEqual(scaled.area(), 100);
        end

        function scaleByRejectsInvalidFactor(testCase, invalidScaleFactor)
            s = shapes.derived.Square(2);

            testCase.verifyError( ...
                @() s.scaleBy(invalidScaleFactor), ...
                "shapes:Shape:InvalidScaleFactor");
        end

        function isAreaAtLeastUsesScaledArea(testCase)
            s = shapes.derived.Square(2);
            scaled = s.scaleBy(3);

            testCase.verifyTrue(s.isAreaAtLeast(4));
            testCase.verifyFalse(s.isAreaAtLeast(4.01));
            testCase.verifyTrue(scaled.isAreaAtLeast(36));
            testCase.verifyFalse(scaled.isAreaAtLeast(36.01));
        end

        function isAreaAtLeastRejectsInvalidThreshold(testCase, invalidThreshold)
            s = shapes.derived.Square(2);

            testCase.verifyError( ...
                @() s.isAreaAtLeast(invalidThreshold), ...
                "shapes:Shape:InvalidAreaThreshold");
        end

        function summaryReflectsCurrentGeometry(testCase)
            s = shapes.derived.Square(2);
            s = s.scaleBy(1.5);
            txt = s.summary();

            testCase.verifyClass(txt, "string");
            testCase.verifyTrue(contains(txt, "Shape=square"));
            testCase.verifyTrue(contains(txt, "ScaleFactor=1.5"));
            testCase.verifyTrue(contains(txt, "Area=9"));
            testCase.verifyTrue(contains(txt, "Perimeter=12"));
        end

        function assignmentCopyPreservesValueSemantics(testCase)
            original = shapes.derived.Square(2);
            copy = original;
            copy = copy.scaleBy(4);

            testCase.verifyEqual(original.ScaleFactor, 1);
            testCase.verifyEqual(original.area(), 4);
            testCase.verifyEqual(copy.ScaleFactor, 4);
            testCase.verifyEqual(copy.area(), 64);
        end
    end
end
