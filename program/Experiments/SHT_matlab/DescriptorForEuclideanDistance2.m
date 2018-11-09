%% �����ʌv�Z�iSHT�j
% DescriptorForEuclideanDistance.m �̉���
% ���i���Ƃ� ComputeDescriptor() ���Ăяo���ē����ʂ��v�Z����
% 
% SHT�̏������璷
% ���ʒ��a�֐������O�ɗp�ӂ��Ă����ȂǁA�����̍ő������K�v
% 
% ComputeDescriptor()
%   ���e�摜�W���𓮌a�����Ƀt�[���G�ϊ�
%   ����g�����c��
%   
% 
% ���� : Projection{Label}(Z,theta,phi) / ���x�����Ƃ̓��e�摜�W��
%       NumberOfHalving / �����ʂ����񕪊����邩�B����g�����J�b�g
%       orderMax / �����ʌv�Z�ł̋��ʒ��a�ϊ��̎������
%
% �o�� : DescriptorsCell{Label}(�����g�t�B���^�[��̃T�C�Y NZ2, SHT�ɂ��e�����̌W��)
% 
%%
function [DescriptorsCell] = DescriptorForEuclideanDistance2(Projection, orderMax, NumberOfHalving)

[NZ,NT,NP] = size(Projection{1});

% �g�p���鋅�ʒ��a�֐������O�ɗp�ӂ��Ă���
SHs = makeSH(orderMax,NT,NP);

% 
if iscell(Projection) 
    %%% ���i���ƂɃ��x����������Ă���Ƃ�
    NC = length(Projection);% ���e���ꂽ���f���̕��i��
    DescriptorsCell = cell(NC,1);
    for ic = 1:NC
        disp(strcat('    �R���|�[�l���g', num2str(ic), ' �̓����ʌv�Z'));
        Proj = Projection{ic}; % ���x�����Ƃ�
        DescriptorsCell{ic} = ComputeDescriptor(Proj, SHs, NumberOfHalving); % �����ʌv�Z�ɂԂ�Ȃ�
    end
else
    %%% ���i���ƂɃ��x����������Ă��Ȃ��Ƃ�
    DescriptorsCell = ComputeDescriptor(Projection, SHs, NumberOfHalving); % �����ʌv�Z�ɂԂ�Ȃ�
end
end

%% ���e�摜�W����������ʌv�Z
function [Des] = ComputeDescriptor(Proj, SHs, NumberOfHalving)

[NZ,NT,NP] = size(Proj);
orderMax = size(SHs,1) - 1;

%%% ���e�摜�W���𓮌a�����Ƀt�[���G�ϊ�
prj = fft(Proj,[],1);                           % prj(Z,��,��)
PF = abs(prj/NZ);                               % �p���[(�U��)�X�y�N�g���𒊏o
PFH = permute(PF(1:ceil(NZ/2),:,:),[2,3,1]);    % ���E�Ώ̂Ȃ̂ŕБ��̂ݎ��o�� PFH(��,��,Z)
NZ2 = size(PFH,3)/(2^NumberOfHalving);          % ���o���͈͂��w��
PFHC = PFH(:,:,1:NZ2);                          % �s�[�N�𒆐S�ɃJ�b�g�i�����g�������팸�j

%%% ���ʒ��a�ϊ�
fn = zeros(orderMax + 1, 2 * orderMax + 1, NZ2);    % fn(l,m,Z)
for iz = 1:NZ2
    for il = 0:orderMax
        for im = -il:il
            fn(il+1,orderMax+im+1,iz) = SHnorm(PFHC(:,:,iz) .* SHs{il+1,orderMax+im+1}); % ���ʒ��a�ϊ�
        end
    end
end

%%% �������Ƃ� L2-norm �̑��a�̌v�Z
spectrum = zeros(size(fn,3), orderMax+1);
for iz = 1:size(fn,3)
    for il = 0 : orderMax
        COEF = zeros(size(fn(:,:,1)));
        COEF(il+1,:) = fn(il+1,:,iz);   % iz�w�ڂ� ����il �̒i�����R�s�[
        gg1 = SHBT(COEF);               
        % plotSH(gg1,1)     % �e�������Ƃɍč\�������Ƃ��̋��ʔg
        spectrum(iz,il+1) = SHnorm(gg1);
    end
end
Des = spectrum;

end

%% ���ʒ��a�ϊ�
function coefficient = SHT(yy,orderMax)
% �T���v�����O�_�̐���ǂݍ���
polarNum = size(yy,1);    % ���W�����h���������̎����i�K�E�X�ܓx�����_�Ƃ�̂��j
azimuthNum = size(yy,2);  % �o�x�����ɉ��_�Ƃ邩(�n�_(0)�ƏI�_(2��)�𗼕��J�E���g)

% �ʏ�̈ܓx�o�x
theta_ = 0 : pi/(polarNum - 1) : pi;
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi;
[phi,theta] = meshgrid(phi_,theta_);

% �K�E�X�ܓx�ʂƌo�x�ɂ̌v�Z
syms X;
LegPolynomial = legendreP(polarNum, X);     % polarNum���̃��W�����h��������
mu_ = vpasolve(LegPolynomial == 0);          % ���W�����h���������̍����K�E�X�ܓx�ɂȂ�
mu_ = fliplr(double(mu_)');                     % �V���{���b�N����{���x���֕ϊ�          
lambda_ = 0 : 2*pi / (azimuthNum - 1) : 2*pi;    % �o�x�̍��ݕ�
[lambda,mu] = meshgrid(lambda_,mu_);

% Gauss-Legendre �ϕ��Ɏg���K�E�X�d�݂̌v�Z
d_LegPolynomial = diff(LegPolynomial, X);
weight = double((((1-mu_.^2) .* (subs(d_LegPolynomial, mu_)).^2)/2).^-1);

% ���͋��ʔg����ʈܓx����K�E�X�ܓx�ɕϊ�����
yy = spline(theta(:,1), yy', acos(mu(:,1)))';


% SHT(Spherical Harmonic Transform algorithm)
% �W���i�[�p�̕ϐ��A���ʒ��a�֐��̃s���~�b�h�}�݂����Ȓ��p�񓙕ӎO�p�`��Ɋi�[
coefficient = zeros(orderMax + 1, 2 * orderMax + 1);

for order = 0 : orderMax    % ���ʒ��a�֐���᎟���珇��
    % Plm(��j) ���W�����h�����֐�
    Plms = legendre(order, mu(:,1)); % order���Ƃɂ܂Ƃ߂Đ���
    
    for degree = -order : order % ���[�v�ŉ񂵂ČW���v�Z����        
        
        % degree �ɑΉ����� Plm �����o��
        Plm = Plms(abs(degree) + 1,:);
        
        % ��`�ϕ� �������ɐϕ�
        G = yy .* exp(-1i * degree * lambda);
        G = trapz(lambda_, G, 2)';
        
        % �����Ɛ��K��
        sign = (-1)^((degree+abs(degree))/2);
        normSH = sqrt( (4*pi)/(2*order+1) * factorial(order+abs(degree)) / factorial(order-abs(degree)) );
        
        % �K�E�X�E���W�����h���ϕ� �c�����ɐϕ� 
        coefficient(order+1, degree+orderMax+1) = ...
            sign/normSH * sum(weight .* Plm .* G);     
    end
end
end % function SHT()

%% ���ʒ��a�֐����܂Ƃ߂��Z���z��𐶐�
function SHs = makeSH(orderMax,NT,NP)

SHs = cell(orderMax + 1, 2 * orderMax + 1);

for il = 0:orderMax
    for im = -il:il
        SHs{il+1, orderMax+im+1} = SH(il,im,NT,NP);
    end 
end

end

%%%%%%%%%%%%
% ���K�� ���ʒ��a�֐� Ylm �� �v�Z����
% �������ʒ��a�֐��� �������a�֐� �� Tesseral spherical harmonics �Ƃ��ĂԂ炵��
function Ylm = SH(l,m,polarNum,azimuthNum)

% ���ʃO���b�h�̍쐬
theta_ = 0 : pi/(polarNum - 1) : pi;     % polar angle
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi; % azimuth angle
[phi,theta] = meshgrid(phi_,theta_);      % define the grid

% ���W�����h�����֐��̗p��
Plm = legendre(l, cos(theta(:,1))); % �e�s�� Pl0 ���� Pll �܂ł����񂾍s��
Plm = Plm(abs(m) + 1,:)';           % Plm �̍s�����o���ďc�ɂ���
Plm = repmat(Plm,1,size(phi,2));    % ���ʃO���b�h�̃T�C�Y�ɍ��킹��

% �����Ɛ��K��
sign = (-1)^((m+abs(m))/2);
normSH = sqrt( 4*pi / (2*l+1) * factorial(l+abs(m)) / factorial(l-abs(m)) );

% ���f�� ���ʒ��a�֐�
Ylm = zeros(polarNum, azimuthNum);
Ylm(:,:) = sign / normSH * Plm .* exp(1i * m * phi);

% ���� ���ʒ��a�֐�
% if m > 0
%     Ylm(:,:) = sqrt(2) * sign/normSH * Plm .* cos(abs(m) * phi);
% elseif m < 0 
%     Ylm(:,:) = sqrt(2) * sign/normSH * Plm .* sin(abs(m) * phi);
% else
%     Ylm(:,:) = sign/normSH * Plm;
% end

end

%% ���ʃX�J���[���L2�m���������߂�
%       input : SH  ���ʃX�J���[��
function norm = SHnorm(yy) 
% �T���v�����O�_�̐���ǂݍ���
polarNum = size(yy,1);    % ���W�����h���������̎����i�K�E�X�ܓx�����_�Ƃ�̂��j
azimuthNum = size(yy,2);  % �o�x�����ɉ��_�Ƃ邩(�n�_(0)�ƏI�_(2��)�𗼕��J�E���g)

% �ܓx�o�x
theta_ = 0 : pi/(polarNum - 1) : pi;
phi_ = 0 : 2*pi/(azimuthNum - 1) : 2*pi;
[phi,theta] = meshgrid(phi_,theta_);

% �K�E�X�ܓx�ʂƌo�x�ɂ̌v�Z
syms X;
LegPolynomial = legendreP(polarNum, X);     % polarNum���̃��W�����h��������
mu_ = vpasolve(LegPolynomial == 0);          % ���W�����h���������̍����K�E�X�ܓx�ɂȂ�
mu_ = fliplr(double(mu_)');                     % �V���{���b�N����{���x���֕ϊ�          
lambda_ = 0 : 2*pi / (azimuthNum - 1) : 2*pi;    % �o�x�̍��ݕ�
[lambda,mu] = meshgrid(lambda_,mu_);

% Gauss-Legendre �ϕ��Ɏg���K�E�X�d�݂̌v�Z
d_LegPolynomial = diff(LegPolynomial, X);
weight = double((((1-mu_.^2) .* (subs(d_LegPolynomial, mu_)).^2)/2).^-1);

% ���͋��ʔg����ʈܓx����K�E�X�ܓx�ɕϊ�����
yy = spline(theta(:,1), yy', acos(mu(:,1)))';

% �m�����v�Z
% 2�悵�Ă��狅�ʂŐϕ�
G = abs(yy).^2;

% ��`���ρi�ӕ����ɐϕ��j
G = trapz(G,2)' /2/pi;

% �K�E�X�E���W�����h���ϕ��i�ƕ����ɐϕ��j
norm = sum(weight .* G);

end

