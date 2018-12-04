% ボリュームデータの表示
% addlistener: イベントを検知してプロットを変化させる
% 

% % データ読み込み
% load mri  % 人の頭部のMRIデータ
D = load('C:\Users\Nagayama\Documents\MATLAB\program\Models\Size96\Clutch96001.mat');
if isstruct(D)      % 構造体なら
    fields = fieldnames(D);
    D = getfield(D,fields{1});  % 1番目のフィールドを表示
end
D = squeeze(D);

% 試しに回転
% D = rot3d(D,pi/4,0);

% Plot
figure(1)
[~,handle_surf] = contour(D(:,:,1));
title('スカラー ボリューム データの可視化');

% スライダーバー作成
sliderMin = 1;
sliderMax = size(D,3);
sliderInitial = round((sliderMin + sliderMax)/2);
handle_slider = uicontrol('Style','slider','Position',[10 50 20 340],'Min',sliderMin,'Max',sliderMax,'Value',1);

% イベントリスナーの作成
addlistener(handle_slider,'Value','PostSet',@(event,obj) update(event,obj,D,handle_surf,handle_slider));

% 描画のアップデート処理用関数

function update(event,obj,D,handle_surf,handle_slider)
index = round(handle_slider.Value);
handle_surf.ZData = double(D(:,:,index));
end