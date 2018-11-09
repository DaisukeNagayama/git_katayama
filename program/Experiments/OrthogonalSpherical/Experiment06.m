%% 球面調和関数を用いた特徴量の確認のための実験（改変版）
% 
% 投影視点
%  積分する必要があるため、Geodesic dome 視点ではなく 直交グリッドの交点視点を用いる
% 
% 
% [提案手法]
% クエリとデータベースのモデルについて、
% ・ランダムに回転と平行移動
% ・（投影計算）
%       ２次元投影の計算
%       各投影画像をラドン変換で振幅スペクトル（平行移動不変）
% ・振幅スペクトルは対称形なので片側だけ取り出す
% ・各層ごとにスカラー球面調和変換
% ・位数について総和をとって回転不変な特容量を得る
% クエリとデータベースの特徴量をユークリッド距離比較
% 
% 
% 


%% パラメーター設定
orderMax = 10;      % 球面調和展開の最大展開次数
elevationNum = 15;  % 緯度刻み数(始点と終点を含む)
azimuthNum = 31;    % 経度刻み数(始点と終点を含む)

theta = 0 : pi/(elevationNum - 1) : pi;
phi = 0 : 2*pi/(azimuthNum - 1) : 2*pi;

% 投影枚数。Geodesic Domeの頂点数に基づいている。
%NumberOfVertices = 12;
%NumberOfVertices = 42;
%NumberOfVertices = 92;
%NumberOfVertices = 162;
%NumberOfVertices = 252;
%NumberOfVertices = 362;
%NumberOfVertices = 492;
%NumberOfVertices = 642;
NumberOfVertices = elevationNum * azimuthNum; % Geodesic Dome をやめたので

EmphasisValue = 1; % 部品強調した投影での乗算項（初期値は１）
NumberOfHalving = 2; % 特徴量を分割する回数。ピークを中心に特徴量を半分のサイズになるように切り取る（高周波削減）。
Interval = 1; % ラドン変換の角度間隔（初期値は１）

%% モデル設定、姿勢変化および位置変化のパラメーター設定
%% 回転平行移動量の乱数生成
% モデルがはみ出さないような回転平行移動量を生成する
% [RotAzis, RotEles, Translation] = RotationTranslation(Models, Number)
% 
% クエリ用
% [RotAzis, RotEles, Translation] = (RotationTranslation({Clutch64001 Die64001 Gear64001},1));
% 
% データベース用
% [RotAzis, RotEles, Translation] = (RotationTranslation({Clutch64001 Die64001 Gear64001},5));
% 
%% 確認用
% %{

Query = {Clutch64001};
Database = {Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005};

%%% 全体 クエリ回転パターン＆平行移動パターン
disp('各クエリモデルの回転パターンを適用中...');
QueryRotAzi = [0];
QueryRotEle = [30];
QueryTranslation = [0 0 0];

%%% 全体 データベース回転パターン＆平行移動パターン
disp('各データベースモデルの回転パターンを適用中...');
DatabaseRotAzi = [0 0 0 0 0];
DatabaseRotEle = [30-45 30-65 30-135 30-170 30-180];
DatabaseTranslation = [0 0 0;0 0 0;0 0 0; 0 0 0; 0 0 0];
%}


%% 全体検索
%{

Query = {Clutch64001, Die64001, Gear64001};
Database = {Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Die64001, Die64002, Die64003, Die64004, Die64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005};

%%% 全体 クエリ回転パターン＆平行移動パターン
disp('各クエリモデルの回転パターンを適用中...');
QueryRotAzi = [0;170;55];
QueryRotEle = [83;6;61];
QueryTranslation = [-3 -1 1;-7 3 6;4 -9 1];

%%% 全体 データベース回転パターン＆平行移動パターン
disp('各データベースモデルの回転パターンを適用中...');
DatabaseRotAzi = [166;135;212;105;263; 94;152;12;259;152; 158;340;104;81;243];
DatabaseRotEle = [177;34;41;111;62; 107;17;12;174;16; 95;115;121;120;1];
DatabaseTranslation = [-4 2 8;-2 0 -10;-2 1 -6;-3 9 3;1 -12 3;-9 5 -7;4 2 12;-5 2 11;0 -6 -20;0 -3 1;0 6 -7;6 -6 -1;5 -6 -6;6 -1 2;-1 -5 8];
%}

%% 全体検索２
%{

Query = {Clutch96001, Die96001, Gear96001};
Database = {Clutch96001, Clutch96002, Clutch96003, Clutch96004, Clutch96005, Die96001, Die96002, Die96003, Die96004, Die96005, Gear96001, Gear96002, Gear96003, Gear96004, Gear96005};

%%% 全体 クエリ回転パターン＆平行移動パターン
disp('各クエリモデルの回転パターンを適用中...');
QueryRotAzi = [85;281;48];
QueryRotEle = [64;70;170];
QueryTranslation = [8,-4,-6;-14,-2,-2;6,1,-8];

%%% 全体 データベース回転パターン＆平行移動パターン
disp('各データベースモデルの回転パターンを適用中...');
DatabaseRotAzi = [293;35;57;51;236;  197;92;222;198;137;   281;4;190;248;329];
DatabaseRotEle = [163;50;175;76;6;   25;147;85;165;102;    168;61;30;135;27 ];
DatabaseTranslation = [-3 2 4;0 3 5;3 -1 14;15 2 2;3 3 7;    -9	-5 13;-11 11 -10;-13 3 2;-6	3 -2;-19 -6	-3;    -9 -5 -1;-4 5 -5;3 -4 0;1 -12 -8;5 3 11;];
%}

%% Clutch
%{

Query = {Clutch64001, Clutch64001, Clutch64001};
Database = {Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005};

%%% Clutch クエリ回転パターン＆平行移動パターン
disp('Clutchクエリの回転パターンを適用中...');
QueryRotAzi = [326;208;176];
QueryRotEle = [110;33;30];
QueryTranslation = [4,1,2;-3,3,-11;6,2,0];

%%% Clutch データベース回転パターン＆平行移動パターン
disp('Clutchデータベースの回転パターンを適用中...');
DatabaseRotAzi = [293;35;57;51;236;273;254;296;158;176;99;179;270;345;303];
DatabaseRotEle = [163;50;175;76;6;134;6;125;69;80;122;173;46;98;46];
DatabaseTranslation = [-3,2,4;0,3,5;3,-1,14;15,2,2;3,3,7;-2,0,-6;-2,-4,-18;-5,2,-5;8,2,-3;6,2,2;3,-2,-4;-2,1,-11;0,1,7;-15,-3,-3;5,-4,6];
%}

%% Die
%{
Query = {Die64001, Die64001, Die64001};
Database = {Die64001, Die64002, Die64003, Die64004, Die64005, Die64001, Die64002, Die64003, Die64004, Die64005, Die64001, Die64002, Die64003, Die64004, Die64005};

disp('Dieクエリの回転パターンAを適用中...');
QueryRotAzi = [356;178;71];
QueryRotEle = [7;140;5];
QueryTranslation = [9,9,16;-1,7,1;2,-1,6];

% disp('Dieクエリの回転パターンBを適用中...');
% QueryRotAzi = [71;97;354];
% QueryRotEle = [88;76;54];
% QueryTranslation = [-13,8,7;-7,11,2;-2,3,5];

% disp('Dieクエリの回転パターンCを適用中...');
% QueryRotAzi = [360;133;69];
% QueryRotEle = [31;83;77];
% QueryTranslation = [-14,1,15;6,-5,6;-8,-7,5];

%% Die データベース回転パターン＆平行移動パターン
disp('Dieデータベースの回転パターンを適用中...');
DatabaseRotAzi = [90;211;271;191;169;112;269;194;346;30;95;198;185;150;176];
DatabaseRotEle = [111;99;68;140;2;95;81;179;1;72;26;26;72;9;61];
DatabaseTranslation = [-9,-6,2;4,-3,0;-7,-13,-5;2,-7,-5;-5,-7,17;-18,1,-5;-21,-8,12;-10,-2,-22;6,5,20;-13,3,2;-11,9,9;0,1,3;-19,-6,-7;2,5,7;1,-4,-4];
%}

%% Die N2
%{
Query = {Die64N2001, Die64N2001, Die64N2001};
Database = {Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005, Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005, Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005};

%{
disp('Dieクエリの回転パターンAを適用中...');
QueryRotAzi = [356;178;71];
QueryRotEle = [7;140;5];
QueryTranslation = [9,9,16;-1,7,1;2,-1,6];
%}

%{
disp('Dieクエリの回転パターンBを適用中...');
QueryRotAzi = [71;97;354];
QueryRotEle = [88;76;54];
QueryTranslation = [-13,8,7;-7,11,2;-2,3,5];
%}

%{
disp('Dieクエリの回転パターンCを適用中...');
QueryRotAzi = [360;133;69];
QueryRotEle = [31;83;77];
QueryTranslation = [-14,1,15;6,-5,6;-8,-7,5];
%}

%% Die データベース回転パターン＆平行移動パターン
disp('Dieデータベースの回転パターンを適用中...');
DatabaseRotAzi = [90;211;271;191;169;112;269;194;346;30;95;198;185;150;176];
DatabaseRotEle = [111;99;68;140;2;95;81;179;1;72;26;26;72;9;61];
DatabaseTranslation = [-9,-6,2;4,-3,0;-7,-13,-5;2,-7,-5;-5,-7,17;-18,1,-5;-21,-8,12;-10,-2,-22;6,5,20;-13,3,2;-11,9,9;0,1,3;-19,-6,-7;2,5,7;1,-4,-4];
%}

%% Gear
%{
Query = {Gear64001, Gear64001, Gear64001};
Database = {Gear64001, Gear64002, Gear64003, Gear64004, Gear64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005};

%% Gear クエリ回転パターン＆平行移動パターン
disp('Gearクエリの回転パターンを適用中...');
QueryRotAzi = [31;263;347];
QueryRotEle = [47;88;98];
QueryTranslation = [8,-12,11;1,-13,-3;-1,-4,-6];

%% Gear データベース回転パターン＆平行移動パターン
disp('Gearデータベースの回転パターンを適用中...');
DatabaseRotAzi = [281;48;85;61;197;66;335;110;232;338;75;70;112;353;214];
DatabaseRotEle = [70;170;64;117;53;66;140;92;68;158;54;41;166;79;47];
DatabaseTranslation = [-6,-8,-7;6,1,-8;6,-4,-9;2,5,2;1,-5,3;3,8,-6;-2,1,1;0,9,3;4,0,-6;2,5,3;0,0,9;-5,-1,1;0,-3,7;-6,-4,-8;-1,6,-8];
%}

%% クエリモデルおよびデータベースモデルに姿勢変化と位置変化を加える
TimeStart = clock;

NQ = length(Query);% クエリモデル数
ND = length(Database);% データベースモデル数

% Query
QueryRT = cell(NQ,1);
for iq = 1:NQ
    tic;
    Q = Query{iq};
    QR = rot3d(Q, QueryRotEle(iq), QueryRotAzi(iq), 'nearest');
    QRT = circshift(QR,QueryTranslation(iq,:));
    QueryRT{iq} = QRT;
end
% Database
DatabaseRT = cell(ND,1);
for id = 1:ND
    D = Database{id};
    DR = rot3d(D, DatabaseRotEle(id), DatabaseRotAzi(id), 'nearest');
    DRT = circshift(DR,DatabaseTranslation(id,:));
    DatabaseRT{id} = DRT;
end

disp(strcat('クエリモデル数：', num2str(NQ)));
disp(strcat('データベースモデル数：', num2str(ND)));

DisplayExModel(QueryRT, DatabaseRT);

%% 投影計算
disp(strcat('投影数：', num2str(NumberOfVertices)));
disp(strcat('強調値：', num2str(EmphasisValue)));

TimeProjection0 = clock;

ProjectionQ = cell(NQ,1);
for ipq = 1:NQ
    QRT = QueryRT{ipq};
    ProjectionQ{ipq} = ProjectionEmphasizedModel2(QRT, theta, phi, EmphasisValue);
end

ProjectionD = cell(ND,1);
for ipd = 1:ND
    DRT = DatabaseRT{ipd};
    ProjectionD{ipd} = ProjectionEmphasizedModel2(DRT, theta, phi, EmphasisValue);
end

TimeProjection1 = clock;
TimeProjection = etime(TimeProjection1, TimeProjection0);

disp(strcat('投影画像計算時間：', num2str(TimeProjection), '[sec]'));
disp('----------------------------------------');
%% 特徴量計算
disp(strcat('特徴量の分割回数：', num2str(NumberOfHalving)));
disp(strcat('ラドン変換の角度数：', num2str(NumberOfVertices)));

TimeDescriptor0 = clock;

DescriptorQ = cell(NQ,1);
for idq = 1:NQ
    PrjQ = ProjectionQ{idq};
    DescriptorQ{idq} = DescriptorForEuclideanDistance2(PrjQ, orderMax, NumberOfHalving);
end

DescriptorD = cell(ND,1);
for idd = 1:ND
    PrjD = ProjectionD{idd};
    DescriptorD{idd} = DescriptorForEuclideanDistance2(PrjD, orderMax, NumberOfHalving);
end

TimeDescriptor1 = clock;
TimeDescriptor = etime(TimeDescriptor1, TimeDescriptor0);

DescriptorLength = numel(DescriptorQ{1}{1});
disp(strcat('特徴量の長さ：', num2str(DescriptorLength)));
disp(strcat('特徴量計算時間：', num2str(TimeDescriptor), '[sec]'));
disp('----------------------------------------');
%% 各モデル間の特徴量をユークリッド距離で比較

TimeCompare0 = clock;

[EachMinimumsTable, EachComponentNumber, EachDistanceTable] = EuclideanDistanceEmphasizedModel2(DescriptorQ, DescriptorD);

TimeCompare1 = clock;
TimeCompare = etime(TimeCompare1, TimeCompare0);

disp(strcat('ユークリッド距離計算時間：', num2str(TimeCompare), '[sec]'));

%% 時間記録

TimeRecord = {...
    '投影画像計算時間：', TimeProjection;...
    '特徴量計算時間：', TimeDescriptor;...
    'ユークリッド距離計算時間：', TimeCompare;...
    };

disp('----------------------------------------');
for iTR = 1:size(TimeRecord)
    disp(strcat(...
        TimeRecord{iTR,1},'：', num2str(TimeRecord{iTR,2}), '[sec]'));    
end

TimeEnd = clock;
TimeExperiment = etime(TimeEnd, TimeStart);
disp(strcat('実験時間：', num2str(TimeExperiment), '[sec]'));

%% 正答数
NumberOfCorrectAnswer = 0;
for irq = 1:NQ
    [~,AnswerModel] = min(EachSumDistanceTable{irq});
    NumberOfCorrectAnswer = NumberOfCorrectAnswer + (AnswerModel == 5*irq - 4); % データベースが5つずつ前提、
end
disp(strcat('正答数：', num2str(NumberOfCorrectAnswer), '/', num2str(NQ)));

%% 処理終了
load handel; sound(y,Fs);



