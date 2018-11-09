%% モデルの回転平行移動量の乱数生成
% 各モデルについて number 個ずつ乱数生成
% 生成結果をそのままプログラムにコピペできるように整えてコマンドウィンドウに表示
% 
% 入力 : Models / ３次元ボクセルモデルのセル配列
%        Number / いくつ乱数を生成したいか
%
% 出力 : ３次元空間からモデルがはみ出さない回転平行移動量
%
% 
%%
function [RotAzis, RotEles, Translation] = RotationTranslation(Models,Number)

%%% セル配列じゃなかったら場合
if not(iscell(Models))
    Models = {Models};
end

%%% 定数宣言、行列の用意
NM = length(Models);     % モデル数

RotEles = zeros(Number*NM,1);
RotAzis = zeros(Number*NM,1);
Translation = zeros(Number*NM,3);

%%% 各モデルについてループ
for im = 1:NM
    Model = Models{im};
    [NX,NY,NZ] = size(Model);

    %%%
    for i = 1:Number
        key = 1;
        NumberOfRetry = -1;
        while key == 1
            azimuth = round(360*rand);% 姿勢変化量をランダムで設定
            elevation = round(180*rand);% 姿勢変化量をランダムで設定
            mr3d = rot3d(Model, elevation, azimuth, 'nearest');% 姿勢変化
            %%% ３次元空間の外面にモデルが接地しているかをチェック
            if sum(sum(squeeze( mr3d(1,:,:) + mr3d(NX,:,:) ))) ==0% X方向の境界面
                if sum(sum(squeeze( mr3d(:,1,:) + mr3d(:,NY,:) ))) ==0% X方向の境界面
                    if sum(sum(squeeze( mr3d(:,:,1) + mr3d(:,:,NZ) ))) ==0% Z方向の境界面
                        key = 0;
                    end
                end
            end
            NumberOfRetry = NumberOfRetry + 1;
        end
        disp(strcat('姿勢変化修正回数：', num2str(NumberOfRetry)))

        %%% 平行移動可能な範囲を調べる
        [NXm, NXp, NYm, NYp, NZm, NZp] = DistancebetweenModelandSpace(mr3d);
        %%% ランダムに平行移動
        dx = floor(-NXm + rand*(NXm + NXp + 1));% 0も含めるため、+1
        dy = floor(-NYm + rand*(NYm + NYp + 1));% 0も含めるため、+1
        dz = floor(-NZm + rand*(NZm + NZp + 1));% 0も含めるため、+1
        %mrs = circshift(mr3d, [dx dy dz]);% 平行移動

        RotEles(i+(im-1)*Number) = elevation;
        RotAzis(i+(im-1)*Number) = azimuth;
        Translation(i+(im-1)*Number,:) = [dx dy dz];
    end
end

%%% 文字列としてコマンドウィンドウに表示
disp(strcat('RotAzi: ', mat2str(RotAzis), ';'))
disp(strcat('RotEle: ', mat2str(RotEles), ';'))
disp(strcat('Translation: ', mat2str(Translation), ';'))

end

function [NXm, NXp, NYm, NYp, NZm, NZp] = DistancebetweenModelandSpace(m)
%% ３次元空間をはみださないように平行移動可能な範囲をチェック
%    入力：m / ３次元モデルが格納された３次元配列
%    出力：NXm / マイナス方向に移動可能な量, NXp / プラス方向に移動可能な量, ...（ほかも同様）
[NX,NY,NZ] = size(m);

% X
ProjX = sum(sum(m,3),2);
NXm = find(ProjX, 1) - 1;
NXp = NX - find(ProjX, 1, 'last');

% Y
ProjY = sum(sum(m,3),1)';
NYm = find(ProjY, 1) - 1;
NYp = NY - find(ProjY, 1, 'last');

% Z
ProjZ = squeeze( sum(sum(m,1),2) );
NZm = find(ProjZ, 1) - 1;
NZp = NZ - find(ProjZ, 1, 'last');


end

