function makePrjPointList_projection1d(gdid)
% make projection point list 'ico-XX.mat'
% gdid : ID of original point list
% 
% �P�D'ico-XX.mat' �̒��_�ɏ]���ĂQ�������e proj_2d ���v�Z����
% �Q�D'Projection1dFromProjection2d.m' �� proj_2d ��˂������ proj_1d �𓾂�
% �R�D proj_1d �� 'icoXX.mat' �̒��_�ɏ]���Čv�Z�����P�������e�Ɠ�����
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

% �e�s�ɍ��W(x,y,z)�����Ԃ悤�ɐ��^����
ue = [];
ue = [reshape(x,[],1), reshape(y,[],1), reshape(z,[],1)];
pointN = size(ue,1); % �_�̐�

% ���ʂ�ۑ�����B
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints'];
fileName = ['ico', num2str(-gdid), '.mat'];
save([projectionPointPath, filesep, fileName], 'ue');

end