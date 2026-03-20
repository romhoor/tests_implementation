classdef TestShapesContract < matlab.unittest.TestCase
    %TESTSHAPESCONTRACT Metadata and interface tests for the shapes package.

    methods (Test)
        function packageSuperclassIsAbstract(testCase)
            shapeMeta = ?shapes.base.Shape;

            testCase.verifyTrue(shapeMeta.Abstract);
        end

        function packageSuperclassDeclaresExpectedAbstractMembers(testCase)
            shapeMeta = ?shapes.base.Shape;

            abstractPropertyNames = string( ...
                {shapeMeta.PropertyList([shapeMeta.PropertyList.Abstract]).Name});
            abstractMethodNames = string( ...
                {shapeMeta.MethodList([shapeMeta.MethodList.Abstract]).Name});

            names = sort([abstractPropertyNames, abstractMethodNames]);

            testCase.verifyEqual(names, sort(["Name", "area", "perimeter"]));
        end

        function rectangleRealizesExpectedConcreteInterface(testCase)
            className = "shapes.derived.Rectangle";
            rectangleMeta = ?shapes.derived.Rectangle;

            testCase.verifyFalse(rectangleMeta.Abstract);
            testCase.verifyTrue(ismember("Name", string({rectangleMeta.PropertyList.Name})));
            testCase.verifyTrue(ismember("Width", string({rectangleMeta.PropertyList.Name})));
            testCase.verifyTrue(ismember("Height", string({rectangleMeta.PropertyList.Name})));
            testCase.verifyTrue(ismethod(className, "area"));
            testCase.verifyTrue(ismethod(className, "perimeter"));
            testCase.verifyTrue(ismethod(className, "scaleBy"));
            testCase.verifyTrue(ismethod(className, "resetScale"));
            testCase.verifyTrue(ismethod(className, "summary"));
        end

        function squareRealizesExpectedConcreteInterface(testCase)
            className = "shapes.derived.Square";
            squareMeta = ?shapes.derived.Square;

            testCase.verifyFalse(squareMeta.Abstract);
            testCase.verifyTrue(ismember("Name", string({squareMeta.PropertyList.Name})));
            testCase.verifyTrue(ismember("Side", string({squareMeta.PropertyList.Name})));
            testCase.verifyTrue(ismethod(className, "area"));
            testCase.verifyTrue(ismethod(className, "perimeter"));
            testCase.verifyTrue(ismethod(className, "scaleBy"));
            testCase.verifyTrue(ismethod(className, "resetScale"));
            testCase.verifyTrue(ismethod(className, "summary"));
        end

        function concreteClassesInheritFromPackageShape(testCase)
            rectangleMeta = ?shapes.derived.Rectangle;
            squareMeta = ?shapes.derived.Square;

            rectangleSuperNames = string({rectangleMeta.SuperclassList.Name});
            squareSuperNames = string({squareMeta.SuperclassList.Name});

            testCase.verifyEqual(rectangleSuperNames, "shapes.base.Shape");
            testCase.verifyEqual(squareSuperNames, "shapes.base.Shape");
        end
    end
end
