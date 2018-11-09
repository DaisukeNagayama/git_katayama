%% 特徴量計算（ラドン変換＆フーリエ変換）
% 部品ごとに ComputeDescriptor() を呼び出して特徴量を計算する
% 
% ComputeDescriptor()
%   投影画像をラドン変換
%   フーリエ変換で振幅スペクトル
%   高周波フィルターをかける
% 
% 入力 : Projection{Label}(X,Y,投影点) / ラベルごとの投影画像集合
%       NumberOfHalving / 特徴量を何回分割するか。低周波成分カット
%       Interval / 特徴量計算でのラドン変換の角度刻み幅（度数）
% 
% 出力 : DescriptorsCell{Label}(投影点数 NumberOfVertices, ラドン変換画像のサイズ Z*theta)
% 
%% ラベルごとに投影画像集合を特徴量計算関数に投げる
function [DescriptorsCell] = DescriptorForEuclideanDistance(Projection, NumberOfHalving, Interval)

if iscell(Projection) 
    %%% 部品ごとにラベル分けされているとき
    NC = length(Projection); % 投影されたモデルの部品数
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        Proj = Projection{ic}; % ラベルごとに
        DescriptorsCell{ic} = ComputeDescriptor(Proj, NumberOfHalving, Interval); % 特徴量計算にぶんなげ
    end
else
    %%% 部品ごとにラベル分けされていないとき
    DescriptorsCell = ComputeDescriptor(Projection, NumberOfHalving, Interval); % 特徴量計算にぶんなげ
end
end
%% 投影画像集合から特徴量計算
function [Des] = ComputeDescriptor(Proj, NumberOfHalving, Interval)

[NX,NY,NZ] = size(Proj);
theta = 0:Interval:179;% ラドン変換の投影角度
NT = length(theta);% 角度数
NR = length( radon(zeros(NX,NY),1) );% 動径長

% 分割をするかしないかで分ける
if NumberOfHalving == 0
    Des = zeros(NZ, NR*NT);
else
    DiameterNR = floor( ( NR/(2^(NumberOfHalving)) )/ 2 );
    DiameterNT = floor( ( NT/(2^(NumberOfHalving)) )/ 2 );
    Des = zeros( NZ, (DiameterNR*2+1)*(DiameterNT*2+1) );
end

for i = 1:NZ
    % ラドン変換＆フーリエ変換
    prj = Proj(:,:,i);
    PR = radon(prj,theta);
    PRF = abs(fft(PR,[],1));
    PRFF = abs(fft(PRF,[],2));
    % 分割をするかしないかで分ける
    if NumberOfHalving == 0
        Des(i,:) = PRFF(:);     % PRFF を Des の一行にする
    else
        % 高周波を削る
        PRFFC = FrequencyCut(PRFF, DiameterNR, DiameterNT);
        Des(i,:) = PRFFC(:);     % PRFF を Des の一行にする
    end
end

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