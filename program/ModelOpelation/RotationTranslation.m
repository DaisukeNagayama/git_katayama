%% ���f���̉�]���s�ړ��ʂ̗�������
% �e���f���ɂ��� number ����������
% �������ʂ����̂܂܃v���O�����ɃR�s�y�ł���悤�ɐ����ăR�}���h�E�B���h�E�ɕ\��
% 
% ���� : Models / �R�����{�N�Z�����f���̃Z���z��
%        Number / ���������𐶐���������
%
% �o�� : �R������Ԃ��烂�f�����͂ݏo���Ȃ���]���s�ړ���
%
% 
%%
function [RotAzis, RotEles, Translation] = RotationTranslation(Models,Number)

%%% �Z���z�񂶂�Ȃ�������ꍇ
if not(iscell(Models))
    Models = {Models};
end

%%% �萔�錾�A�s��̗p��
NM = length(Models);     % ���f����

RotEles = zeros(Number*NM,1);
RotAzis = zeros(Number*NM,1);
Translation = zeros(Number*NM,3);

%%% �e���f���ɂ��ă��[�v
for im = 1:NM
    Model = Models{im};
    [NX,NY,NZ] = size(Model);

    %%%
    for i = 1:Number
        key = 1;
        NumberOfRetry = -1;
        while key == 1
            azimuth = round(360*rand);% �p���ω��ʂ������_���Őݒ�
            elevation = round(180*rand);% �p���ω��ʂ������_���Őݒ�
            mr3d = rot3d(Model, elevation, azimuth, 'nearest');% �p���ω�
            %%% �R������Ԃ̊O�ʂɃ��f�����ڒn���Ă��邩���`�F�b�N
            if sum(sum(squeeze( mr3d(1,:,:) + mr3d(NX,:,:) ))) ==0% X�����̋��E��
                if sum(sum(squeeze( mr3d(:,1,:) + mr3d(:,NY,:) ))) ==0% X�����̋��E��
                    if sum(sum(squeeze( mr3d(:,:,1) + mr3d(:,:,NZ) ))) ==0% Z�����̋��E��
                        key = 0;
                    end
                end
            end
            NumberOfRetry = NumberOfRetry + 1;
        end
        disp(strcat('�p���ω��C���񐔁F', num2str(NumberOfRetry)))

        %%% ���s�ړ��\�Ȕ͈͂𒲂ׂ�
        [NXm, NXp, NYm, NYp, NZm, NZp] = DistancebetweenModelandSpace(mr3d);
        %%% �����_���ɕ��s�ړ�
        dx = floor(-NXm + rand*(NXm + NXp + 1));% 0���܂߂邽�߁A+1
        dy = floor(-NYm + rand*(NYm + NYp + 1));% 0���܂߂邽�߁A+1
        dz = floor(-NZm + rand*(NZm + NZp + 1));% 0���܂߂邽�߁A+1
        %mrs = circshift(mr3d, [dx dy dz]);% ���s�ړ�

        RotEles(i+(im-1)*Number) = elevation;
        RotAzis(i+(im-1)*Number) = azimuth;
        Translation(i+(im-1)*Number,:) = [dx dy dz];
    end
end

%%% ������Ƃ��ăR�}���h�E�B���h�E�ɕ\��
disp(strcat('RotAzi: ', mat2str(RotAzis), ';'))
disp(strcat('RotEle: ', mat2str(RotEles), ';'))
disp(strcat('Translation: ', mat2str(Translation), ';'))

end

function [NXm, NXp, NYm, NYp, NZm, NZp] = DistancebetweenModelandSpace(m)
%% �R������Ԃ��݂͂����Ȃ��悤�ɕ��s�ړ��\�Ȕ͈͂��`�F�b�N
%    ���́Fm / �R�������f�����i�[���ꂽ�R�����z��
%    �o�́FNXm / �}�C�i�X�����Ɉړ��\�ȗ�, NXp / �v���X�����Ɉړ��\�ȗ�, ...�i�ق������l�j
[NX,NY,NZ] = size(m);

% X
ProjX = sum(sum(m,3),2);
NXm = find(ProjX, 1) - 1;
NXp = NX - find(ProjX, 1, 'last');

% Y
ProjY = sum(sum(m,3),1)';
NYm = find(ProjY, 1) - 1;
NYp = NY - find(ProjY, 1, 'last');

% Z
ProjZ = squeeze( sum(sum(m,1),2) );
NZm = find(ProjZ, 1) - 1;
NZp = NZ - find(ProjZ, 1, 'last');


end

