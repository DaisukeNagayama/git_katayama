function [tempScale, tempRotation, tempTranslation] =  GetCondition(modelType, exType)
  resourceDir = GetResourceDirPath();
  conditionListPath = [resourceDir,filesep,'parts',filesep,'condition_',exType,'.xlsx'];

  % パーツ名リスト_パーツ数*1行列のcell配列
  [~,~,raw] = xlsread(conditionListPath);
  modelNameList = raw(2:end,1);
  conditionList = raw(:,2:end);
  modelListIndex = strncmp(modelNameList, modelType, length(modelType));
  
%   scale         = conditionList(2:end, strcmp(conditionList(1,:), 'scale'));  
  tempScaleList       = conditionList(2:end, strncmp(conditionList(1,:), 'scale', length('scale')));
%   rotationY     = conditionList(2:end, strcmp(conditionList(1,:), 'rotationY'));
%   rotationZ     = conditionList(2:end, strcmp(conditionList(1,:), 'rotationZ'));
  tempRotationList    = conditionList(2:end, strncmp(conditionList(1,:), 'rotation', length('rotation')));    
%   translationX  = conditionList(2:end, strcmp(conditionList(1,:), 'translationX'));  
%   translationY  = conditionList(2:end, strcmp(conditionList(1,:), 'translationY'));  
%   translationZ  = conditionList(2:end, strcmp(conditionList(1,:), 'translationZ'));
  tempTranslationList = conditionList(2:end, strncmp(conditionList(1,:), 'translation', length('translation')));
  tempScale = cell2mat(tempScaleList(modelListIndex));
  tempRotation = cell2mat(tempRotationList(modelListIndex, 1:end));
  tempTranslation = cell2mat(tempTranslationList(modelListIndex, 1:end));
end