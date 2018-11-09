% showProjections.m   ボリュームデータの投影一覧を作成する
% 
% INPUTS:
%   inputModel - Volume data（voxel）                 [3d array]
%   NT,NP      - Number of images                     [Natural number]
%   marginX    - Margin in X direction (θ direction) [Real number in 0~1]
%   marginY    - Margin in Y direction (φ direction) [Real number in 0~1]
% 
% figure の単位設定を 'normalized' にしているので
% 左下が (0,0) で右上が (1,1) に正規化されている。
% 
% Nagayama Daisuke, 2018

% input
load mri
inputModel = double(squeeze(D));
% load('C:\Users\Nagayama\Documents\MATLAB\program\Models\Size96\Clutch96001.mat')
% inputModel = Clutch96001;

% constants
NT = 5;
NP = 11;
marginX = 0.01;
marginY = 0.01;

% preparation
theta = linspace(0,pi/2,NT);
phi = linspace(0,pi,NP);
imsizeX = (1-marginX)/NP - marginX;
imsizeY = (1-marginY)/NT - marginY;

% plot
tic
f=figure('Units','normalized'),
for iT = 1:NT
    for iP = 1:NP
        model = rot3d(inputModel,theta(iT),phi(iP));

        img = squeeze(sum(model,3));
        
        % img2 = radon(img);
        % img3 = abs(fftshift(fft(img2,[],1),1));
        % img3 = log(img3);
        
        % Position
        axes('position',[marginX+(iP-1)*(imsizeX+marginX), marginY+(iT-1)*(imsizeY+marginY), imsizeX, imsizeY]);
        imshow(img,[],'Border','tight','Colormap',parula,'InitialMagnification',1000)
                                      % colormap: parula, bone, jet, ...
    end
end
toc