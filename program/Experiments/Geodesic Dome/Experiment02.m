%% Experiment02.m
% 

%% �p�����[�^�[�ݒ�
% ���e�����BGeodesic Dome�̒��_���Ɋ�Â��Ă���B
%NumberOfVertices = 12;
%NumberOfVertices = 42;
%NumberOfVertices = 92;
NumberOfVertices = 162;
%NumberOfVertices = 252;
%NumberOfVertices = 362;
%NumberOfVertices = 492;
%NumberOfVertices = 642;

Extension = 5;
EmphasisValue = 1;% ���݁A���ʂ͂Ȃ��B
NumberOfHalving = 5;% �����ʂ𕪊�����񐔁B�s�[�N�𒆐S�ɓ����ʂ𔼕��̃T�C�Y�ɂȂ�悤�ɐ؂���i�����g�팸�j�B
Interval = 1;% ���h���ϊ��̊p�x�Ԋu�i�����l�͂P�j

%% ���f���ݒ�A�p���ω�����шʒu�ω��̃p�����[�^�[�ݒ�

%
Query = {Clutch64001};
Database ={Clutch64001,Clutch64002,Clutch64003,Clutch64004,Clutch64005};

% 40�p�^�[��
QueryRotAzi = [288;48;22;226;60;122;97;354;251;62;69;308;174;210;297;39;214;64;251;115;259;220;55;315;87;24;124;139;166;13;123;330;33;232;75;162;238;221;115;230];
QueryRotEle = [82;31;72;53;19;171;76;54;120;6;66;116;22;45;177;163;4;76;126;96;174;140;51;93;122;46;140;165;139;32;109;48;104;117;128;83;75;105;21;98];
QueryTranslation = [-3,4,-8;-3,6,10;0,-2,1;-2,-9,11;-3,-6,-1;7,-8,12;1,8,-2;5,1,-1;-12,-7,10;0,6,7;-2,8,-9;-5,-7,-1;3,-4,-5;-5,2,-7;4,-4,6;7,5,-12;-1,-4,-20;-21,2,-2;4,-9,-9;8,-1,5;0,-5,-20;-2,-8,-7;-2,0,-3;25,1,7;-8,3,4;-8,3,7;4,-8,3;-9,0,-4;-5,6,-1;4,-1,-12;-14,5,-5;7,-7,-6;8,0,-2;5,2,9;-7,-6,1;9,5,-3;16,5,-4;1,6,-4;7,3,-1;8,0,5];

DatabaseRotAzi = [219;318;158;123;143];

DatabaseRotEle = [103;130;21;68;93];
DatabaseTranslation = [-10,-1,4;-14,2,-2;6,-3,-11;1,2,-3;10,9,4];

%}

%{
Query = {Die_64001};
Database = {Die_64001, Die_64002,Die_64003,Die_64004, Die_64005};
% 40�p�^�[��
QueryRotAzi = [157;319;214;73;250;56;263;264;254;18;28;44;55;187;186;306;36;238;159;192;208;108;130;93;254;1;97;338;95;344;245;278;145;213;12;68;199;344;130;225];
QueryRotEle = [149;168;91;82;130;101;65;77;20;41;120;121;4;155;26;165;91;93;170;100;156;72;25;54;44;40;31;40;12;78;127;41;57;60;96;58;49;168;34;98];
QueryTranslation = [-7,2,1;-10,-5,6;-3,7,-1;-11,13,6;-11,0,-6;-1,-2,4;-9,-4,11;-2,16,10;-8,3,6;3,-12,15;-7,-7,-3;-6,-10,-13;-3,7,12;-15,11,-20;-3,-15,15;5,0,-16;-4,6,-11;-22,10,0;2,-2,4;-1,-5,-10;-6,-9,-10;3,-3,2;-9,-11,5;-10,-16,6;-1,-13,3;-19,-10,-5;-14,3,19;-6,-3,7;-5,-13,-11;9,7,-11;-4,1,-12;-11,14,15;-5,8,12;2,-2,12;1,-9,-6;-10,1,-4;-13,-7,-3;6,6,-20;-14,-5,11;-10,-5,-3];

DatabaseRotAzi = [188;23;226;50;310;121];
DatabaseRotEle = [179;73;139;125;87;45];
DatabaseTranslation = [-11,-12,-26;-10,-3,9;1,10,-14;-16,0,-5;-13,4,6];

%}

%{
Query = {Gear64001};
Database = {Gear64001, Gear64002, Gear64003, Gear_64004, Gear64005};

%40�p�^�[��
QueryRotAzi = [274;44;71;4;141;20;234;21;67;98;157;284;179;305;345;92;83;32;200;114;97;105;32;210;142;48;171;290;192;351;95;70;179;328;341;186;145;254;193;209];
QueryRotEle = [137;91;121;96;4;81;131;176;35;27;16;42;116;91;112;155;104;58;95;81;94;153;151;51;149;121;163;81;128;14;137;179;146;35;137;179;168;101;173;96];
QueryTranslation = [1,0,4;-5,-13,-9;-5,9,-5;-8,13,6;4,7,13;3,3,2;-2,1,-15;-3,0,14;-3,15,-2;-4,2,-12;5,-18,0;-1,-3,-13;-6,9,15;-7,6,-6;0,-8,-15;12,13,6;8,3,15;2,-16,7;10,12,12;7,-9,-13;14,13,-7;13,8,-9;1,11,-11;6,-8,-4;6,-12,-8;-1,-10,-8;-4,-17,-17;-3,4,-3;13,-4,3;-3,-1,-4;14,-4,8;6,1,6;-6,-14,-1;-1,10,-11;0,-7,1;4,14,5;-2,-12,-5;8,8,10;-16,-13,-7;13,3,0];

DatabaseRotAzi = [77;159;111;107;274];
DatabaseRotEle = [161;2;82;11;114];
DatabaseTranslation = [-15,-2,-14;15,-13,-13;-13,16,-7;-9,-9,-1;-13,-21,8];
%}


PatternQuery = length(QueryRotEle);
disp(strcat('�p���p�^�[���F',num2str(PatternQuery)))

TimeStart = clock;

NQ = length(Query);% �N�G�����f����
ND = length(Database);% �f�[�^�x�[�X���f����

for iq0 = 1:NQ
    Q0 = Query{iq0};
    Query{iq0} = ExtendSizeOfModel(Q0,Extension);
end

for id0 = 1:ND
    D0 = Database{id0};
    Database{id0} = ExtendSizeOfModel(D0,Extension);
end

%% �f�[�^�x�[�X�̏������ɍs��
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
    ProjectionD{ipd} = ProjectionEmphasizedModel(DRT, NumberOfVertices, EmphasisValue);
end

DescriptorD = cell(ND,1);
for idd = 1:ND
    PrjD = ProjectionD{idd};
    DescriptorD{idd} = DescriptorForEuclideanDistance(PrjD, NumberOfHalving, Interval);
end

%index = 1;
Result = zeros(ND,length(PatternQuery));
for iPQ = 1:PatternQuery
    
    %% �N�G�����f���Ɏp���ω��ƈʒu�ω���������
    
    % Query
    QueryRT = cell(NQ,1);
    for iq = 1:NQ
        tic;
        Q = Query{iq};
        QR = rot3d(Q, QueryRotEle(iPQ), QueryRotAzi(iPQ), 'nearest');
        QRT = circshift(QR,QueryTranslation(iPQ,:));
        QueryRT{iq} = QRT;
    end
    
    disp(strcat('�N�G�����f�����F', num2str(NQ)));
    disp(strcat('�f�[�^�x�[�X���f�����F', num2str(ND)));
    
    %DisplayExModel(QueryRT, DatabaseRT);
    %% ���e�v�Z
    disp(strcat('���e���F', num2str(NumberOfVertices)));
    disp(strcat('�����l�F', num2str(EmphasisValue)));
    
    TimeProjection0 = clock;
    
    ProjectionQ = cell(NQ,1);
    for ipq = 1:NQ
        QRT = QueryRT{ipq};
        ProjectionQ{ipq} = ProjectionEmphasizedModel(QRT, NumberOfVertices, EmphasisValue);
    end
    
    TimeProjection1 = clock;
    TimeProjection = etime(TimeProjection1, TimeProjection0);
    
    disp(strcat('���e�摜�v�Z���ԁF', num2str(TimeProjection), '[sec]'));
    disp('----------------------------------------');
    %% �����ʌv�Z
    disp(strcat('�����ʂ̕����񐔁F', num2str(NumberOfHalving)));
    disp(strcat('���h���ϊ��̊p�x���F', num2str(180/Interval)));
    
    TimeDescriptor0 = clock;
    
    DescriptorQ = cell(NQ,1);
    for idq = 1:NQ
        PrjQ = ProjectionQ{idq};
        DescriptorQ{idq} = DescriptorForEuclideanDistance(PrjQ, NumberOfHalving, Interval);
    end
    
    TimeDescriptor1 = clock;
    TimeDescriptor = etime(TimeDescriptor1, TimeDescriptor0);
    
    DescriptorLength = size(DescriptorQ{1}{1},2);
    disp(strcat('�����ʂ̒����F', num2str(DescriptorLength)));
    disp(strcat('�����ʌv�Z���ԁF', num2str(TimeDescriptor), '[sec]'));
    disp('----------------------------------------');
    %% �e���f���Ԃ̓����ʂ����[�N���b�h�����Ŕ�r
    
    TimeCompare0 = clock;
    
    [EachMinimumsTable, EachComponentNumber, EachDistanceTable, EachSumDistanceTable] = EuclideanDistanceEmphasizedModel(DescriptorQ, DescriptorD);
    
    TimeCompare1 = clock;
    TimeCompare = etime(TimeCompare1, TimeCompare0);
    
    disp(strcat('���[�N���b�h�����v�Z���ԁF', num2str(TimeCompare), '[sec]'));
    
    Result(:,iPQ) = sum(EachMinimumsTable{1})';
    %% ���ԋL�^
    
    TimeRecord = {...
        '���e�摜�v�Z���ԁF', TimeProjection;...
        '�����ʌv�Z���ԁF', TimeDescriptor;...
        '���[�N���b�h�����v�Z���ԁF', TimeCompare;...
        };
    
    disp('----------------------------------------');
    for iTR = 1:size(TimeRecord)
        disp(strcat(...
            TimeRecord{iTR,1},'�F', num2str(TimeRecord{iTR,2}), '[sec]'));
    end
    
end
TimeEnd = clock;
TimeExperiment = etime(TimeEnd, TimeStart);
disp(strcat('�������ԁF', num2str(TimeExperiment), '[sec]'));

load handel; sound(y,Fs);
