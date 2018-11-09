function ProjEachComponent = VerticesProjectionEachLabel2( Model, theta, phi )
%% ラベル値ごとに3次元ラドン変換で1次元投影を作成する（球面直交座標）
% VerticesProjectionEachLagel.m を
% Geodesic Dome ではなく球面直交座標系で投影作成するように改造したもの
% 
% input : Model 3次元ボクセルモデル
%         theta 投影を撮影する緯度 (0 <= θ <= π)    １次元配列 
%         phi 投影を撮影する経度 (0 <= φ <= 2π)     １次元配列
%   
%   output: ProjEachComponent{Label}(Z,theta,phi)
%   
%   
%% 投影角度についての準備
NT = length(theta);
NP = length(phi);
harfNP = floor(NP/2);

%% 大きな空間へモデルを格納
Interpolation = 'nearest';% 補間方法を選択     { linear, nearest, [] }
disp(strcat(Interpolation,'で補間中...'));

[NX,NY,NZ] = size(Model);
% モデルがある空間全体を投影画像上に収めるために必要な新しい空間の大きさ
NX2 = ceil(sqrt(3)*max([NX NY NZ]));
NewSpace = zeros(NX2, NX2, NX2);
% 新しい空間の中心にモデルを格納
CX = floor((NX+1)/2); CY = floor((NY+1)/2); CZ = floor((NZ+1)/2);% モデルが格納されている空間の中心
CX2 = floor((NX2+1)/2); CY2 = floor((NX2+1)/2); CZ2 = floor((NX2+1)/2);% 新しい空間の中心
xmin = CX2-(CX-1); xmax = CX2+(NX-CX);
ymin = CY2-(CY-1); ymax = CY2+(NY-CY);
zmin = CZ2-(CZ-1); zmax = CZ2+(NZ-CZ);
NewSpace(xmin:xmax,ymin:ymax,zmin:zmax) = Model;% 新しい空間にモデルを格納

%% 姿勢変化を利用した投影
Labels = unique(Model(Model>0));
NL = length(Labels);
disp(strcat(num2str(NL),'個の各部品の投影画像を',Interpolation,'による補間で計算中...'));

Proj = zeros(NX2, NT, NP);
ProjEachComponent = cell(NL,1);
for ipec = 1:NL
    ProjEachComponent{ipec} = Proj;
end

% NP が偶数だったらちゃんと全部計算する
if mod(NP,2) == 0
    harfNP = NP;
end

% 本体
for it = 1:NT
    for ip = 1:harfNP
        elevation_ia = theta(it);% 緯度
        azimuth_ia = phi(ip);% 経度
        ModelRotated = rot3d(NewSpace, -1*elevation_ia, -1*azimuth_ia, Interpolation, true);% 姿勢変化

        for il = 1:NL
            label = Labels(il);
            Component = (ModelRotated == label);            
            ProjEachComponent{il}(:,it,ip) = squeeze(sum(sum(Component)));% Z軸に投影（線積分）
            if mod(elevation_ia + pi/4, pi/2) == 0    % 45度角かどうか
                ProjEachComponent{il}(:,it,ip) = ProjEachComponent{il}(:,it,ip) / 1.0962;
            end
        end
    end
end

% NP が奇数だったら後半はコピペ
if mod(NP,2) == 1
    for il = 1:NL
        ProjEachComponent{il}(:,1:NT,(harfNP+1):NP-1) = flip(ProjEachComponent{il}(:,NT:-1:1,1:harfNP), 1);
        ProjEachComponent{il}(:,1:NT,NP) = flip(ProjEachComponent{il}(:,NT:-1:1,1), 1);
    end
end


end % fanction

