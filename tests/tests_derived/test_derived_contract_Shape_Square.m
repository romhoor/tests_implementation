function tests = test_derived_contract_Shape_Square
% test_derived_contract_Shape_Square verifies that Square satisfies the
% concrete base-class contract implemented in Shape.
%
% These tests intentionally repeat the Shape base-contract checks, but they
% run them on a real concrete subclass instead of on dummyShape.
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setupOnce adds the folders that contain the Shape base class and the
% Square concrete subclass used in these tests.
    thisTestFolder = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(fileparts(thisTestFolder));

    shapeFolder = fullfile(projectRoot, 'classes_base');
    squareFolder = fullfile(projectRoot, 'classes_derived');

    addpath(shapeFolder, squareFolder);
    testCase.TestData.shapeFolder = shapeFolder;
    testCase.TestData.squareFolder = squareFolder;
end

function teardownOnce(testCase)
% teardownOnce removes the folders that were added in setupOnce.
    rmpath(testCase.TestData.shapeFolder, testCase.TestData.squareFolder);
end

function testDefaultConstructorUsesScaleFactorOne(testCase)
% When Square is created without an input argument, the inherited Shape
% constructor should apply its own default scale factor value of 1.
    obj = Square();

    testCase.verifyEqual(obj.getScaleFactor(), 1);
end

function testConstructorStoresProvidedScaleFactor(testCase)
% When Square passes an explicit scale factor to Shape, that exact value
% should be stored in the inherited base-class state.
    obj = Square(1, 2.53746467);

    testCase.verifyEqual(obj.getScaleFactor(), 2.53746467);
end

function testGetterReturnsCurrentStoredScaleFactor(testCase)
% The getter should return the scale factor currently stored in the Shape
% portion of the Square object.
    obj = Square(1, 7);

    scaleFactor = obj.getScaleFactor();

    testCase.verifyEqual(scaleFactor, 7);
end

function testSetterUpdatesScaleFactorInPlace(testCase)
% Because Shape is a handle class, the inherited setter should modify the
% existing Square object directly without requiring reassignment.
    obj = Square();

    obj.setScaleFactor(32);

    testCase.verifyEqual(obj.getScaleFactor(), 32);
end
