function generate_c_code()
% generate_c_code builds C code from the style_C entry point.
% The caller is responsible for setting the MATLAB path.

    thisFile = mfilename('fullpath');
    if isempty(thisFile)
        thisFile = which('generate_c_code');
    end

    projectFolder = fileparts(thisFile);
    styleCFolder = fullfile(projectFolder, 'style_C');
    outputFolder = fullfile(styleCFolder, 'codegen', 'c_main_c');

    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    clear main
    rehash

    cfg = coder.config('lib');
    cfg.TargetLang = 'C';
    cfg.BuildConfiguration = 'Debug';
    cfg.GenerateComments = true;
    cfg.MATLABSourceComments = true;
    cfg.InlineBetweenUserFunctions = 'Never';

    codegen -config cfg main ...
        -args {uint8(1), 1.0, 1.0, 1.0} ...
        -d outputFolder
end
