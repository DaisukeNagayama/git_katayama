% 球面テンソル代数の計算手順の確認

%% 入力用データの用意
Query = {Clutch64001};
Database = {Clutch64001, Clutch64001, Clutch64001, Clutch64004, Clutch64004};

%% パラメータ設定
% 展開次数の設定
L = 5;

% スピン数
S = -L:L;
NS = length(S);

% サンプリング点の設定
t = 0:L-1;
theta = pi * (2*t+1)/(2*L-1);
NT = length(theta);

p = 0:2*L-2;
phi = 2*pi*p/(2*L-1);
NP = length(phi);

%% 

sf = zeros(NT,NP,S);

G = fft(sf,[],1);

for iS = 1:S
    Gw = [G, (-1)^is * flip(sf,1)];
end
theta = [theta, flip(theta,1)];

%     θ 方向についてアップサンプリング
%     反映された重みの逆フーリエ変換によって乗算し、θ 方向にフーリエ変換することで係数 sGmm' を得る
%     sGmm' から球面調和係数 sflm を計算する
%     return sflm
% end procedure

