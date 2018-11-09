
resourceDir = 'C:\Users\Nagayama\Documents\MATLAB\‹v•ÄƒtƒHƒ‹ƒ_\resource\parts\';

[filepath, name, ext]=fileparts([mfilename('fullpath'),'.m']);
outputDir = [filepath, filesep,'output', filesep, 'model_fliped'];

modelTypeRow = {'Clutch'};


modelTypeNum = length(modelTypeRow);

for loopModelTypes = 1 : modelTypeNum
    modelType = modelTypeRow{loopModelTypes}; 
    
    [tempPartsList, tempLabelList, tempPartsPath] = GetLabelList('Clutch', 'Database');
    modelNum = size(tempLabelList,2);
    
    for loopModels = 1 : modelNum
        
        modelName = [modelType, num2str(loopModels, '%03d')];
        labelList = tempLabelList(:,loopModels);
        partsList = tempPartsList(cell2mat(labelList) > 0);
        partsPath = tempPartsPath(cell2mat(labelList) > 0);
        partsNum = length(partsList);

        for loopParts = 1 : partsNum
            partsName = partsList{loopParts};
            loadPath = partsPath{loopParts};

            saveDir = [outputDir, filesep, modelName];
            [~, ~, ~] = mkdir(saveDir);  
            matflip(loadPath,saveDir);
        end

    end
end

