%% モデル間の特徴量ユークリッド距離比較
% クエリモデルごとにDBモデルとの距離を計算する
% 部品間の対応付けを行ってから、対応する部品間の距離の総和
% 
% 
% input : DescriptorQ クエリの特徴量
%         DesctiptorD データベースの特徴量
%                   DescriptorsCell{Label}(投影点数 NumberOfVertices, ラドン変換画像のサイズ Z*theta)
% 
% output: EachMinimumsTable{NQ}(NQC, ND)    クエリモデルごとに、各DBモデルとの（対応付け）部品最小距離
%         EachComponentNumber{NQ}(NQC, ND)  クエリモデルごとに、↑でDBのどの部品と対応付けされたか
%         EachDistanceTable{NQ,ND}(NQC,NDC) クエリモデルとDBモデルごとに、総当たり部品間距離
%         EachSumDistanceTable{NQ}(1, ND)   クエリモデルごとに、各DBモデルとの距離（非類似度）
% 
% 
% 　 DescriptorQ/D（クエリ/DBのモデルの特徴量を全てまとめたセル配列）
% ∋ DesQ/D, DescriptorsCell（モデルのすべての部品の特徴量をまとめたセル配列）
% ∋ DQ, DD （ある部品の特徴量行列（全周からの投影情報））
%
%%
function [EachMinimumsTable, EachComponentNumber, EachDistanceTable, EachSumDistanceTable] = ...
    EuclideanDistanceEmphasizedModel(DescriptorQ, DescriptorD)
%% 定数,セル配列の用意
NQ = length(DescriptorQ);   % クエリモデル数
ND = length(DescriptorD);   % データベースモデル数

EachDistanceTable = cell(NQ,ND);    % クエリとDBとで部品ごと総当たりで距離計算
EachMinimumsTable = cell(NQ,1);     % 各クエリとDBの組み合わせでの最短距離
EachComponentNumber = cell(NQ,1);   % 
EachSumDistanceTable = cell(NQ,1);  % 

%% 各モデルについて総当たり距離計算
for iq = 1:NQ   % クエリ全体についてループ
    DesQ = DescriptorQ{iq};             % クエリのとあるモデルに注目
    NQC = length(DesQ);                 % クエリの部品の数
    MinimumsTable = zeros(NQC, ND);     % クエリとDBモデル集合との部品最小距離をまとめた行列（クエリの部品数×DBモデル数）
    ComponentNumber = zeros(NQC, ND);   % ↑に対応するDBモデルの部品番号をまとめた行列（クエリの部品数×DBモデル数）
    SumDistanceTable = zeros(1, ND);    % 
    for id = 1:ND   % DB全体についてループ
        DesD = DescriptorD{id};                 % DBのとあるモデルに注目
        NDC = length(DesD);                     % DBの部品の数
        
        DistanceTable = zeros(NQC,NDC);         % クエリモデルとDBモデルとの距離を入れる行列（部品同士総当たり）
        EachDistanceDescriptor = cell(NQC,NDC); % ↑を全クエリ/DBで計算した結果をまとめるセル配列
        
        %%% 部品について総当たり距離計算
        for iqc = 1:NQC     % そのクエリモデルの部品についてループ
           DQ = DesQ{iqc};                              % クエリの部品（の特徴量行列）を１つ取り出す
            
            for idc = 1:NDC     % そのDBモデルの部品についてループ
                DD = DesD{idc};                                 % DBの部品（の特徴量行列）を１つ取り出す
                DistanceDescriptor = pdist2(DQ,DD);             % DQとDDの行同士（投影画像同士）を総当たりでユークリッド距離計算
                                                                % 各行に、DQのある投影画像とDDの各投影画像とのユークリッド距離が入った行列 
                DistanceTable(iqc,idc) = sum(min( DistanceDescriptor, [], 2));  % 各行の最小値の合計（スカラー）をDQ,DD間の距離（非類似度）に使う
                EachDistanceDescriptor{iqc,idc} = DistanceDescriptor;           % ユークリッド距離の計算結果全体をセル配列にまとめておく
            end
        end
        
        %%% 計算結果を行列にまとめる。適当な部品の対応付けを求める
        EachDistanceTable{iq,id} = DistanceTable;                   % クエリのあるモデルとDBのあるモデルとの距離（非類似度）をセル配列にまとめる
        [Minimums, ComponentSet] = FindComponentSet(DistanceTable); % クエリの部品とDBの部品との対応付けについて、最も適当な組み合わせを求める
        MinimumsTable(:,id) = Minimums;                             % クエリのモデルとDBのそれぞれのモデルとの部品最小距離を行列にまとめる
        ComponentNumber(:,id) = ComponentSet;                       % ↑に対応するDBモデルの部品番号を行列にまとめる
        
        %%% 部品の対応付けに応じて、モデル間の距離を計算する
        SumDistanceDescriptor = zeros(size(EachDistanceDescriptor{1,1}));   % size(NumberOfVertices, NumberOfVertices)
        for iCS = 1:NQC                                                     % クエリのそれぞれの部品について
            SumDistanceDescriptor = SumDistanceDescriptor + ...
                EachDistanceDescriptor{iCS, ComponentSet(iCS)};             % 対応付けた部品の組み合わせの「投影画像総当たりユークリッド距離」の足し合わせ
        end                                                                 
        SumDistanceTable(id) = sum(min( SumDistanceDescriptor, [], 2));     % 各行の最小値の合計（スカラー）をiq,id間の距離（非類似度）に使う
    end
    
    %%% 最終的な計算結果をセル配列にまとめる
    EachMinimumsTable{iq} = MinimumsTable;          % クエリモデルごとに、各DBモデルとの（対応付け）部品最小距離をセル配列にまとめる
    EachComponentNumber{iq} = ComponentNumber;      % クエリモデルごとに、↑でDBのどの部品と対応付けされたかをセル配列にまとめる
    EachSumDistanceTable{iq} = SumDistanceTable;    % クエリモデルごとに、各DBモデルとの距離（非類似度）をセル配列にまとめる
end
end

%% 各部品間のユークリッド距離から最も類似している部品の組み合わせを見つける
% Minimous(NQC,1) / クエリのそれぞれの部品についての最小距離
% ComponentSet(NQC,1) / クエリのそれぞれの部品と（既に決まったものを除いて）最も距離が近いDBの部品番号
% 
function [Minimums, ComponentSet] = FindComponentSet(Table)

%%% 部品の組み合わせと距離をセットにしたリストを作る
[NY,NX] = size(Table);      % (NQC,NDC) = size(DistanceTable) 部品の数 × 部品の数
NL = NY*NX;
List = zeros(NL,3);
index = 1;
for y = 1:NY    % クエリの各部品について 
    for x = 1:NX    % DBの各部品について
        List(index,1) = Table(y,x);     % 左列：部品間の距離（非類似度）
        List(index,2) = y;              % 中央：クエリの部品番号
        List(index,3) = x;              % 右列：DBの部品番号
        index = index + 1;
    end
end
ListSorted = sortrows(List,1);          % リストをソートして、部品間の距離が小さい組み合わせを探す

%%% ソートしたリストから順に探索
Minimums = zeros(NY,1);     % クエリのそれぞれの部品についての最小距離
ComponentSet = zeros(NY,1);
UsedX = zeros(NX,1);
for iL = 1:NL   % 部品間の距離が小さい組み合わせから順に検索
    iy = ListSorted(iL,2);      % その組み合わせのクエリの部品番号iy
    if ComponentSet(iy) == 0    % iyの相方がまだ決まっていない場合
        ix = ListSorted(iL,3);      % その組み合わせのDBの部品番号ix
        if UsedX(ix) == 0           % ixがまだ相方に選ばれていない場合
            ComponentSet(iy) = ix;              % DBの部品番号を記録（iyと最も距離が近い部品）
            Minimums(iy) = ListSorted(iL,1);    % この組み合わせのユークリッド距離を記録
            UsedX(ix) = 1;                      % DBの部品番号を重複して使わないように記録
        end
    end
end

end


