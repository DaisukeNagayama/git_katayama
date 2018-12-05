function PrepareParts_mat

[filepath, name, ext]=fileparts([mfilename('fullpath'),'.m']);
% .stlファイルを.matファイルに変換
% .stlファイルの読み込み時間を削減できる
  resourceDir = [filepath];
%   resourceDir = pwd;
  outputDir = [filepath];
 
%  ConvertParts_stl2mat('clutch', resourceDir);
%  ConvertParts_stl2mat('die', resourceDir);
%  ConvertParts_stl2mat('gear', resourceDir);
%  %   ConvertParts_stl2mat('ex', resourceDir); 
%   ConvertParts_stl2mat('hydraulic', resourceDir);
%   ConvertParts_stl2mat('mould', resourceDir);
%   ConvertParts_stl2mat('pvb', resourceDir);
%   ConvertParts_stl2mat('steamtrap', resourceDir);
%   ConvertParts_stl2mat('swashplate', resourceDir);
%   ConvertParts_stl2mat('keo', resourceDir);
%   ConvertParts_stl2mat('morton', resourceDir);
  ConvertParts_stl2mat('clutch_die', resourceDir);
  ConvertParts_stl2mat('die_gear', resourceDir);
  ConvertParts_stl2mat('gear_mould', resourceDir);
  ConvertParts_stl2mat('mould_clutch', resourceDir);
  ConvertParts_stl2mat('clutch_8', resourceDir);


end

function ConvertParts_stl2mat(modelType, resourceDir)
difine_INF = 999999;
% パーツの頂点データのフォルダ
partsDir = [resourceDir, filesep, 'parts', filesep, modelType, filesep, 'parts_stl'];
% 出力フォルダ
outputDir = [resourceDir, filesep, 'parts', filesep, modelType, filesep, 'parts_mat'];
if exist(outputDir,'dir') == 7
  fprintf('''%s''内に作成\n', outputDir);
else
  mkdir(outputDir);
  fprintf('''%s''を作成\n', outputDir);
end
% パーツ名のリストの作成
temp = GetFileList(partsDir);
partsNameList = strrep(temp, '.stl', '');
partsNum = length(partsNameList);
% 頂点データ範囲の記録用変数
verMinAll = [difine_INF;difine_INF;difine_INF;];
verMaxAll = [-difine_INF;-difine_INF;-difine_INF;];
for loopParts = 1 : partsNum
% パーツの読み込み
  partsName = partsNameList{loopParts};
  fprintf('(%d/%d)%s\n', loopParts, partsNum, partsName);
  loadPath = [partsDir, '\', partsName, '.stl'];
  vertex = READ_stl(loadPath);
  
  % clutch,die,gearの場合は壁があるので消去
%   if strcmp(modelType, 'clutch') || strcmp(modelType, 'die') || strcmp(modelType, 'gear')
%     vertex = vertex_RemoveWall(vertex, modelType);
%   end
  savePath = [outputDir, '\', strrep(partsName, ' ', '_'), '.mat'];
  save(savePath, 'vertex');
  
  [verMin, verMax, ~, ~] = vertex_CalculateData(vertex, 'true');
  isMin = verMinAll > verMin;
  verMinAll = verMinAll.*~isMin + verMin.*isMin;
  isMax = verMaxAll < verMax;
  verMaxAll = verMaxAll.*~isMax + verMax.*isMax;  
end
verInfo      = {'verMinAll';'verMaxAll';'verCenterAll';'verRangeAll';};
verCenterAll = (verMaxAll + verMinAll) / 2;
verRangeAll  = verMaxAll - verMinAll;
verInfo2     = {verMinAll;verMaxAll;verCenterAll;verRangeAll;};

modelInfo    = cat(2, verInfo,verInfo2);
savePath     = [resourceDir, '\parts\', modelType, '\modelInfo.mat'];
save(savePath, 'modelInfo');
partsNameList = strrep(partsNameList, ' ', '_');
savePath     = [resourceDir, '\parts\', modelType, '\partsList.mat'];
save(savePath, 'partsNameList');
end