%% Experiment04.m
% 

%% パラメーター設定
% 投影枚数。Geodesic Domeの頂点数に基づいている。
%NumberOfVertices = 12;
%NumberOfVertices = 42;
%NumberOfVertices = 92;
NumberOfVertices = 162;
%NumberOfVertices = 252;
%NumberOfVertices = 362;
%NumberOfVertices = 492;
%NumberOfVertices = 642;

Extension = 5;
EmphasisValue = 1;% 現在、効果はない。
NumberOfHalving = 0;% 特徴量を分割する回数。ピークを中心に特徴量を半分のサイズになるように切り取る（高周波削減）。
Interval = 1;% ラドン変換の角度間隔（初期値は１）

%% モデル設定、姿勢変化および位置変化のパラメーター設定

%{
Query = {new_Clutch_64001};
%Database ={new_Clutch_64001,new_Clutch_64002,new_Clutch_64003,new_Clutch_64004,new_Clutch_64005,new_Clutch_64006];
Database = {new_Clutch_64001,new_Clutch_64002,new_Clutch_64003,new_Clutch_64004,new_Clutch_64005,new_Clutch_64006...
    new_Die_64001, new_Die_64002, new_Die_64003, new_Die_64004, new_Die_64005,new_Die_64006...
    new_Gear64001, new_Gear64002, new_Gear64003, new_Gear_64004, new_Gear64005,new_Gear64006...
    S5_64001, S5_64002, S5_64003, S5_64004,S5_64005,S5_64006};

% 40パターン
QueryRotAzi = [288;48;22;226;60;122;97;354;251;62;69;308;174;210;297;39;214;64;251;115;259;220;55;315;87;24;124;139;166;13;123;330;33;232;75;162;238;221;115;230];
QueryRotEle = [82;31;72;53;19;171;76;54;120;6;66;116;22;45;177;163;4;76;126;96;174;140;51;93;122;46;140;165;139;32;109;48;104;117;128;83;75;105;21;98];
QueryTranslation = [-3,4,-8;-3,6,10;0,-2,1;-2,-9,11;-3,-6,-1;7,-8,12;1,8,-2;5,1,-1;-12,-7,10;0,6,7;-2,8,-9;-5,-7,-1;3,-4,-5;-5,2,-7;4,-4,6;7,5,-12;-1,-4,-20;-21,2,-2;4,-9,-9;8,-1,5;0,-5,-20;-2,-8,-7;-2,0,-3;25,1,7;-8,3,4;-8,3,7;4,-8,3;-9,0,-4;-5,6,-1;4,-1,-12;-14,5,-5;7,-7,-6;8,0,-2;5,2,9;-7,-6,1;9,5,-3;16,5,-4;1,6,-4;7,3,-1;8,0,5];

%DatabaseRotAzi = [219;318;158;123;143;294];
DatabaseRotAzi = [219;318;158;123;143;294;188;23;226;50;310;121;77;159;111;107;274;68;296;259;349;192;118;39];
%DatabaseRotEle = [103;130;21;68;93;164];
DatabaseRotEle = [103;130;21;68;93;164;179;73;139;125;87;45;161;2;82;11;114;132;110;141;77;17;48;28];
%DatabaseTranslation = [-10,-1,4;-14,2,-2;6,-3,-11;1,2,-3;10,9,4;-4,5,-10];
DatabaseTranslation = [-10,-1,4;-14,2,-2;6,-3,-11;1,2,-3;10,9,4;-4,5,-10;...
    -11,-12,-26;-10,-3,9;1,10,-14;-16,0,-5;-13,4,6;4,-10,-8;...
  -15,-2,-14;15,-13,-13;-13,16,-7;-9,-9,-1;-13,-21,8;4,-8,12;...
  11,-5,9;5,-15,3;-4,13,-15;-1,-2,-1;8,-6,9;-1,-14,-10];
%}

%
Query = {new_Die_64001};
%Database = {new_Die_64001, new_Die_64002, new_Die_64003, new_Die_64004, new_Die_64005,new_Die_64006};
Database = {new_Clutch_64001,new_Clutch_64002,new_Clutch_64003,new_Clutch_64004,new_Clutch_64005,new_Clutch_64006...
    new_Die_64001, new_Die_64002, new_Die_64003, new_Die_64004, new_Die_64005,new_Die_64006...
    new_Gear64001, new_Gear64002, new_Gear64003, new_Gear_64004, new_Gear64005,new_Gear64006...
    S5_64001, S5_64002, S5_64003, S5_64004,S5_64005,S5_64006};

% 40パターン
QueryRotAzi = [157;319;214;73;250;56;263;264;254;18;28;44;55;187;186;306;36;238;159;192;208;108;130;93;254;1;97;338;95;344;245;278;145;213;12;68;199;344;130;225];
QueryRotEle = [149;168;91;82;130;101;65;77;20;41;120;121;4;155;26;165;91;93;170;100;156;72;25;54;44;40;31;40;12;78;127;41;57;60;96;58;49;168;34;98];
QueryTranslation = [-7,2,1;-10,-5,6;-3,7,-1;-11,13,6;-11,0,-6;-1,-2,4;-9,-4,11;-2,16,10;-8,3,6;3,-12,15;-7,-7,-3;-6,-10,-13;-3,7,12;-15,11,-20;-3,-15,15;5,0,-16;-4,6,-11;-22,10,0;2,-2,4;-1,-5,-10;-6,-9,-10;3,-3,2;-9,-11,5;-10,-16,6;-1,-13,3;-19,-10,-5;-14,3,19;-6,-3,7;-5,-13,-11;9,7,-11;-4,1,-12;-11,14,15;-5,8,12;2,-2,12;1,-9,-6;-10,1,-4;-13,-7,-3;6,6,-20;-14,-5,11;-10,-5,-3];

%DatabaseRotAzi = [188;23;226;50;310;121];
DatabaseRotAzi = [219;318;158;123;143;294;188;23;226;50;310;121;77;159;111;107;274;68;296;259;349;192;118;39];
%DatabaseRotEle = [179;73;139;125;87;45];
DatabaseRotEle = [103;130;21;68;93;164;179;73;139;125;87;45;161;2;82;11;114;132;110;141;77;17;48;28];
%DatabaseTranslation = [-11,-12,-26;-10,-3,9;1,10,-14;-16,0,-5;-13,4,6;4,-10,-8];
DatabaseTranslation = [-10,-1,4;-14,2,-2;6,-3,-11;1,2,-3;10,9,4;-4,5,-10;...
    -11,-12,-26;-10,-3,9;1,10,-14;-16,0,-5;-13,4,6;4,-10,-8;...
  -15,-2,-14;15,-13,-13;-13,16,-7;-9,-9,-1;-13,-21,8;4,-8,12;...
  11,-5,9;5,-15,3;-4,13,-15;-1,-2,-1;8,-6,9;-1,-14,-10];

%}

%{
Query = {new_Gear64001};
Database = {new_Gear64001, new_Gear64002, new_Gear64003, new_Gear_64004, new_Gear64005,new_Gear64006};

%40パターン
QueryRotAzi = [274;44;71;4;141;20;234;21;67;98;157;284;179;305;345;92;83;32;200;114;97;105;32;210;142;48;171;290;192;351;95;70;179;328;341;186;145;254;193;209];
QueryRotEle = [137;91;121;96;4;81;131;176;35;27;16;42;116;91;112;155;104;58;95;81;94;153;151;51;149;121;163;81;128;14;137;179;146;35;137;179;168;101;173;96];
QueryTranslation = [1,0,4;-5,-13,-9;-5,9,-5;-8,13,6;4,7,13;3,3,2;-2,1,-15;-3,0,14;-3,15,-2;-4,2,-12;5,-18,0;-1,-3,-13;-6,9,15;-7,6,-6;0,-8,-15;12,13,6;8,3,15;2,-16,7;10,12,12;7,-9,-13;14,13,-7;13,8,-9;1,11,-11;6,-8,-4;6,-12,-8;-1,-10,-8;-4,-17,-17;-3,4,-3;13,-4,3;-3,-1,-4;14,-4,8;6,1,6;-6,-14,-1;-1,10,-11;0,-7,1;4,14,5;-2,-12,-5;8,8,10;-16,-13,-7;13,3,0];

DatabaseRotAzi = [77;159;111;107;274;68];
DatabaseRotEle = [161;2;82;11;114;132];
DatabaseTranslation = [-15,-2,-14;15,-13,-13;-13,16,-7;-9,-9,-1;-13,-21,8;4,-8,12];
%}

%{
Query = {S5_64001};
Database = {S5_64001, S5_64002, S5_64003, S5_64004,S5_64005,S5_64006};

%40パターン
QueryRotAzi =[329,228,36,101,197,345,348,57,350,345,175,289,52,152,330,286,346,237,13,306,337,245,273,268,142,236,62,255,12,100,17,35,297,251,115,343,13,158,138,276];
QueryRotEle =[144,34,89,81,117,128,136,50,123,118,30,22,90,173,62,106,41,136,46,92,126,161,173,99,25,27,47,152,46,147,44,168,63,36,46,111,86,64,150,106];
QueryTranslation =[-15,1,-10;15,7,2;-1,-14,6;-14,-13,1;-13,10,10;7,-11,5;1,15,5;9,-1,-2;10,-13,-11;-10,-3,10;9,-14,-3;1,-3,5;4,-6,-2;-15,15,-10;-12,-4,-9;3,-5,14;13,-14,7;-7,-2,1;14,-3,15;-6,6,5;1,6,5;-10,-12,15;-10,-14,2;12,5,-10;-4,-1,15;-11,11,4;-4,-10,-2;-1,-12,3;-8,-4,3;-8,-6,4;-7,10,15;7,-5,3;-12,13,12;10,-7,3;-15,-2,-6;-10,-10,-2;-13,3,-1;6,6,4;-14,-13,-6;1,5,-3];

DatabaseRotAzi = [296;259;349;192;118;39];
DatabaseRotEle = [110;141;77;17,;48;28];
DatabaseTranslation =[11,-5,9;5,-15,3;-4,13,-15;-1,-2,-1;8,-6,9;-1,-14,-10];
%}

%{
Query = {Gearf_64001};
Database = {Gearf_64001, Gearf_64002, Gearf_64003, Gearf_64004,Gearf_64005,Gearf_64006};

%40パターン
QueryRotAzi=[260,170,55,123,219,69,266,88,330,97,275,68,104,33,207,246,197,153,232,233,244,229,340,76,255,85,43,219,162,165,238,277,126,238,150,303,300,93,221,210];
QueryRotEle=[97,156,48,57,22,169,116,86,115,98,116,98,130,94,178,40,19,20,12,73,81,66,137,113,139,167,175,35,25,125,17,95,95,155,87,71,121,133,94,63];
QueryTranslation =[-11,3,-7;-14,8,-8;-2,6,-4;7,-3,6;6,-2,-15;-5,-2,-7;-9,10,-2;12,-3,8;-3,10,8;-4,-9,9;14,-5,5;-2,10,8;-10,11,15;-1,12,3;-11,-9,-3;8,10,9;-6,1,-13;-12,-11,6;4,-10,5;-11,-14,11;2,13,6;3,10,12;15,-15,11;3,15,1;-1,9,-8;-2,12,2;11,7,3;-8,5,-13;4,5,7;12,15,8;3,13,2;-15,-12,11;6,11,-9;2,4,-15;4,-4,-14;8,-10,-12;-9,-11,-10;-14,4,-7;1,6,3;1,-2,-12];

DatabaseRotAzi = [177,307,314,98,75,203];
DatabaseRotEle = [75,170,19,30,103,167];
DatabaseTranslation=[5,-15,11;2,11,-5;-2,-14,-10;5,-5,12;-12,15,1;6,15,-7];
%}
PatternQuery = length(QueryRotEle);
disp(strcat('姿勢パターン：',num2str(PatternQuery)))

TimeStart = clock;

NQ = length(Query);% クエリモデル数
ND = length(Database);% データベースモデル数

for iq0 = 1:NQ
    Q0 = Query{iq0};
    Query{iq0} = ExtendSizeOfModel(Q0,Extension);
end

for id0 = 1:ND
    D0 = Database{id0};
    Database{id0} = ExtendSizeOfModel(D0,Extension);
end

%% データベースの処理を先に行う
% Database
DatabaseRT = cell(ND,1);
for id = 1:ND
    D = Database{id};
    DR = rot3d(D, DatabaseRotEle(id), DatabaseRotAzi(id), 'nearest');
    DRT = circshift(DR,DatabaseTranslation(id,:));
    DatabaseRT{id} = DRT;
end

ProjectionD = cell(ND,1);
for ipd = 1:ND
    DRT = DatabaseRT{ipd};
    ProjectionD{ipd} = VerticesProjection(DRT, NumberOfVertices);
end

DescriptorD = cell(ND,1);
for idd = 1:ND
    PrjD = ProjectionD{idd};
    DescriptorD{idd} = DescriptorForEuclideanDistance(PrjD, NumberOfHalving, Interval);
end

%index = 1;
Result = zeros(ND,length(PatternQuery));
for iPQ = 1:PatternQuery
    
    %% クエリモデルに姿勢変化と位置変化を加える
    
    % Query
    QueryRT = cell(NQ,1);
    for iq = 1:NQ
        tic;
        Q = Query{iq};
        QR = rot3d(Q, QueryRotEle(iPQ), QueryRotAzi(iPQ), 'nearest');
        QRT = circshift(QR,QueryTranslation(iPQ,:));
        QueryRT{iq} = QRT;
    end
    
    disp(strcat('クエリモデル数：', num2str(NQ)));
    disp(strcat('データベースモデル数：', num2str(ND)));
    
    %DisplayExModel(QueryRT, DatabaseRT);
    %% 投影計算
    disp(strcat('投影数：', num2str(NumberOfVertices)));
    disp(strcat('強調値：', num2str(EmphasisValue)));
    
    TimeProjection0 = clock;
    
    ProjectionQ = cell(NQ,1);
    for ipq = 1:NQ
        QRT = QueryRT{ipq};
        ProjectionQ{ipq} = VerticesProjection(QRT, NumberOfVertices);
    end
    
    TimeProjection1 = clock;
    TimeProjection = etime(TimeProjection1, TimeProjection0);
    
    disp(strcat('投影画像計算時間：', num2str(TimeProjection), '[sec]'));
    disp('----------------------------------------');
    %% 特徴量計算
    disp(strcat('特徴量の分割回数：', num2str(NumberOfHalving)));
    disp(strcat('ラドン変換の角度数：', num2str(180/Interval)));
    
    TimeDescriptor0 = clock;
    
    DescriptorQ = cell(NQ,1);
    for idq = 1:NQ
        PrjQ = ProjectionQ{idq};
        DescriptorQ{idq} = DescriptorForEuclideanDistance(PrjQ, NumberOfHalving, Interval);
    end
    
    TimeDescriptor1 = clock;
    TimeDescriptor = etime(TimeDescriptor1, TimeDescriptor0);
    
    DescriptorLength = size(DescriptorQ{1},2);
    disp(strcat('特徴量の長さ：', num2str(DescriptorLength)));
    disp(strcat('特徴量計算時間：', num2str(TimeDescriptor), '[sec]'));
    disp('----------------------------------------');
    %% 各モデル間の特徴量をユークリッド距離で比較
    
    TimeCompare0 = clock;
    
    [EachMinimumsTable, EachComponentNumber, EachDistanceTable, EachSumDistanceTable] = EuclideanDistanceEmphasizedModel(DescriptorQ, DescriptorD);
    
    TimeCompare1 = clock;
    TimeCompare = etime(TimeCompare1, TimeCompare0);
    
    disp(strcat('ユークリッド距離計算時間：', num2str(TimeCompare), '[sec]'));
    
    Result(:,iPQ) = sum(EachMinimumsTable{1})';
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
    
end
TimeEnd = clock;
TimeExperiment = etime(TimeEnd, TimeStart);
disp(strcat('実験時間：', num2str(TimeExperiment), '[sec]'));

load handel; sound(y,Fs);
