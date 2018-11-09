function Proj = projection3d( Model, theta, phi )
% PROJECTION3D 3�������h���ϊ���1�������e���쐬����
%   Proj = PROJECTION3D( Model, theta, phi )
%   
%   input : Model 3�����{�N�Z�����f��            �R�����z��
%           theta ���e���B�e����ܓx (0 ���� ��) �P�����z��
%           phi ���e���B�e����o�x (0 ���� 2��)�@�P�����z��
%   
%   output: Proj(Z,theta,phi)
%   

%% ���e�p�x�ɂ��Ă̏���
NT = length(theta);
NP = length(phi);

%% �傫�ȋ�Ԃփ��f�����i�[
Interpolation = 'linear';   % ��ԕ��@��I��     { linear, nearest, [] }
% disp(strcat(Interpolation,'�ŕ�Ԓ�...'));

[NX,NY,NZ] = size(Model);
% ���f���������ԑS�̂𓊉e�摜��Ɏ��߂邽�߂ɕK�v�ȐV������Ԃ̑傫��
NL = ceil(sqrt(3)*max([NX NY NZ]));
NewSpace = zeros(NL, NL, NL);
% �V������Ԃ̒��S�Ƀ��f�����i�[
CX = floor((NX+1)/2); CY = floor((NY+1)/2); CZ = floor((NZ+1)/2);% ���f�����i�[����Ă����Ԃ̒��S
CX2 = floor((NL+1)/2); CY2 = floor((NL+1)/2); CZ2 = floor((NL+1)/2);% �V������Ԃ̒��S
xmin = CX2-(CX-1); xmax = CX2+(NX-CX);
ymin = CY2-(CY-1); ymax = CY2+(NY-CY);
zmin = CZ2-(CZ-1); zmax = CZ2+(NZ-CZ);
NewSpace(xmin:xmax,ymin:ymax,zmin:zmax) = Model;% �V������ԂɃ��f�����i�[

%% �p���ω��𗘗p�������e
Proj = zeros(NL, NT, NP);

% NP ����������甼�������v�Z����
if mod(NP,2) == 0
    NP2 = NP;
else
    NP2 = floor(NP/2);
end

% �{��
for it = 1:NT
    for ip = 1:NP2
        elevation_ia = theta(it);% �ܓx
        azimuth_ia = phi(ip);% �o�x
        ModelRotated = rot3d(NewSpace, -1*elevation_ia, -1*azimuth_ia, Interpolation, true);% �p���ω�
        Proj(:,it,ip) = squeeze(sum(sum(ModelRotated)));% Z���ɓ��e�i���ϕ��j
        if mod(elevation_ia + pi/4, pi/2) == 0    % 45�x�p���ǂ���
            Proj(:,it,ip) = Proj(:,it,ip) / 1.0962;
        end
    end
end

% NP ����������Ƃ��A�㔼�ɑO�����R�s�y����
if mod(NP,2) == 1
    for il = 1:NL
        Proj(:,1:NT,(NP2+1):NP-1) = flip(Proj(:,NT:-1:1,1:NP2), 1);
        Proj(:,1:NT,NP) = flip(Proj(:,NT:-1:1,1), 1);
    end
end


end % fanction

