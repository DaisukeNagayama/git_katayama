function makePrjPointList_projection1d(gdid)
% make projection point list 'ico-XX.mat'
% gdid : ID of original point list
% 
% ‚PD'ico-XX.mat' ‚Ì’¸“_‚É]‚Á‚Ä‚QŸŒ³“Š‰e proj_2d ‚ğŒvZ‚·‚é
% ‚QD'Projection1dFromProjection2d.m' ‚É proj_2d ‚ğ“Ë‚Á‚ñ‚Å proj_1d ‚ğ“¾‚é
% ‚RD proj_1d ‚Í 'icoXX.mat' ‚Ì’¸“_‚É]‚Á‚ÄŒvZ‚µ‚½‚PŸŒ³“Š‰e‚Æ“™‚µ‚¢
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

% Šes‚ÉÀ•W(x,y,z)‚ª•À‚Ô‚æ‚¤‚É¬Œ^‚·‚é
ue = [];
ue = [reshape(x,[],1), reshape(y,[],1), reshape(z,[],1)];
pointN = size(ue,1); % “_‚Ì”

% Œ‹‰Ê‚ğ•Û‘¶‚·‚éB
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints'];
fileName = ['ico', num2str(-gdid), '.mat'];
save([projectionPointPath, filesep, fileName], 'ue');

end