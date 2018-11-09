%% �����ʌv�Z�i���h���ϊ����t�[���G�ϊ��j
% ���i���Ƃ� ComputeDescriptor() ���Ăяo���ē����ʂ��v�Z����
% 
% ComputeDescriptor()
%   ���e�摜�����h���ϊ�
%   �t�[���G�ϊ��ŐU���X�y�N�g��
%   �����g�t�B���^�[��������
% 
% ���� : Projection{Label}(X,Y,���e�_) / ���x�����Ƃ̓��e�摜�W��
%       NumberOfHalving / �����ʂ����񕪊����邩�B����g�����J�b�g
%       Interval / �����ʌv�Z�ł̃��h���ϊ��̊p�x���ݕ��i�x���j
% 
% �o�� : DescriptorsCell{Label}(���e�_�� NumberOfVertices, ���h���ϊ��摜�̃T�C�Y Z*theta)
% 
%% ���x�����Ƃɓ��e�摜�W��������ʌv�Z�֐��ɓ�����
function [DescriptorsCell] = DescriptorForEuclideanDistance(Projection, NumberOfHalving, Interval)

if iscell(Projection) 
    %%% ���i���ƂɃ��x����������Ă���Ƃ�
    NC = length(Projection); % ���e���ꂽ���f���̕��i��
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        Proj = Projection{ic}; % ���x�����Ƃ�
        DescriptorsCell{ic} = ComputeDescriptor(Proj, NumberOfHalving, Interval); % �����ʌv�Z�ɂԂ�Ȃ�
    end
else
    %%% ���i���ƂɃ��x����������Ă��Ȃ��Ƃ�
    DescriptorsCell = ComputeDescriptor(Projection, NumberOfHalving, Interval); % �����ʌv�Z�ɂԂ�Ȃ�
end
end
%% ���e�摜�W����������ʌv�Z
function [Des] = ComputeDescriptor(Proj, NumberOfHalving, Interval)

[NX,NY,NZ] = size(Proj);
theta = 0:Interval:179;% ���h���ϊ��̓��e�p�x
NT = length(theta);% �p�x��
NR = length( radon(zeros(NX,NY),1) );% ���a��

% ���������邩���Ȃ����ŕ�����
if NumberOfHalving == 0
    Des = zeros(NZ, NR*NT);
else
    DiameterNR = floor( ( NR/(2^(NumberOfHalving)) )/ 2 );
    DiameterNT = floor( ( NT/(2^(NumberOfHalving)) )/ 2 );
    Des = zeros( NZ, (DiameterNR*2+1)*(DiameterNT*2+1) );
end

for i = 1:NZ
    % ���h���ϊ����t�[���G�ϊ�
    prj = Proj(:,:,i);
    PR = radon(prj,theta);
    PRF = abs(fft(PR,[],1));
    PRFF = abs(fft(PRF,[],2));
    % ���������邩���Ȃ����ŕ�����
    if NumberOfHalving == 0
        Des(i,:) = PRFF(:);     % PRFF �� Des �̈�s�ɂ���
    else
        % �����g�����
        PRFFC = FrequencyCut(PRFF, DiameterNR, DiameterNT);
        Des(i,:) = PRFFC(:);     % PRFF �� Des �̈�s�ɂ���
    end
end

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