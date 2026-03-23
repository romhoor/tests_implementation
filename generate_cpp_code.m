clear classes
rehash

cfg = coder.config('lib');
cfg.TargetLang = 'C';
cfg.BuildConfiguration = 'Debug';

cfg.GenerateComments = true;
cfg.MATLABSourceComments = true;
cfg.MATLABSourceCommentLineNumbers = true;

cfg.PreserveVariableNames = 'All';      % for inspection/debug only
cfg.PreserveArrayDimensions = true;

cfg.EnableAutoParallelization = false;
cfg.OptimizeReductions = false;

cfg.InlineBetweenUserFunctions = 'Never';
cfg.InlineBetweenUserAndMathWorksFunctions = 'Never';
cfg.InlineBetweenMathWorksFunctions = 'Never';

cfg.HeaderGuardStyle = 'UsePragmaOnce';

codegen -config cfg -c -report main ...
  -args {uint8(1), 1.0, 1.0, 1.0} ...
  -d codegen/oo_main_c_readable