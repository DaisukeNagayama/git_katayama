function resourceDir = GetResourceDirPath()
[filepath, name, ext]=fileparts([mfilename('fullpath'),'.m']);
[filepath, ~, ~]=fileparts([filepath,'.aaa']);
resourceDir = fullfile([filepath,filesep,'resource']);
end