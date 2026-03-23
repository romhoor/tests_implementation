function tests = test_derived_initialization_ShapeID
% test_derived_initialization_ShapeID exhaustively checks that temporary
% derived Shape subclasses can only be instantiated when their constant
% shape_id matches an allowed non-reserved ShapeIDEnum value.
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setupOnce creates a temporary folder for generated test subclasses and
% adds the required folders to the MATLAB path.
    import matlab.unittest.fixtures.TemporaryFolderFixture

    thisTestFolder = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(fileparts(thisTestFolder));
    shapeFolder = fullfile(projectRoot, 'classes_base');

    fixture = testCase.applyFixture(TemporaryFolderFixture);
    generatedFolder = fixture.Folder;

    addpath(shapeFolder, thisTestFolder, generatedFolder);

    testCase.TestData.shapeFolder = shapeFolder;
    testCase.TestData.thisTestFolder = thisTestFolder;
    testCase.TestData.generatedFolder = generatedFolder;
end

function teardownOnce(testCase)
% teardownOnce removes folders added in setup and then clears classes.
    shapeFolder = testCase.TestData.shapeFolder;
    thisTestFolder = testCase.TestData.thisTestFolder;
    generatedFolder = testCase.TestData.generatedFolder;

    rmpath(shapeFolder, thisTestFolder, generatedFolder);
    clear classes
end

function testOnlyAllowedShapeIDsInstantiate(testCase)
% Every uint8 value is tested by generating a minimal Shape subclass.
% Construction must succeed only for the allowed non-reserved ShapeIDEnum
% values and must fail for all other uint8 values.
    invalidShapeID = uint8(ShapeIDEnum.SHAPE_ID_INVALID);
    maxShapeID = uint8(ShapeIDEnum.SHAPE_ID_MAX);
    enumShapeIDs = uint8(enumeration('ShapeIDEnum'));

    allowedShapeIDs = enumShapeIDs(enumShapeIDs > invalidShapeID & ...
                                   enumShapeIDs < maxShapeID);

    for rawShapeID = uint16(0):uint16(255)
        shapeID = uint8(rawShapeID);
        className = sprintf('GeneratedShapeID_%03u', shapeID);
        constructor = generate_shape_id_subclass( ...
            testCase.TestData.generatedFolder, className, shapeID);

        if ismember(shapeID, allowedShapeIDs)
            obj = constructor();
            testCase.verifyClass(obj, className, ...
                sprintf('shape_id %u should produce a valid generated Shape subclass.', shapeID));
            testCase.verifyEqual(obj.getScaleFactor(), 1, ...
                sprintf('shape_id %u should preserve the default Shape constructor behavior.', shapeID));
        else
            testCase.verifyError(@() constructor(), 'Shape:InvalidShapeID', ...
                sprintf('shape_id %u should be rejected during Shape construction.', shapeID));
        end
    end
end

function constructor = generate_shape_id_subclass(outputFolder, className, shapeID)
% generate_shape_id_subclass writes a minimal concrete Shape subclass whose
% only varying definition is the constant shape_id value.
    classPath = fullfile(outputFolder, strcat(className, '.m'));

    classDefinition = sprintf([
        'classdef %s < Shape\n' ...
        '    properties (Constant, Access = protected)\n' ...
        '        shape_id = uint8(%u)\n' ...
        '    end\n' ...
        '    methods\n' ...
        '        function obj = %s()\n' ...
        '            obj@Shape();\n' ...
        '        end\n' ...
        '    end\n' ...
        '    methods (Access = protected)\n' ...
        '        function a = computeArea(~)\n' ...
        '            a = 0;\n' ...
        '        end\n' ...
        '        function p = computePerimeter(~)\n' ...
        '            p = 0;\n' ...
        '        end\n' ...
        '    end\n' ...
        'end\n'], className, shapeID, className);

    fid = fopen(classPath, 'w');
    cleaner = onCleanup(@() fclose(fid));
    fprintf(fid, '%s', classDefinition);
    clear cleaner

    rehash
    constructor = str2func(className);
end
