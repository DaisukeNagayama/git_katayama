%% 特徴量計算（SHT）
% DescriptorForEuclideanDistance.m の改造
% 部品ごとに ComputeDescriptor() を呼び出して特徴量を計算する
% 
% Interval の削除
% 
% ComputeDescriptor()
%   投影画像をラドン変換
%   フーリエ変換で振幅スペクトル
%   高周波フィルターをかける
% 
% 入力 : Projection{Label}(X,Y,theta,phi) / ラベルごとの投影画像集合
%       NumberOfHalving / 特徴量を何回分割するか。低周波成分カット
%       orderMax / 特徴量計算での球面調和変換の次数上限
%
% 出力 : DescriptorsCell{Label}(SHTの次数l, ラドン変換画像のサイズ Z*theta)
% 
%% TODO
% ラドン変換の箇所で２回フーリエ変換している意味 
%
%%
function [DescriptorsCell] = DescriptorForEuclideanDistance3(Projection, orderMax, NumberOfHalving)

if iscell(Projection) 
    %%% 部品ごとにラベル分けされているとき
    NC = length(Projection);% 投影されたモデルの部品数
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        Proj = Projection{ic}; % ラベルごとに
        DescriptorsCell{ic} = ComputeDescriptor(Proj, orderMax, NumberOfHalving); % 特徴量計算にぶんなげ
    end
else
    %%% 部品ごとにラベル分けされていないとき
    DescriptorsCell = ComputeDescriptor(Projection, orderMax, NumberOfHalving); % 特徴量計算にぶんなげ
end
end

%% 特徴量計算部
function [Des2] = ComputeDescriptor(Proj, orderMax, NumberOfHalving)

[NX,NY,NT,NP] = size(Proj);
theta = 0:Interval:179;% ラドン変換の投影角度
LT = length(theta);% 角度数
LR = length( radon(zeros(NX,NY),1) );% 動径長

% 分割をするかしないかで分ける
if NumberOfHalving == 0
    Des1 = zeros(NT, NP, LR*LT);
else
    DiameterLR = floor( ( LR/(2^(NumberOfHalving)) )/ 2 );
    DiameterLT = floor( ( LT/(2^(NumberOfHalving)) )/ 2 );
    Des1 = zeros( NT, NP, (DiameterLR*2+1)*(DiameterLT*2+1) );
end

for it = 1:NT
    for ip = 1:NP
        % ラドン変換＆フーリエ変換
        prj = Proj(:,:,it,tp);
        PR = radon(prj,theta);          % PR(Z,theta)
        PRF = abs(fft(PR,[],1));        % 
        PRFF = abs(fft(PRF,[],2));
        % 分割をするかしないかで分ける
        if NumberOfHalving == 0
            Des1(it,ip,:) = PRFF(:);     % Des(θ,φ,Z) : PRFF を一行にしてDes(θ,φ,:)に代入
        else
            % 高周波を削る
            PRFFC = FrequencyCut(PRFF, DiameterLR, DiameterLT);
            Des1(it,ip,:) = PRFFC(:);    % Des(θ,φ,Z) : PRFF を一行にしてDes(θ,φ,:)に代入
        end
    end
end

%%% 球面調和変換  PFHC(theta,phi,Z)
NZ2 = size(Des1,3);
fn = zeros(orderMax + 1, 2 * orderMax + 1, NZ2);    % fn(l,m,Z)
for iz = 1:NZ2
    fn(:,:,iz) = SHT(Des1(:,:,iz), orderMax);    % 球面調和変換
end

spectrum = zeros(orderMax+1, size(fn,3));
for iz = 1:size(fn,3)
    for il = 1 : orderMax+1
        COEF = zeros(size(fn(:,:,1)));
        COEF(il,:) = fn(il,:,iz);
        gg1 = SHBT(COEF); % 各次数ごとに再構成したときの球面波
        spectrum(il,iz) = SHnorm(gg1);
    end
end
Des2 = spectrum;

end
%% 高周波フィルター
function [FreqCut] = FrequencyCut(Freq, DiameterNR, DiameterNT)

FreqShift = fftshift(Freq);
[M1,I1] = max(FreqShift);
[~,I2] = max(M1);

TopCordinateX = I1(I2);
TopCordinateY = I2;

FreqCut = FreqShift(...
    TopCordinateX-DiameterNR:TopCordinateX+DiameterNR,...
    TopCordinateY-DiameterNT:TopCordinateY+DiameterNT);

end
