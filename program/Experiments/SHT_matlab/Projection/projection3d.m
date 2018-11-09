function Proj = projection3d( Model, theta, phi )
% PROJECTION3D 3次元ラドン変換で1次元投影を作成する
%   Proj = PROJECTION3D( Model, theta, phi )
%   
%   input : Model 3次元ボクセルモデル            ３次元配列
%           theta 投影を撮影する緯度 (0 から π) １次元配列
%           phi 投影を撮影する経度 (0 から 2π)　１次元配列
%   
%   output: Proj(Z,theta,phi)
%   

%% 投影角度についての準備
NT = length(theta);
NP = length(phi);

%% 大きな空間へモデルを格納
Interpolation = 'linear';   % 補間方法を選択     { linear, nearest, [] }
% disp(strcat(Interpolation,'で補間中...'));

[NX,NY,NZ] = size(Model);
% モデルがある空間全体を投影画像上に収めるために必要な新しい空間の大きさ
NL = ceil(sqrt(3)*max([NX NY NZ]));
NewSpace = zeros(NL, NL, NL);
% 新しい空間の中心にモデルを格納
CX = floor((NX+1)/2); CY = floor((NY+1)/2); CZ = floor((NZ+1)/2);% モデルが格納されている空間の中心
CX2 = floor((NL+1)/2); CY2 = floor((NL+1)/2); CZ2 = floor((NL+1)/2);% 新しい空間の中心
xmin = CX2-(CX-1); xmax = CX2+(NX-CX);
ymin = CY2-(CY-1); ymax = CY2+(NY-CY);
zmin = CZ2-(CZ-1); zmax = CZ2+(NZ-CZ);
NewSpace(xmin:xmax,ymin:ymax,zmin:zmax) = Model;% 新しい空間にモデルを格納

%% 姿勢変化を利用した投影
Proj = zeros(NL, NT, NP);

% NP が奇数だったら半分だけ計算する
if mod(NP,2) == 0
    NP2 = NP;
else
    NP2 = floor(NP/2);
end

% 本体
for it = 1:NT
    for ip = 1:NP2
        elevation_ia = theta(it);% 緯度
        azimuth_ia = phi(ip);% 経度
        ModelRotated = rot3d(NewSpace, -1*elevation_ia, -1*azimuth_ia, Interpolation, true);% 姿勢変化
        Proj(:,it,ip) = squeeze(sum(sum(ModelRotated)));% Z軸に投影（線積分）
        if mod(elevation_ia + pi/4, pi/2) == 0    % 45度角かどうか
            Proj(:,it,ip) = Proj(:,it,ip) / 1.0962;
        end
    end
end

% NP が奇数だったとき、後半に前半をコピペする
if mod(NP,2) == 1
    for il = 1:NL
        Proj(:,1:NT,(NP2+1):NP-1) = flip(Proj(:,NT:-1:1,1:NP2), 1);
        Proj(:,1:NT,NP) = flip(Proj(:,NT:-1:1,1), 1);
    end
end


end % fanction

