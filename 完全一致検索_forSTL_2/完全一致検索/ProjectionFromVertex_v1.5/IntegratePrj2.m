function exData = IntegratePrj2(exName, exType, gdid, imgSize, modelTypes)
% 投影をラベルごとに統合する関数

% 入力フォルダ識別名
% output フォルダに
initialName = [exName,'_',exType,'_gdid',num2str(gdid),'_size',num2str(imgSize)];
[filepath, name, ext]=fileparts([mfilename('fullpath'),'.m']);
inputDir = [filepath, filesep, 'output'];

[~,dirList] = GetFileList(inputDir);
index = strncmp(dirList, initialName, length(initialName));
exPath = [inputDir, filesep, dirList{index}];
[~,allModelsList] = GetFileList(exPath);

exData = cell(0,length(modelTypes));
modelTypeNum = length(modelTypes);
% モデルの種類のループ
for loopModelTypes = 1 : modelTypeNum
  modelType  = modelTypes{loopModelTypes};
  index      = strncmp(allModelsList, modelType,length(modelType));
  modelsList = allModelsList(index);
  modelsNum  = length(modelsList);
  [partsList, tempLabelList,~] = GetLabelList(modelType, exType);
  
  tempPrjData = cell(modelsNum, 3);
  % モデルのループ
  for loopModel = 1 : modelsNum
    modelName   = modelsList{loopModel};
    fprintf('integrating %s_', modelName);
    tStart = tic;
    labelList   = tempLabelList(:,loopModel);
    modelDir    = [exPath, filesep, modelName];
    [uniqueLabel, prj] = IntegPrjInternal(modelDir, partsList, labelList);
    tempPrjData(loopModel, 1) = {modelName};
    tempPrjData(loopModel, 2) = {uniqueLabel};
    tempPrjData(loopModel, 3) = {prj};
    fprintf('%f[sec]\n',toc(tStart));
  end
  
  exData = cat(1, exData, tempPrjData);
end

end %function

function [uniqueLabel, prj] = IntegPrjInternal(modelDir, partsList, labelList)
% ラベル値0は消す
partsList = partsList(cell2mat(labelList) > 0);
labelList = labelList(cell2mat(labelList) > 0); 
% 一意なラベル値を取り出す
uniqueLabel = unique(cell2mat(labelList));
uniqueLabelNum = length(uniqueLabel);
% 同一ラベル値のパーツの投影をまとめて格納するためのセル配列
prj = cell(uniqueLabelNum, 1);
for loopUniqueLabel = 1 : uniqueLabelNum
  % 注目ラベル
  nowLabel = uniqueLabel(loopUniqueLabel);
  index = nowLabel == cell2mat(labelList);
  nowPartsList = partsList(index);
  loadPath = [modelDir, filesep, nowPartsList{1}, '.mat'];
  load(loadPath, 'prjData');
  imgNum  = size(prjData,1);
  imgSize = size(prjData{1},1);
  IMG = zeros(imgSize,imgSize, imgNum);
  for loopParts = 1 : length(nowPartsList)
    nowPartName = nowPartsList{loopParts};
    loadPath = [modelDir, filesep, nowPartName, '.mat'];
    load(loadPath, 'prjData');
    for loopImg = 1:imgNum
    IMG(:, :, loopImg) = IMG(:, :, loopImg) + prjData{loopImg};
    end
  end %loopParts
 prj(loopUniqueLabel) = {IMG};
end %loopUniqueLabel

end %function