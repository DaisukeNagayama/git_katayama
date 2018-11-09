function [azimuth, elevation] = GetPrjPointList(gdid)
% 投影点リストの作成
ue = [];
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints', filesep, 'ico', num2str(gdid), '.mat'];
load(projectionPointPath, 'ue');
[azimuth, elevation] = cart2sph(ue(:, 1), ue(:, 2), ue(:, 3));
end