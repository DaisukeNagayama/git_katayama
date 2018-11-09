%% 全体図
% 
% projection 投影計算
%   input: ３次元モデル（頂点の集合だったりボクセルだったり）(x,y,z)×モデル数
%   output: 投影点に対応した２次元画像(θ,φ,x,y)×モデル数
% 
% descriptor 特徴量計算
%   input: 球面上のテンソル(θ,φ,x,y)×モデル数
%   output: 特徴量(Z)×モデル数
% 
% compare 類似度計算
%   input: クエリの特徴量(Z)×クエリ数, データベースの特徴量(Z)×データベース数
%   output: あるクエリとデータベース全体との類似度(データベース数)×クエリ数

%% projection 投影計算

サンプリング点
θ(t) = π(2t+1)/(2L-1)
where t = 0 : L-1

φ(p) = 2πp/(2L-1)
where p = 0 : 2L-2

%% descriptor 特徴量計算

input: 球面上のテンソル(θ,φ,x,y)×モデル数
    
前処理
    球面上のベクトル場に変換したい
    各点における画像(x,y)を２次元フーリエ変換(u,v)
    

fast spherical harmonic transform
    球をトーラスに拡張

procedure FORWARD TRANSFORM(sf)
    sf を φ 方向についてフーリエ変換
    θ 方向について 2π まで拡張
    θ 方向についてアップサンプリング
    反映された重みの逆フーリエ変換によって乗算し、θ 方向にフーリエ変換することで係数 sGmm' を得る
    sGmm' から球面調和係数 sflm を計算する
    return sflm
end procedure

O( L^2 * log2(L) )
    
sGmm' = 2π * sum[m''=-(L-1):L-1]{sFmm'' * w(m''-m')}
w(m') = if[m'=±1]    ±iπ/2 
        elif[m' 奇数] 0
        elif[m' 偶数] 2/(1-m'^2)


output: 特徴量(Z)×モデル数



compare 類似度計算



