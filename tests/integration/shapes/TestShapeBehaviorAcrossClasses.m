classdef TestShapeBehaviorAcrossClasses < matlab.unittest.TestCase
    %TESTSHAPEBEHAVIORACROSSCLASSES Cross-cutting behavioral tests.

    properties (TestParameter)
        shapeKind = {"rectangle", "square"}
    end

    methods (Test)
        function resetScaleAfterSeveralTransformsRecoversBaseGeometry(testCase, shapeKind)
            shape = localMakeShape(shapeKind);
            baseArea = shape.area();
            basePerimeter = shape.perimeter();

            shape = shape.scaleBy(0.5);
            shape = shape.scaleBy(7);
            shape = shape.scaleBy(2);
            shape = shape.resetScale();

            testCase.verifyEqual(shape.ScaleFactor, 1);
            testCase.verifyEqual(shape.area(), baseArea, "AbsTol", 1e-12);
            testCase.verifyEqual(shape.perimeter(), basePerimeter, "AbsTol", 1e-12);
        end

        function identityScaleLeavesGeometryUnchanged(testCase, shapeKind)
            shape = localMakeShape(shapeKind);
            baseArea = shape.area();
            basePerimeter = shape.perimeter();

            shape = shape.scaleBy(1);

            testCase.verifyEqual(shape.ScaleFactor, 1);
            testCase.verifyEqual(shape.area(), baseArea, "AbsTol", 1e-12);
            testCase.verifyEqual(shape.perimeter(), basePerimeter, "AbsTol", 1e-12);
        end

        function summaryChangesWhenScaleChanges(testCase, shapeKind)
            shape = localMakeShape(shapeKind);
            baseSummary = shape.summary();
            scaledShape = shape.scaleBy(2);
            scaledSummary = scaledShape.summary();

            testCase.verifyNotEqual(baseSummary, scaledSummary);
            testCase.verifyTrue(contains(scaledSummary, "ScaleFactor=2"));
        end
    end
end

function shape = localMakeShape(shapeKind)
switch shapeKind
    case "rectangle"
        shape = shapes.derived.Rectangle(2, 3);
    case "square"
        shape = shapes.derived.Square(2);
    otherwise
        error("shapes:Test:UnknownShapeKind", "Unknown shape kind %s.", shapeKind);
end
end
