function [partsList, labelList, partsPath] =  GetLabelList(modelType, exType)  
  resourceDir = GetResourceDirPath();
  partsListPath = [resourceDir, filesep, 'parts', filesep, modelType, filesep, 'labelList_', exType, '.xlsx'];
  
  % �p�[�c�����X�g_�p�[�c��*1�s���cell�z��
  [~,~,raw] = xlsread(partsListPath);
  partsList = raw(:,1);
  labelList = raw(:,2:end);
  partsPath = strcat(resourceDir,filesep,'parts',filesep,modelType,filesep,'parts_mat',filesep,partsList,'.mat');
end