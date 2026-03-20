function results = run_all_shape_tests()
%RUN_ALL_SHAPE_TESTS Run all shape tests across unit, integration, and examples.

rootDir = fileparts(mfilename("fullpath"));
originalPath = path;
cleanupObj = onCleanup(@() path(originalPath));

% Make the project root, source tree, and test subfolders visible while
% the suite runs. The root-level Shape.m is kept for isolated examples,
% while package-based production code lives under src/+shapes.
addpath(rootDir);
addpath(fullfile(rootDir, "src"));
addpath(genpath(fullfile(rootDir, "tests")));

suite = testsuite(fullfile(rootDir, "tests"), "IncludeSubfolders", true);
results = run(suite);
end
