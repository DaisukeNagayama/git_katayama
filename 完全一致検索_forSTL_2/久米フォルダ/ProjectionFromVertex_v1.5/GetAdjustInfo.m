function [preScale, preTranslation] = GetAdjustInfo(modelType, imgSize)
  % モデルの頂点データ範囲正規化ための情報を返す関数
  SQRT3 = 1.8; %モデル空間の対角線が投影範囲からはみ出さないようにするための縮小率
  [~, ~, verCenterAll, verRangeAll] = GetModelInfo(modelType);
  
  preScale = imgSize / max(verRangeAll) / SQRT3;
  preTranslation = [imgSize/2;imgSize/2;imgSize/2;] - verCenterAll;  
end

function [verMinAll, verMaxAll, verCenterAll, verRangeAll] = GetModelInfo(modelType)
    resourceDir = GetResourceDirPath();
    loadPath = [resourceDir, filesep, 'parts', filesep, modelType, filesep, 'modelInfo.mat'];
    load(loadPath, 'modelInfo');
    verMinAll    = modelInfo{strcmp(modelInfo(:,1), 'verMinAll'), 2};
    verMaxAll    = modelInfo{strcmp(modelInfo(:,1), 'verMaxAll'), 2};
    verCenterAll = modelInfo{strcmp(modelInfo(:,1), 'verCenterAll'), 2};
    verRangeAll  = modelInfo{strcmp(modelInfo(:,1), 'verRangeAll'), 2};
end