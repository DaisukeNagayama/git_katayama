function makePrjPointList_projection1d(gdid)
% make projection point list 'ico-XX.mat'
% gdid : ID of original point list
% 
% １．'ico-XX.mat' の頂点に従って２次元投影 proj_2d を計算する
% ２．'Projection1dFromProjection2d.m' に proj_2d を突っ込んで proj_1d を得る
% ３． proj_1d は 'icoXX.mat' の頂点に従って計算した１次元投影と等しい
% 
% proj_2d : structure of projection of model
%           e.g. Projection.Model.Label.projectionArray(x,y,N)
% proj_1d : structure of projection of model
%           e.g. Projection.Model.Label.projectionArray(x,N)
% 
% 

% Read the original pointlist file
ue = [];
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints', filesep, 'ico', num2str(gdid), '.mat'];
load(projectionPointPath, 'ue');

[azimuth, elevation] = cart2sph(ue(:, 1), ue(:, 2), ue(:, 3));

[x,y,z] = sph2cart(azimuth, elevation - pi/2, 1);

% 各行に座標(x,y,z)が並ぶように成型する
ue = [];
ue = [reshape(x,[],1), reshape(y,[],1), reshape(z,[],1)];
pointN = size(ue,1); % 点の数

% 結果を保存する。
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints'];
fileName = ['ico', num2str(-gdid), '.mat'];
save([projectionPointPath, filesep, fileName], 'ue');

end