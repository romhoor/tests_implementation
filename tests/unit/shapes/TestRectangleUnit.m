classdef TestRectangleUnit < matlab.unittest.TestCase
    %TESTRECTANGLEUNIT Focused unit tests for shapes.derived.Rectangle.

    properties (TestParameter)
        invalidWidth = {0, -1, NaN, Inf, -Inf, 1 + 2i, [1 2], "bad"}
        invalidHeight = {0, -1, NaN, Inf, -Inf, 1 + 2i, [1 2], "bad"}
        validScaleFactor = {0.5, 2, 3.25, 10}
        invalidScaleFactor = {0, -1, NaN, Inf, [1 2], "bad"}
        invalidThreshold = {-1, -0.01, NaN, Inf, [1 2], "bad"}
    end

    methods (Test)
        function defaultConstructorBuildsUnitRectangle(testCase)
            r = shapes.derived.Rectangle();

            testCase.verifyEqual(r.Name, "rectangle");
            testCase.verifyEqual(r.Width, 1);
            testCase.verifyEqual(r.Height, 1);
            testCase.verifyEqual(r.ScaleFactor, 1);
            testCase.verifyEqual(r.area(), 1);
            testCase.verifyEqual(r.perimeter(), 4);
        end

        function constructorStoresProvidedDimensions(testCase)
            r = shapes.derived.Rectangle(2.5, 4);

            testCase.verifyEqual(r.Width, 2.5);
            testCase.verifyEqual(r.Height, 4);
            testCase.verifyEqual(r.area(), 10);
            testCase.verifyEqual(r.perimeter(), 13);
        end

        function constructorRejectsWrongArity(testCase)
            testCase.verifyError( ...
                @() shapes.derived.Rectangle(1), ...
                "shapes:Rectangle:ConstructorArity");
        end

        function constructorRejectsInvalidWidth(testCase, invalidWidth)
            testCase.verifyError( ...
                @() shapes.derived.Rectangle(invalidWidth, 2), ...
                "shapes:Rectangle:InvalidWidth");
        end

        function constructorRejectsInvalidHeight(testCase, invalidHeight)
            testCase.verifyError( ...
                @() shapes.derived.Rectangle(2, invalidHeight), ...
                "shapes:Rectangle:InvalidHeight");
        end

        function scaleByUpdatesGeometryQuadraticallyAndLinearly(testCase, validScaleFactor)
            r = shapes.derived.Rectangle(2, 3);
            scaled = r.scaleBy(validScaleFactor);

            testCase.verifyEqual(scaled.ScaleFactor, validScaleFactor, "AbsTol", 1e-12);
            testCase.verifyEqual(scaled.area(), 6 * validScaleFactor ^ 2, "AbsTol", 1e-12);
            testCase.verifyEqual(scaled.perimeter(), 10 * validScaleFactor, "AbsTol", 1e-12);
            testCase.verifyEqual(r.area(), 6, "Original value object should remain unchanged.");
        end

        function repeatedScalingCompoundsMultiplicatively(testCase)
            r = shapes.derived.Rectangle(2, 3);
            r = r.scaleBy(2);
            r = r.scaleBy(0.25);
            r = r.scaleBy(5);

            testCase.verifyEqual(r.ScaleFactor, 2.5, "AbsTol", 1e-12);
            testCase.verifyEqual(r.area(), 37.5, "AbsTol", 1e-12);
            testCase.verifyEqual(r.perimeter(), 25, "AbsTol", 1e-12);
        end

        function resetScaleReturnsIdentityGeometry(testCase)
            r = shapes.derived.Rectangle(2, 3);
            scaled = r.scaleBy(4);
            reset = scaled.resetScale();

            testCase.verifyEqual(reset.ScaleFactor, 1);
            testCase.verifyEqual(reset.area(), 6);
            testCase.verifyEqual(reset.perimeter(), 10);
            testCase.verifyEqual(scaled.area(), 96);
        end

        function scaleByRejectsInvalidFactor(testCase, invalidScaleFactor)
            r = shapes.derived.Rectangle(2, 3);

            testCase.verifyError( ...
                @() r.scaleBy(invalidScaleFactor), ...
                "shapes:Shape:InvalidScaleFactor");
        end

        function isAreaAtLeastUsesScaledArea(testCase)
            r = shapes.derived.Rectangle(2, 3);
            scaled = r.scaleBy(2);

            testCase.verifyTrue(r.isAreaAtLeast(6));
            testCase.verifyFalse(r.isAreaAtLeast(6.01));
            testCase.verifyTrue(scaled.isAreaAtLeast(24));
            testCase.verifyFalse(scaled.isAreaAtLeast(24.01));
        end

        function isAreaAtLeastRejectsInvalidThreshold(testCase, invalidThreshold)
            r = shapes.derived.Rectangle(2, 3);

            testCase.verifyError( ...
                @() r.isAreaAtLeast(invalidThreshold), ...
                "shapes:Shape:InvalidAreaThreshold");
        end

        function summaryReflectsCurrentGeometry(testCase)
            r = shapes.derived.Rectangle(2, 3);
            r = r.scaleBy(2.5);
            txt = r.summary();

            testCase.verifyClass(txt, "string");
            testCase.verifyTrue(contains(txt, "Shape=rectangle"));
            testCase.verifyTrue(contains(txt, "ScaleFactor=2.5"));
            testCase.verifyTrue(contains(txt, "Area=37.5"));
            testCase.verifyTrue(contains(txt, "Perimeter=25"));
        end

        function assignmentCopyPreservesValueSemantics(testCase)
            original = shapes.derived.Rectangle(2, 3);
            copy = original;
            copy = copy.scaleBy(3);

            testCase.verifyEqual(original.ScaleFactor, 1);
            testCase.verifyEqual(original.area(), 6);
            testCase.verifyEqual(copy.ScaleFactor, 3);
            testCase.verifyEqual(copy.area(), 54);
        end
    end
end
