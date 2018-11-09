function [preScale, preTranslation] = GetAdjustInfo(modelType, imgSize)
  % ���f���̒��_�f�[�^�͈͐��K�����߂̏���Ԃ��֐�
  SQRT3 = 1.8; %���f����Ԃ̑Ίp�������e�͈͂���͂ݏo���Ȃ��悤�ɂ��邽�߂̏k����
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