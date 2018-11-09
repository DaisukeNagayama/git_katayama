function [processTime_Model, processTime_Part, pTime, pCount] = MakePrj4(exName, exType, gdid, imgSize, modelTypeRow)
  % 頂点データから投影を作成する関数
  % modelTypeRowとアフィン利用版
  % imgSize   : 投影の1辺の長さ(px)。数値で指定。
  % gdid      : 投影点に用いるGeodesicDomeのID。数値で指定。
  %   resourceDir = 'C:\Users\kume\Documents\MATLAB\04_ProjectionFromVertex\resource';
  %   exName      = 'ex1011';
  %   exType      = 'Database';
  %   gdid        = 1;
  %   imgSize     = 64;
  
  [filepath, name, ext]=fileparts([mfilename('fullpath'),'.m']);
  outputDir = [filepath, filesep,'output', filesep, exName, '_' exType ,  '_gdid', num2str(gdid), '_size', num2str(imgSize)];
  fprintf('outputDir : %s\n', outputDir);
  
  modelTypeNum = length(modelTypeRow);
  processTime_Model = cell(1,modelTypeNum);
  processTime_Part= cell(1,modelTypeNum);
  pTime = cell(1,modelTypeNum);
  pCount = cell(1,modelTypeNum);
  
  % モデル種類のループ
  for loopModelTypes = 1 : modelTypeNum
    modelType = modelTypeRow{loopModelTypes};    
    [processTime_Model(loopModelTypes),processTime_Part(loopModelTypes), pTime{loopModelTypes},pCount{loopModelTypes}] = MakeModelPrj(outputDir, exType, gdid, imgSize, modelType);    
  end %loopModelTypes
  
end %function

function [processTime_Model,processTime_Part, allT,allC] = MakeModelPrj(outputDir, exType, gdid, imgSize, modelType)
  % 頂点データ範囲の定義
  verMinLim = [0;0;0;];
  verMaxLim = [imgSize;imgSize;imgSize;];
  verAreaCenter = (verMaxLim - verMinLim)/2;

  % 投影点の読み込み
  [azimuth, elevation] = GetPrjPointList(gdid);
  
  anglesNum = size(azimuth, 1);
  
  getAffineF = GetAffineFuncHandles();
  
  allT = 0;
  allC = 0;
%   pTTable = cell2table(num2cell(zeros(5,3)), 'VariableNames',{'Count' 'Time', 'Tic'}, 'RowNames',{'Load' 'Facet' 'Decide' 'Pixel' 'Save'});

  % モデルの頂点データ範囲正規化ための情報を取得
  [preScale, preTranslation] = GetAdjustInfo(modelType, imgSize);
  % モデルのパーツの頂点データのフォルダ
  [tempPartsList, tempLabelList, tempPartsPath] = GetLabelList(modelType, exType);
  [tempScale, tempRotation, tempTranslation] = GetCondition(modelType, exType);
  modelNum = size(tempLabelList,2);
  processTime_Model = cell(1,modelNum);
  processTime_Part  = cell(1,modelNum);
  % モデル番号のループ
  for loopModels = 1 : modelNum
    tStart1 = tic; % モデル1個あたりの処理時間      
    modelName = [modelType, num2str(loopModels, '%03d')];
    % パーツリストの作成
    labelList = tempLabelList(:,loopModels);
    partsList = tempPartsList(cell2mat(labelList) > 0);
    partsPath = tempPartsPath(cell2mat(labelList) > 0);
%     labelList = labelList(cell2mat(labelList) > 0);       %ここではラベリングまではしないため使わない
    partsNum = length(partsList);
    % 事前の拡大・回転・平行移動量の取得
    modelScale = tempScale(loopModels);
    modelRotation = tempRotation(loopModels, 1:end);
    modelTranslation = tempTranslation(loopModels, 1:end);

    fprintf('projection %s (%dparts)\n', modelName, partsNum);
    fprintf('projecting');
    temp_processTime_Part = zeros(partsNum,1);
    % パーツのループ
    for loopParts = 1 : partsNum
      partsName = partsList{loopParts};
      fprintf('.');
%       tStart2 = tic;                % パーツ1個あたりの処理時間
%       prjData = cell(anglesNum, 1); % パーツの投影データを格納する変数

      % パーツの読み込み
%       load(partsPath{loopParts}, 'vertex');
      loadPath = partsPath{loopParts};

      % パーツ空間の情報を取得
      % 不要

      % 元データを保持
      % 不要
      
      % 頂点データ範囲正規化      
      affT1 = getAffineF.Translation(preTranslation(1), preTranslation(2), preTranslation(3));
      affS1 = getAffineF.Scaling(preScale, preScale, preScale, verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
      
      % 事前の拡大縮小・回転・平行移動      
      affS2 = getAffineF.Scaling(modelScale, modelScale, modelScale, verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
      affR1 = getAffineF.RotationY(modelRotation(1), verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
      affR2 = getAffineF.RotationZ(modelRotation(2), verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
      affT2 = getAffineF.Translation(modelTranslation(1), modelTranslation(2), modelTranslation(3));
      
      affTemp = affT1*affS1*affS2*affR1*affR2*affT2;
      % パーツ1個あたりの処理時間
      tStart2 = tic;

      saveDir = [outputDir, filesep, modelName];
      [~, ~, ~] = mkdir(saveDir);   
      [T,C] = ProjectionByDepthVolume7_2(loadPath, saveDir, partsName, affTemp, imgSize, azimuth, elevation, verAreaCenter, getAffineF);     
      temp_processTime_Part(loopParts) = toc(tStart2);
      allT = allT+ T;
      allC = allC+ C;
%       saveDir = [outputDir, filesep, modelName];
%       [~, ~, ~] = mkdir(saveDir);        
%       savePath = [saveDir,filesep, partsName];
%       save(savePath, 'prjData');
%       save(savePath, 'prjData', '-v7.3');
    end %loopParts
    processTime_Model = {toc(tStart1)};
    processTime_Part  = {temp_processTime_Part};
    fprintf('%f[sec]\n', cell2mat(processTime_Model));
  end %loopModels
end %function