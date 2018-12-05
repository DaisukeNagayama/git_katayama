function prepare_labellist()


[filepath, name, ext] = fileparts([mfilename('fullpath'),'.m']);

modelPath = [filepath, filesep, 'parts', filesep, modelType];
% partslist = read(partsListPath);
partslist = zeros(4,4);

partsListPath = [modelPath, filesep, 'labelList_', exType, '.xlsx'];

startCell = [1 1];
sheet = 1;
xlRange = xlsrange2(startCell, size(partslist));    % requires 'xlsrange.m' and 'xlscol.m'
xlswrite(partsListPath, cell4excel, sheet, xlRange)


end