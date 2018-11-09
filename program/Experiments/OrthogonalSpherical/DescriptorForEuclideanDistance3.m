%% �����ʌv�Z�iSHT�j
% DescriptorForEuclideanDistance.m �̉���
% ���i���Ƃ� ComputeDescriptor() ���Ăяo���ē����ʂ��v�Z����
% 
% Interval �̍폜
% 
% ComputeDescriptor()
%   ���e�摜�����h���ϊ�
%   �t�[���G�ϊ��ŐU���X�y�N�g��
%   �����g�t�B���^�[��������
% 
% ���� : Projection{Label}(X,Y,theta,phi) / ���x�����Ƃ̓��e�摜�W��
%       NumberOfHalving / �����ʂ����񕪊����邩�B����g�����J�b�g
%       orderMax / �����ʌv�Z�ł̋��ʒ��a�ϊ��̎������
%
% �o�� : DescriptorsCell{Label}(SHT�̎���l, ���h���ϊ��摜�̃T�C�Y Z*theta)
% 
%% TODO
% ���h���ϊ��̉ӏ��łQ��t�[���G�ϊ����Ă���Ӗ� 
%
%%
function [DescriptorsCell] = DescriptorForEuclideanDistance3(Projection, orderMax, NumberOfHalving)

if iscell(Projection) 
    %%% ���i���ƂɃ��x����������Ă���Ƃ�
    NC = length(Projection);% ���e���ꂽ���f���̕��i��
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        Proj = Projection{ic}; % ���x�����Ƃ�
        DescriptorsCell{ic} = ComputeDescriptor(Proj, orderMax, NumberOfHalving); % �����ʌv�Z�ɂԂ�Ȃ�
    end
else
    %%% ���i���ƂɃ��x����������Ă��Ȃ��Ƃ�
    DescriptorsCell = ComputeDescriptor(Projection, orderMax, NumberOfHalving); % �����ʌv�Z�ɂԂ�Ȃ�
end
end

%% �����ʌv�Z��
function [Des2] = ComputeDescriptor(Proj, orderMax, NumberOfHalving)

[NX,NY,NT,NP] = size(Proj);
theta = 0:Interval:179;% ���h���ϊ��̓��e�p�x
LT = length(theta);% �p�x��
LR = length( radon(zeros(NX,NY),1) );% ���a��

% ���������邩���Ȃ����ŕ�����
if NumberOfHalving == 0
    Des1 = zeros(NT, NP, LR*LT);
else
    DiameterLR = floor( ( LR/(2^(NumberOfHalving)) )/ 2 );
    DiameterLT = floor( ( LT/(2^(NumberOfHalving)) )/ 2 );
    Des1 = zeros( NT, NP, (DiameterLR*2+1)*(DiameterLT*2+1) );
end

for it = 1:NT
    for ip = 1:NP
        % ���h���ϊ����t�[���G�ϊ�
        prj = Proj(:,:,it,tp);
        PR = radon(prj,theta);          % PR(Z,theta)
        PRF = abs(fft(PR,[],1));        % 
        PRFF = abs(fft(PRF,[],2));
        % ���������邩���Ȃ����ŕ�����
        if NumberOfHalving == 0
            Des1(it,ip,:) = PRFF(:);     % Des(��,��,Z) : PRFF ����s�ɂ���Des(��,��,:)�ɑ��
        else
            % �����g�����
            PRFFC = FrequencyCut(PRFF, DiameterLR, DiameterLT);
            Des1(it,ip,:) = PRFFC(:);    % Des(��,��,Z) : PRFF ����s�ɂ���Des(��,��,:)�ɑ��
        end
    end
end

%%% ���ʒ��a�ϊ�  PFHC(theta,phi,Z)
NZ2 = size(Des1,3);
fn = zeros(orderMax + 1, 2 * orderMax + 1, NZ2);    % fn(l,m,Z)
for iz = 1:NZ2
    fn(:,:,iz) = SHT(Des1(:,:,iz), orderMax);    % ���ʒ��a�ϊ�
end

spectrum = zeros(orderMax+1, size(fn,3));
for iz = 1:size(fn,3)
    for il = 1 : orderMax+1
        COEF = zeros(size(fn(:,:,1)));
        COEF(il,:) = fn(il,:,iz);
        gg1 = SHBT(COEF); % �e�������Ƃɍč\�������Ƃ��̋��ʔg
        spectrum(il,iz) = SHnorm(gg1);
    end
end
Des2 = spectrum;

end
%% �����g�t�B���^�[
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
