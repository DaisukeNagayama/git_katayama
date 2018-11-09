%% 特徴量計算（SHT）
% DescriptorForEuclideanDistance.m の改造
% 部品ごとに ComputeDescriptor() を呼び出して特徴量を計算する
% 
% SHTの処理が冗長
% 球面調和関数を事前に用意しておくなど、処理の最速化が必要
% 
% ComputeDescriptor()
%   投影画像集合を動径方向にフーリエ変換
%   低周波だけ残す
%   
% 
% 入力 : Projection{Label}(Z,theta,phi) / ラベルごとの投影画像集合
%       NumberOfHalving / 特徴量を何回分割するか。低周波成分カット
%       orderMax / 特徴量計算での球面調和変換の次数上限
%
% 出力 : DescriptorsCell{Label}(高周波フィルター後のサイズ NZ2, SHTによる各次数の係数)
% 
%%
function [DescriptorsCell] = DescriptorForEuclideanDistance2(Projection, orderMax, NumberOfHalving)

[NZ,NT,NP] = size(Projection{1});

% 使用する球面調和関数を事前に用意しておく
SHs = makeSH(orderMax,NT,NP);

% 
if iscell(Projection) 
    %%% 部品ごとにラベル分けされているとき
    NC = length(Projection);% 投影されたモデルの部品数
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        disp(strcat('    コンポーネント', num2str(ic), ' の特徴量計算'));
        Proj = Projection{ic}; % ラベルごとに
        DescriptorsCell{ic} = ComputeDescriptor(Proj, SHs, NumberOfHalving); % 特徴量計算にぶんなげ
    end
else
    %%% 部品ごとにラベル分けされていないとき
    DescriptorsCell = ComputeDescriptor(Projection, SHs, NumberOfHalving); % 特徴量計算にぶんなげ
end
end

%% 投影画像集合から特徴量計算
function [Des] = ComputeDescriptor(Proj, SHs, NumberOfHalving)

[NZ,NT,NP] = size(Proj);
orderMax = size(SHs,1) - 1;

%%% 投影画像集合を動径方向にフーリエ変換
prj = fft(Proj,[],1);                           % prj(Z,θ,φ)
PF = abs(prj/NZ);                               % パワー(振幅)スペクトルを抽出
PFH = permute(PF(1:ceil(NZ/2),:,:),[2,3,1]);    % 左右対称なので片側のみ取り出す PFH(θ,φ,Z)
NZ2 = size(PFH,3)/(2^NumberOfHalving);          % 取り出す範囲を指定
PFHC = PFH(:,:,1:NZ2);                          % ピークを中心にカット（高周波成分を削減）

%%% 球面調和変換
fn = zeros(orderMax + 1, 2 * orderMax + 1, NZ2);    % fn(l,m,Z)
for iz = 1:NZ2
    for il = 0:orderMax
        for im = -il:il
            fn(il+1,orderMax+im+1,iz) = SHnorm(PFHC(:,:,iz) .* SHs{il+1,orderMax+im+1}); % 球面調和変換
        end
    end
end

%%% 次数ごとの L2-norm の総和の計算
spectrum = zeros(size(fn,3), orderMax+1);
for iz = 1:size(fn,3)
    for il = 0 : orderMax
        COEF = zeros(size(fn(:,:,1)));
        COEF(il+1,:) = fn(il+1,:,iz);   % iz層目の 次数il の段だけコピー
        gg1 = SHBT(COEF);               
        % plotSH(gg1,1)     % 各次数ごとに再構成したときの球面波
        spectrum(iz,il+1) = SHnorm(gg1);
    end
end
Des = spectrum;

end

%% 球面調和変換
function coefficient = SHT(yy,orderMax)
% サンプリング点の数を読み込み
polarNum = size(yy,1);    % ルジャンドル多項式の次数（ガウス緯度を何点とるのか）
azimuthNum = size(yy,2);  % 経度方向に何点とるか(始点(0)と終点(2π)を両方カウント)

% 通常の緯度経度
theta_ = 0 : pi/(polarNum - 1) : pi;
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi;
[phi,theta] = meshgrid(phi_,theta_);

% ガウス緯度μと経度λの計算
syms X;
LegPolynomial = legendreP(polarNum, X);     % polarNum次のルジャンドル多項式
mu_ = vpasolve(LegPolynomial == 0);          % ルジャンドル多項式の根がガウス緯度になる
mu_ = fliplr(double(mu_)');                     % シンボリックから倍精度数へ変換          
lambda_ = 0 : 2*pi / (azimuthNum - 1) : 2*pi;    % 経度の刻み幅
[lambda,mu] = meshgrid(lambda_,mu_);

% Gauss-Legendre 積分に使うガウス重みの計算
d_LegPolynomial = diff(LegPolynomial, X);
weight = double((((1-mu_.^2) .* (subs(d_LegPolynomial, mu_)).^2)/2).^-1);

% 入力球面波を一般緯度からガウス緯度に変換する
yy = spline(theta(:,1), yy', acos(mu(:,1)))';


% SHT(Spherical Harmonic Transform algorithm)
% 係数格納用の変数、球面調和関数のピラミッド図みたいな直角二等辺三角形状に格納
coefficient = zeros(orderMax + 1, 2 * orderMax + 1);

for order = 0 : orderMax    % 球面調和関数を低次から順に
    % Plm(μj) ルジャンドル陪関数
    Plms = legendre(order, mu(:,1)); % orderごとにまとめて生成
    
    for degree = -order : order % ループで回して係数計算する        
        
        % degree に対応する Plm を取り出す
        Plm = Plms(abs(degree) + 1,:);
        
        % 台形積分 横方向に積分
        G = yy .* exp(-1i * degree * lambda);
        G = trapz(lambda_, G, 2)';
        
        % 符号と正規化
        sign = (-1)^((degree+abs(degree))/2);
        normSH = sqrt( (4*pi)/(2*order+1) * factorial(order+abs(degree)) / factorial(order-abs(degree)) );
        
        % ガウス・ルジャンドル積分 縦方向に積分 
        coefficient(order+1, degree+orderMax+1) = ...
            sign/normSH * sum(weight .* Plm .* G);     
    end
end
end % function SHT()

%% 球面調和関数をまとめたセル配列を生成
function SHs = makeSH(orderMax,NT,NP)

SHs = cell(orderMax + 1, 2 * orderMax + 1);

for il = 0:orderMax
    for im = -il:il
        SHs{il+1, orderMax+im+1} = SH(il,im,NT,NP);
    end 
end

end

%%%%%%%%%%%%
% 正規化 球面調和関数 Ylm を 計算する
% 実数球面調和関数は 立方調和関数 や Tesseral spherical harmonics とも呼ぶらしい
function Ylm = SH(l,m,polarNum,azimuthNum)

% 球面グリッドの作成
theta_ = 0 : pi/(polarNum - 1) : pi;     % polar angle
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi; % azimuth angle
[phi,theta] = meshgrid(phi_,theta_);      % define the grid

% ルジャンドル陪関数の用意
Plm = legendre(l, cos(theta(:,1))); % 各行に Pl0 から Pll までが並んだ行列
Plm = Plm(abs(m) + 1,:)';           % Plm の行を取り出して縦にする
Plm = repmat(Plm,1,size(phi,2));    % 球面グリッドのサイズに合わせる

% 符号と正規化
sign = (-1)^((m+abs(m))/2);
normSH = sqrt( 4*pi / (2*l+1) * factorial(l+abs(m)) / factorial(l-abs(m)) );

% 複素数 球面調和関数
Ylm = zeros(polarNum, azimuthNum);
Ylm(:,:) = sign / normSH * Plm .* exp(1i * m * phi);

% 実数 球面調和関数
% if m > 0
%     Ylm(:,:) = sqrt(2) * sign/normSH * Plm .* cos(abs(m) * phi);
% elseif m < 0 
%     Ylm(:,:) = sqrt(2) * sign/normSH * Plm .* sin(abs(m) * phi);
% else
%     Ylm(:,:) = sign/normSH * Plm;
% end

end

%% 球面スカラー場のL2ノルムを求める
%       input : SH  球面スカラー場
function norm = SHnorm(yy) 
% サンプリング点の数を読み込み
polarNum = size(yy,1);    % ルジャンドル多項式の次数（ガウス緯度を何点とるのか）
azimuthNum = size(yy,2);  % 経度方向に何点とるか(始点(0)と終点(2π)を両方カウント)

% 緯度経度
theta_ = 0 : pi/(polarNum - 1) : pi;
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi;
[phi,theta] = meshgrid(phi_,theta_);

% ガウス緯度μと経度λの計算
syms X;
LegPolynomial = legendreP(polarNum, X);     % polarNum次のルジャンドル多項式
mu_ = vpasolve(LegPolynomial == 0);          % ルジャンドル多項式の根がガウス緯度になる
mu_ = fliplr(double(mu_)');                     % シンボリックから倍精度数へ変換          
lambda_ = 0 : 2*pi / (azimuthNum - 1) : 2*pi;    % 経度の刻み幅
[lambda,mu] = meshgrid(lambda_,mu_);

% Gauss-Legendre 積分に使うガウス重みの計算
d_LegPolynomial = diff(LegPolynomial, X);
weight = double((((1-mu_.^2) .* (subs(d_LegPolynomial, mu_)).^2)/2).^-1);

% 入力球面波を一般緯度からガウス緯度に変換する
yy = spline(theta(:,1), yy', acos(mu(:,1)))';

% ノルム計算
% 2乗してから球面で積分
G = abs(yy).^2;

% 台形求積（φ方向に積分）
G = trapz(G,2)' /2/pi;

% ガウス・ルジャンドル積分（θ方向に積分）
norm = sum(weight .* G);

end

