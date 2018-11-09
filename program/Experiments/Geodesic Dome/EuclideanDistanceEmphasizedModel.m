%% ���f���Ԃ̓����ʃ��[�N���b�h������r
% �N�G�����f�����Ƃ�DB���f���Ƃ̋������v�Z����
% ���i�Ԃ̑Ή��t�����s���Ă���A�Ή����镔�i�Ԃ̋����̑��a
% 
% 
% input : DescriptorQ �N�G���̓�����
%         DesctiptorD �f�[�^�x�[�X�̓�����
%                   DescriptorsCell{Label}(���e�_�� NumberOfVertices, ���h���ϊ��摜�̃T�C�Y Z*theta)
% 
% output: EachMinimumsTable{NQ}(NQC, ND)    �N�G�����f�����ƂɁA�eDB���f���Ƃ́i�Ή��t���j���i�ŏ�����
%         EachComponentNumber{NQ}(NQC, ND)  �N�G�����f�����ƂɁA����DB�̂ǂ̕��i�ƑΉ��t�����ꂽ��
%         EachDistanceTable{NQ,ND}(NQC,NDC) �N�G�����f����DB���f�����ƂɁA�������蕔�i�ԋ���
%         EachSumDistanceTable{NQ}(1, ND)   �N�G�����f�����ƂɁA�eDB���f���Ƃ̋����i��ގ��x�j
% 
% 
% �@ DescriptorQ/D�i�N�G��/DB�̃��f���̓����ʂ�S�Ă܂Ƃ߂��Z���z��j
% �� DesQ/D, DescriptorsCell�i���f���̂��ׂĂ̕��i�̓����ʂ��܂Ƃ߂��Z���z��j
% �� DQ, DD �i���镔�i�̓����ʍs��i�S������̓��e���j�j
%
%%
function [EachMinimumsTable, EachComponentNumber, EachDistanceTable, EachSumDistanceTable] = ...
    EuclideanDistanceEmphasizedModel(DescriptorQ, DescriptorD)
%% �萔,�Z���z��̗p��
NQ = length(DescriptorQ);   % �N�G�����f����
ND = length(DescriptorD);   % �f�[�^�x�[�X���f����

EachDistanceTable = cell(NQ,ND);    % �N�G����DB�Ƃŕ��i���Ƒ�������ŋ����v�Z
EachMinimumsTable = cell(NQ,1);     % �e�N�G����DB�̑g�ݍ��킹�ł̍ŒZ����
EachComponentNumber = cell(NQ,1);   % 
EachSumDistanceTable = cell(NQ,1);  % 

%% �e���f���ɂ��đ������苗���v�Z
for iq = 1:NQ   % �N�G���S�̂ɂ��ă��[�v
    DesQ = DescriptorQ{iq};             % �N�G���̂Ƃ��郂�f���ɒ���
    NQC = length(DesQ);                 % �N�G���̕��i�̐�
    MinimumsTable = zeros(NQC, ND);     % �N�G����DB���f���W���Ƃ̕��i�ŏ��������܂Ƃ߂��s��i�N�G���̕��i���~DB���f�����j
    ComponentNumber = zeros(NQC, ND);   % ���ɑΉ�����DB���f���̕��i�ԍ����܂Ƃ߂��s��i�N�G���̕��i���~DB���f�����j
    SumDistanceTable = zeros(1, ND);    % 
    for id = 1:ND   % DB�S�̂ɂ��ă��[�v
        DesD = DescriptorD{id};                 % DB�̂Ƃ��郂�f���ɒ���
        NDC = length(DesD);                     % DB�̕��i�̐�
        
        DistanceTable = zeros(NQC,NDC);         % �N�G�����f����DB���f���Ƃ̋���������s��i���i���m��������j
        EachDistanceDescriptor = cell(NQC,NDC); % ����S�N�G��/DB�Ōv�Z�������ʂ��܂Ƃ߂�Z���z��
        
        %%% ���i�ɂ��đ������苗���v�Z
        for iqc = 1:NQC     % ���̃N�G�����f���̕��i�ɂ��ă��[�v
           DQ = DesQ{iqc};                              % �N�G���̕��i�i�̓����ʍs��j���P���o��
            
            for idc = 1:NDC     % ����DB���f���̕��i�ɂ��ă��[�v
                DD = DesD{idc};                                 % DB�̕��i�i�̓����ʍs��j���P���o��
                DistanceDescriptor = pdist2(DQ,DD);             % DQ��DD�̍s���m�i���e�摜���m�j�𑍓�����Ń��[�N���b�h�����v�Z
                                                                % �e�s�ɁADQ�̂��铊�e�摜��DD�̊e���e�摜�Ƃ̃��[�N���b�h�������������s�� 
                DistanceTable(iqc,idc) = sum(min( DistanceDescriptor, [], 2));  % �e�s�̍ŏ��l�̍��v�i�X�J���[�j��DQ,DD�Ԃ̋����i��ގ��x�j�Ɏg��
                EachDistanceDescriptor{iqc,idc} = DistanceDescriptor;           % ���[�N���b�h�����̌v�Z���ʑS�̂��Z���z��ɂ܂Ƃ߂Ă���
            end
        end
        
        %%% �v�Z���ʂ��s��ɂ܂Ƃ߂�B�K���ȕ��i�̑Ή��t�������߂�
        EachDistanceTable{iq,id} = DistanceTable;                   % �N�G���̂��郂�f����DB�̂��郂�f���Ƃ̋����i��ގ��x�j���Z���z��ɂ܂Ƃ߂�
        [Minimums, ComponentSet] = FindComponentSet(DistanceTable); % �N�G���̕��i��DB�̕��i�Ƃ̑Ή��t���ɂ��āA�ł��K���ȑg�ݍ��킹�����߂�
        MinimumsTable(:,id) = Minimums;                             % �N�G���̃��f����DB�̂��ꂼ��̃��f���Ƃ̕��i�ŏ��������s��ɂ܂Ƃ߂�
        ComponentNumber(:,id) = ComponentSet;                       % ���ɑΉ�����DB���f���̕��i�ԍ����s��ɂ܂Ƃ߂�
        
        %%% ���i�̑Ή��t���ɉ����āA���f���Ԃ̋������v�Z����
        SumDistanceDescriptor = zeros(size(EachDistanceDescriptor{1,1}));   % size(NumberOfVertices, NumberOfVertices)
        for iCS = 1:NQC                                                     % �N�G���̂��ꂼ��̕��i�ɂ���
            SumDistanceDescriptor = SumDistanceDescriptor + ...
                EachDistanceDescriptor{iCS, ComponentSet(iCS)};             % �Ή��t�������i�̑g�ݍ��킹�́u���e�摜�������胆�[�N���b�h�����v�̑������킹
        end                                                                 
        SumDistanceTable(id) = sum(min( SumDistanceDescriptor, [], 2));     % �e�s�̍ŏ��l�̍��v�i�X�J���[�j��iq,id�Ԃ̋����i��ގ��x�j�Ɏg��
    end
    
    %%% �ŏI�I�Ȍv�Z���ʂ��Z���z��ɂ܂Ƃ߂�
    EachMinimumsTable{iq} = MinimumsTable;          % �N�G�����f�����ƂɁA�eDB���f���Ƃ́i�Ή��t���j���i�ŏ��������Z���z��ɂ܂Ƃ߂�
    EachComponentNumber{iq} = ComponentNumber;      % �N�G�����f�����ƂɁA����DB�̂ǂ̕��i�ƑΉ��t�����ꂽ�����Z���z��ɂ܂Ƃ߂�
    EachSumDistanceTable{iq} = SumDistanceTable;    % �N�G�����f�����ƂɁA�eDB���f���Ƃ̋����i��ގ��x�j���Z���z��ɂ܂Ƃ߂�
end
end

%% �e���i�Ԃ̃��[�N���b�h��������ł��ގ����Ă��镔�i�̑g�ݍ��킹��������
% Minimous(NQC,1) / �N�G���̂��ꂼ��̕��i�ɂ��Ă̍ŏ�����
% ComponentSet(NQC,1) / �N�G���̂��ꂼ��̕��i�Ɓi���Ɍ��܂������̂������āj�ł��������߂�DB�̕��i�ԍ�
% 
function [Minimums, ComponentSet] = FindComponentSet(Table)

%%% ���i�̑g�ݍ��킹�Ƌ������Z�b�g�ɂ������X�g�����
[NY,NX] = size(Table);      % (NQC,NDC) = size(DistanceTable) ���i�̐� �~ ���i�̐�
NL = NY*NX;
List = zeros(NL,3);
index = 1;
for y = 1:NY    % �N�G���̊e���i�ɂ��� 
    for x = 1:NX    % DB�̊e���i�ɂ���
        List(index,1) = Table(y,x);     % ����F���i�Ԃ̋����i��ގ��x�j
        List(index,2) = y;              % �����F�N�G���̕��i�ԍ�
        List(index,3) = x;              % �E��FDB�̕��i�ԍ�
        index = index + 1;
    end
end
ListSorted = sortrows(List,1);          % ���X�g���\�[�g���āA���i�Ԃ̋������������g�ݍ��킹��T��

%%% �\�[�g�������X�g���珇�ɒT��
Minimums = zeros(NY,1);     % �N�G���̂��ꂼ��̕��i�ɂ��Ă̍ŏ�����
ComponentSet = zeros(NY,1);
UsedX = zeros(NX,1);
for iL = 1:NL   % ���i�Ԃ̋������������g�ݍ��킹���珇�Ɍ���
    iy = ListSorted(iL,2);      % ���̑g�ݍ��킹�̃N�G���̕��i�ԍ�iy
    if ComponentSet(iy) == 0    % iy�̑������܂����܂��Ă��Ȃ��ꍇ
        ix = ListSorted(iL,3);      % ���̑g�ݍ��킹��DB�̕��i�ԍ�ix
        if UsedX(ix) == 0           % ix���܂������ɑI�΂�Ă��Ȃ��ꍇ
            ComponentSet(iy) = ix;              % DB�̕��i�ԍ����L�^�iiy�ƍł��������߂����i�j
            Minimums(iy) = ListSorted(iL,1);    % ���̑g�ݍ��킹�̃��[�N���b�h�������L�^
            UsedX(ix) = 1;                      % DB�̕��i�ԍ����d�����Ďg��Ȃ��悤�ɋL�^
        end
    end
end

end


