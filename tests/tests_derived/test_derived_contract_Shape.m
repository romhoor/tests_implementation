classdef test_derived_contract_Shape < matlab.unittest.TestCase
    % test_derived_contract_Shape verifies that every registered concrete
    % Shape subclass satisfies the concrete base-class contract
    % implemented in Shape.
    %
    % The list of concrete subclasses and their constructor factories is
    % defined in get_derived_shape_contract_cases.m.

    properties (TestParameter)
        % shapeCase is a parameterized test input.
        % MATLAB expands one test result per registered shape case.
        shapeCase
    end

    properties
        ShapeFolder
        DerivedFolder
        HelperFolder
    end

    methods (TestParameterDefinition, Static)
        function shapeCase = defineShapeCase
            % Load the concrete subclasses and their constructor factories
            % from the dedicated test registry file.
            shapeCase = get_derived_shape_contract_cases();
        end
    end

    methods (TestClassSetup)
        function addRequiredFolders(testCase)
            % Add the folders that contain the base class, the concrete
            % subclasses, and the helper files for these tests.
            testFileFolder = fileparts(mfilename('fullpath'));
            projectRoot = fileparts(fileparts(testFileFolder));

            testCase.ShapeFolder = fullfile(projectRoot, 'classes_base');
            testCase.DerivedFolder = fullfile(projectRoot, 'classes_derived');
            testCase.HelperFolder = testFileFolder;

            addpath(testCase.ShapeFolder, ...
                    testCase.DerivedFolder, ...
                    testCase.HelperFolder);
        end
    end

    methods (TestClassTeardown)
        function removeRequiredFolders(testCase)
            % Remove the folders that were added for these tests.
            rmpath(testCase.ShapeFolder, ...
                  testCase.DerivedFolder, ...
                  testCase.HelperFolder);
        end
    end

    methods (Test)
        function testDefaultConstructorUsesScaleFactorOne(testCase, shapeCase)
            % Every listed concrete subclass should inherit the default
            % ScaleFactor value of 1 from Shape when created by its
            % default-construction factory.
            obj = shapeCase.createDefault();

            testCase.verifyEqual(obj.getScaleFactor(), 1);
        end

        function testConstructorStoresProvidedScaleFactor(testCase, shapeCase)
            % Every listed concrete subclass should store an explicit scale
            % factor passed through its with-scale factory.
            expectedScaleFactor = 2.53746467;
            obj = shapeCase.createWithScale(expectedScaleFactor);

            testCase.verifyEqual(obj.getScaleFactor(), expectedScaleFactor);
        end

        function testGetterReturnsCurrentStoredScaleFactor(testCase, shapeCase)
            % Every listed concrete subclass should expose the inherited
            % scale factor through the Shape getter.
            expectedScaleFactor = 7;
            obj = shapeCase.createWithScale(expectedScaleFactor);

            testCase.verifyEqual(obj.getScaleFactor(), expectedScaleFactor);
        end

        function testSetterUpdatesScaleFactorInPlace(testCase, shapeCase)
            % Every listed concrete subclass should allow the inherited
            % Shape setter to update the existing object in place.
            updatedScaleFactor = 32;
            obj = shapeCase.createDefault();

            obj.setScaleFactor(updatedScaleFactor);

            testCase.verifyEqual(obj.getScaleFactor(), updatedScaleFactor);
        end
    end
end
