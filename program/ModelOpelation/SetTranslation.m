Model = ExtendSizeOfModel(Gear56001,5);

QueryRotAzi = [274;44;71;4;141;20;234;21;67;98;157;284;179;305;345;92;83;32;200;114;97;105;32;210;142;48;171;290;192;351;95;70;179;328;341;186;145;254;193;209];
QueryRotEle = [137;91;121;96;4;81;131;176;35;27;16;42;116;91;112;155;104;58;95;81;94;153;151;51;149;121;163;81;128;14;137;179;146;35;137;179;168;101;173;96];

DatabaseRotAzi = [77;159;111;107;274];
DatabaseRotEle = [161;2;82;11;114];

QueryTranslation = Translation(Model, QueryRotEle, QueryRotAzi); 
DatabaseTranslation = Translation(Model, DatabaseRotEle, DatabaseRotAzi);

PatternQuery = length(QueryRotEle);
disp(strcat('姿勢パターン：',num2str(PatternQuery)))   

TimeStart = clock;

NQ = length(QueryRotEle);% クエリモデル数
ND = length(DatabaseRotEle);% データベースモデル数

QueryRT = cell(NQ,1);
for iq = 1:NQ
    Q = Model;
    QR = rot3d(Q, QueryRotEle(iq), QueryRotAzi(iq), 'nearest');
    QRT = circshift(QR,QueryTranslation(iq,:));
    GroundWallOfSpace(QRT);
    QueryRT{iq} = QRT;
end

DatabaseRT = cell(ND,1);
for id = 1:ND
    D = Model;
    OneSideD = size(D,1);
    DR = rot3d(D, DatabaseRotEle(id), DatabaseRotAzi(id), 'nearest');
    DRT = circshift(DR,DatabaseTranslation(id,:));
    GroundWallOfSpace(DRT);
    DatabaseRT{id} = DRT;
end

