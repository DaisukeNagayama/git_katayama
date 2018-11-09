function makePrjPointList_SSHT(L)
% make projection point list 'ico20XX.mat'
% L : band-limit of SHT
% 
% 1�������e
% an equiangular sampling of the sphere 
% 
% 

t = 0:(L-1);
p = 0:(2*L-2);

elevation = pi * (2*t + 1) / (2*L - 1);
azimuth = 2 * p / (2*L - 1);

[az,el] = meshgrid(azimuth,elevation);  
[x,y,z] = sph2cart(az,el,1);

% �e�s�ɍ��W(x,y,z)�����Ԃ悤�ɐ��^����
ue = [reshape(x,[],1), reshape(y,[],1), reshape(z,[],1)];
pointN = size(ue,1); % �_�̐�

% ���ʂ�ۑ�����B
resourceDir = GetResourceDirPath();
projectionPointPath = [resourceDir, filesep, 'projectionPoints'];
fileName = ['ico', num2str(1000+L), '.mat'];
save([projectionPointPath, filesep, fileName], 'ue');

end