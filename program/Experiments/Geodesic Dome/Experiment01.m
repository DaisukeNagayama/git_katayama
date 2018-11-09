%% Experiment01.m
% ���C���֐�
% ��{�I�ɂ͂���
% 

%% �p�����[�^�[�ݒ�
% ���e�����BGeodesic Dome�̒��_���Ɋ�Â��Ă���B
%NumberOfVertices = 12;
%NumberOfVertices = 42;
NumberOfVertices = 92;
%NumberOfVertices = 162;
%NumberOfVertices = 252;
% NumberOfVertices = 362;
%NumberOfVertices = 492;
%NumberOfVertices = 642;

EmphasisValue = 1;      % ���i�������e�ł̋�����i�����l:�P�j
NumberOfHalving = 2;    % �����ʂ𕪊�����񐔁B�s�[�N�𒆐S�ɓ����ʂ𔼕��̃T�C�Y�ɂȂ�悤�ɐ؂���i�����g�팸�j�B
Interval = 1;           % ���h���ϊ��̊p�x�Ԋu�i�����l�͂P�j

%% ���f���ݒ�A�p���ω�����шʒu�ω��̃p�����[�^�[�ݒ�
%% ��]���s�ړ��ʂ̗�������
% ���f�����͂ݏo���Ȃ��悤�ȉ�]���s�ړ��ʂ𐶐�����i�R�}���h�E�B���h�E�ɃR�s�y���Ď��s�j
% [RotAzis, RotEles, Translation] = RotationTranslation(Models, Number)
% 
% �S�̌����̃N�G���̏ꍇ
% [RotAzis, RotEles, Translation] = (RotationTranslation({Clutch64001 Die64001 Gear64001},1));
% 
% �S�̌����̃f�[�^�x�[�X�̏ꍇ
% [RotAzis, RotEles, Translation] = (RotationTranslation({Clutch64001 Die64001 Gear64001},5));
% 
%% �m�F�p�̊ȈՌ���
% %{

%%% ��]�ɂ��ގ��x�̕ω��m�F�p(���ׂĐ������f���Ȃ̂Ő������C�ɂ��Ȃ��Ă悢)
% Query = {Clutch64001}; Database = {Clutch64001, Clutch64001, Clutch64001, Clutch64001, Clutch64001};

%%% �e���f���K����
Query = {Clutch64001}; Database = {Clutch64001, Clutch64004, Clutch64004, Clutch64004, Clutch64004};
% Query = {Die64001}; Database = {Die64001, Die64004, Die64004, Die64004, Die64004};
% Query = {Gear64001}; Database = {Gear64001, Gear64004, Gear64004, Gear64004, Gear64004};

%%% �S�� �N�G����]�p�^�[�������s�ړ��p�^�[��
disp('�e�N�G�����f���̉�]�p�^�[����K�p��...');
QueryRotAzi = [0];
QueryRotEle = [30];
QueryTranslation = [0 0 0];

%%% �S�� �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('�e�f�[�^�x�[�X���f���̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [0 0 0 0 0];
DatabaseRotEle = [30-45 30-65 30-135 30-170 30-180];
DatabaseTranslation = [0 0 0;0 0 0;0 0 0; 0 0 0; 0 0 0];
%}


%% �S�̌���
%{

Query = {Clutch64001, Die64001, Gear64001};
Database = {Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Die64001, Die64002, Die64003, Die64004, Die64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005};

%%% �S�� �N�G����]�p�^�[�������s�ړ��p�^�[��
disp('�e�N�G�����f���̉�]�p�^�[����K�p��...');
QueryRotAzi = [177;281;93];
QueryRotEle = [88;15;74];
QueryTranslation = [-9 4 -2; 5 2 7; 2 -7 -3];

%%% �S�� �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('�e�f�[�^�x�[�X���f���̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [40;35;22;15;162;  157;292;108;81;67;   256;153;11;85;83];
DatabaseRotEle = [140;24;42;30;98;   80;96;85;31;163;    40;91;167;83;88 ];
DatabaseTranslation = [-1 -4 -3; 3 2 2; -3 1 -10; 1 1 3; -7 1 -3;   4 4 2; -8 1 10; -1 15 -8; -7 2 2; 4 2 -18;    -10 -4 -1; -9 -5 -1; 8 2 3; 10 -1 -7; 3 3 10];
%}

%% Clutch
%{

Query = {Clutch64001, Clutch64001, Clutch64001};
Database = {Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005, Clutch64001, Clutch64002, Clutch64003, Clutch64004, Clutch64005};

%%% Clutch �N�G����]�p�^�[�������s�ړ��p�^�[��
disp('Clutch�N�G���̉�]�p�^�[����K�p��...');
QueryRotAzi = [326;208;176];
QueryRotEle = [110;33;30];
QueryTranslation = [4,1,2;-3,3,-11;6,2,0];

%%% Clutch �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('Clutch�f�[�^�x�[�X�̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [293;35;57;51;236;273;254;296;158;176;99;179;270;345;303];
DatabaseRotEle = [163;50;175;76;6;134;6;125;69;80;122;173;46;98;46];
DatabaseTranslation = [-3,2,4;0,3,5;3,-1,14;15,2,2;3,3,7;-2,0,-6;-2,-4,-18;-5,2,-5;8,2,-3;6,2,2;3,-2,-4;-2,1,-11;0,1,7;-15,-3,-3;5,-4,6];
%}

%% Die
%{
Query = {Die64001, Die64001, Die64001};
Database = {Die64001, Die64002, Die64003, Die64004, Die64005, Die64001, Die64002, Die64003, Die64004, Die64005, Die64001, Die64002, Die64003, Die64004, Die64005};

%{
disp('Die�N�G���̉�]�p�^�[��A��K�p��...');
QueryRotAzi = [356;178;71];
QueryRotEle = [7;140;5];
QueryTranslation = [9,9,16;-1,7,1;2,-1,6];
%}

%{
disp('Die�N�G���̉�]�p�^�[��B��K�p��...');
QueryRotAzi = [71;97;354];
QueryRotEle = [88;76;54];
QueryTranslation = [-13,8,7;-7,11,2;-2,3,5];
%}

%{
disp('Die�N�G���̉�]�p�^�[��C��K�p��...');
QueryRotAzi = [360;133;69];
QueryRotEle = [31;83;77];
QueryTranslation = [-14,1,15;6,-5,6;-8,-7,5];
%}

%% Die �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('Die�f�[�^�x�[�X�̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [90;211;271;191;169;112;269;194;346;30;95;198;185;150;176];
DatabaseRotEle = [111;99;68;140;2;95;81;179;1;72;26;26;72;9;61];
DatabaseTranslation = [-9,-6,2;4,-3,0;-7,-13,-5;2,-7,-5;-5,-7,17;-18,1,-5;-21,-8,12;-10,-2,-22;6,5,20;-13,3,2;-11,9,9;0,1,3;-19,-6,-7;2,5,7;1,-4,-4];
%}

%% Die N2
%{
Query = {Die64N2001, Die64N2001, Die64N2001};
Database = {Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005, Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005, Die64N2001, Die64N2002, Die64N2003, Die64N2004, Die64N2005};

%{
disp('Die�N�G���̉�]�p�^�[��A��K�p��...');
QueryRotAzi = [356;178;71];
QueryRotEle = [7;140;5];
QueryTranslation = [9,9,16;-1,7,1;2,-1,6];
%}

%{
disp('Die�N�G���̉�]�p�^�[��B��K�p��...');
QueryRotAzi = [71;97;354];
QueryRotEle = [88;76;54];
QueryTranslation = [-13,8,7;-7,11,2;-2,3,5];
%}

%{
disp('Die�N�G���̉�]�p�^�[��C��K�p��...');
QueryRotAzi = [360;133;69];
QueryRotEle = [31;83;77];
QueryTranslation = [-14,1,15;6,-5,6;-8,-7,5];
%}

%% Die �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('Die�f�[�^�x�[�X�̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [90;211;271;191;169;112;269;194;346;30;95;198;185;150;176];
DatabaseRotEle = [111;99;68;140;2;95;81;179;1;72;26;26;72;9;61];
DatabaseTranslation = [-9,-6,2;4,-3,0;-7,-13,-5;2,-7,-5;-5,-7,17;-18,1,-5;-21,-8,12;-10,-2,-22;6,5,20;-13,3,2;-11,9,9;0,1,3;-19,-6,-7;2,5,7;1,-4,-4];
%}

%% Gear
%{
Query = {Gear64001, Gear64001, Gear64001};
Database = {Gear64001, Gear64002, Gear64003, Gear64004, Gear64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005, Gear64001, Gear64002, Gear64003, Gear64004, Gear64005};

%%% Gear �N�G����]�p�^�[�������s�ړ��p�^�[��
disp('Gear�N�G���̉�]�p�^�[����K�p��...');
QueryRotAzi = [31;263;347];
QueryRotEle = [47;88;98];
QueryTranslation = [8,-12,11;1,-13,-3;-1,-4,-6];

%%% Gear �f�[�^�x�[�X��]�p�^�[�������s�ړ��p�^�[��
disp('Gear�f�[�^�x�[�X�̉�]�p�^�[����K�p��...');
DatabaseRotAzi = [281;48;85;61;197;66;335;110;232;338;75;70;112;353;214];
DatabaseRotEle = [70;170;64;117;53;66;140;92;68;158;54;41;166;79;47];
DatabaseTranslation = [-6,-8,-7;6,1,-8;6,-4,-9;2,5,2;1,-5,3;3,8,-6;-2,1,1;0,9,3;4,0,-6;2,5,3;0,0,9;-5,-1,1;0,-3,7;-6,-4,-8;-1,6,-8];
%}

%% �N�G�����f������уf�[�^�x�[�X���f���Ɏp���ω��ƈʒu�ω���������

TimeStart = clock;

NQ = length(Query);% �N�G�����f����
ND = length(Database);% �f�[�^�x�[�X���f����

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

disp(strcat('�N�G�����f�����F', num2str(NQ)));
disp(strcat('�f�[�^�x�[�X���f�����F', num2str(ND)));

DisplayExModel(QueryRT, DatabaseRT);

%% ���e�v�Z
disp(strcat('���e���F', num2str(NumberOfVertices)));
disp(strcat('�����l�F', num2str(EmphasisValue)));

TimeProjection0 = clock;

ProjectionQ = cell(NQ,1);
for ipq = 1:NQ
    disp(strcat('���e�v�Z: ', num2str(ipq), '�Ԗڂ̃N�G�����f��'));
    QRT = QueryRT{ipq};
    ProjectionQ{ipq} = ProjectionEmphasizedModel(QRT, NumberOfVertices, EmphasisValue);
end

ProjectionD = cell(ND,1);
for ipd = 1:ND
    disp(strcat('���e�v�Z: ', num2str(ipd), '�Ԗڂ̃f�[�^�x�[�X���f��'));
    DRT = DatabaseRT{ipd};
    ProjectionD{ipd} = ProjectionEmphasizedModel(DRT, NumberOfVertices, EmphasisValue);
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
    disp(strcat('�����ʌv�Z: ', num2str(idq), '�Ԗڂ̃N�G�����f��'));
    PrjQ = ProjectionQ{idq};
    DescriptorQ{idq} = DescriptorForEuclideanDistance(PrjQ, NumberOfHalving, Interval);
end

DescriptorD = cell(ND,1);
for idd = 1:ND
    disp(strcat('�����ʌv�Z: ', num2str(idd), '�Ԗڂ̃f�[�^�x�[�X���f��'));
    PrjD = ProjectionD{idd};
    DescriptorD{idd} = DescriptorForEuclideanDistance(PrjD, NumberOfHalving, Interval);
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

%% ���ԋL�^
diary on

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

TimeEnd = clock;
TimeExperiment = etime(TimeEnd, TimeStart);
disp(strcat('�������ԁF', num2str(TimeExperiment), '[sec]'));

%% ������
% �S�̌����p
% 5���}�W�b�N�i���o�[�ɂȂ��Ă��܂��Ă���̂Ō�ŏC��
NumberOfCorrectAnswer = 0;
for irq = 1:NQ
    [~,AnswerModel] = min(EachSumDistanceTable{irq});
    NumberOfCorrectAnswer = NumberOfCorrectAnswer + (AnswerModel == 5*irq - 4); % �f�[�^�x�[�X��5���O��A
end
disp(strcat('�������F', num2str(NumberOfCorrectAnswer), '/', num2str(NQ)));

%% �����I��
diary off

% load handel; sound(y,Fs);


