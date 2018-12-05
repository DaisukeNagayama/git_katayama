function [azimuth, elevation] = GetPrjPointList(gdid)
% “Š‰e“_ƒŠƒXƒg‚Ìì¬
ue = [];
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints', filesep, 'ico', num2str(gdid), '.mat'];
load(projectionPointPath, 'ue');
[azimuth, elevation] = cart2sph(ue(:, 1), ue(:, 2), ue(:, 3));
end