function tests = test_base_contract_Shape
% test_base_contract_Shape verifies only the concrete behavior already
% implemented in the abstract Shape base class.
%
% These tests do not check any real geometry formulas.
% They only check the inherited base-class contract that every concrete
% subclass should satisfy for construction and ScaleFactor access.
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
% setupOnce adds the folders that contain the Shape base class and the
% dummy concrete subclass used only for instantiation during testing.
    thisTestFolder = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(fileparts(thisTestFolder));

    shapeFolder = fullfile(projectRoot, 'classes_base');
    dummyFolder = thisTestFolder;

    addpath(shapeFolder, dummyFolder);
    testCase.TestData.shapeFolder = shapeFolder;
    testCase.TestData.dummyFolder = dummyFolder;
end

function teardownOnce(testCase)
% teardownOnce removes the folders that were added in setupOnce.
    rmpath(testCase.TestData.shapeFolder, testCase.TestData.dummyFolder);
end

function testDefaultConstructorUsesScaleFactorOne(testCase)
% When a concrete subclass is created without an input argument, the Shape
% constructor should apply its own default scale factor value of 1.
    obj = dummyShape();

    testCase.verifyEqual(obj.getScaleFactor(), 1);
end

function testConstructorStoresProvidedScaleFactor(testCase)
% When a concrete subclass passes an explicit scale factor to Shape, that
% exact value should be stored in the inherited base-class state.
    obj = dummyShape(2.53746467);

    testCase.verifyEqual(obj.getScaleFactor(), 2.53746467);
end

function testGetterReturnsCurrentStoredScaleFactor(testCase)
% The getter should return the scale factor currently stored in the Shape
% portion of the object.
    obj = dummyShape(7);

    scaleFactor = obj.getScaleFactor();

    testCase.verifyEqual(scaleFactor, 7);
end

function testSetterUpdatesScaleFactorInPlace(testCase)
% Because Shape is a handle class, the setter should modify the existing
% object instance directly without requiring reassignment.
    obj = dummyShape();

    obj.setScaleFactor(32);

    testCase.verifyEqual(obj.getScaleFactor(), 32);
end

function testAreaReturnsValidatedNonnegativeScalar(testCase)
% Shape now owns the public area contract, so this test verifies that the
% base-class area method accepts the dummy subclass output and returns it.
    obj = dummyShape();

    testCase.verifyEqual(obj.area(), 0);
end

function testPerimeterReturnsValidatedNonnegativeScalar(testCase)
% Shape now owns the public perimeter contract, so this test verifies that
% the base-class perimeter method accepts the dummy subclass output.
    obj = dummyShape();

    testCase.verifyEqual(obj.perimeter(), 0);
end
