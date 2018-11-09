function ProjEachComponent = VerticesProjectionEachLabel2( Model, theta, phi )
%% ���x���l���Ƃ�3�������h���ϊ���1�������e���쐬����i���ʒ������W�j
% VerticesProjectionEachLagel.m ��
% Geodesic Dome �ł͂Ȃ����ʒ������W�n�œ��e�쐬����悤�ɉ�����������
% 
% input : Model 3�����{�N�Z�����f��
%         theta ���e���B�e����ܓx (0 <= �� <= ��)    �P�����z�� 
%         phi ���e���B�e����o�x (0 <= �� <= 2��)     �P�����z��
%   
%   output: ProjEachComponent{Label}(Z,theta,phi)
%   
%   
%% ���e�p�x�ɂ��Ă̏���
NT = length(theta);
NP = length(phi);
harfNP = floor(NP/2);

%% �傫�ȋ�Ԃփ��f�����i�[
Interpolation = 'nearest';% ��ԕ��@��I��     { linear, nearest, [] }
disp(strcat(Interpolation,'�ŕ�Ԓ�...'));

[NX,NY,NZ] = size(Model);
% ���f���������ԑS�̂𓊉e�摜��Ɏ��߂邽�߂ɕK�v�ȐV������Ԃ̑傫��
NX2 = ceil(sqrt(3)*max([NX NY NZ]));
NewSpace = zeros(NX2, NX2, NX2);
% �V������Ԃ̒��S�Ƀ��f�����i�[
CX = floor((NX+1)/2); CY = floor((NY+1)/2); CZ = floor((NZ+1)/2);% ���f�����i�[����Ă����Ԃ̒��S
CX2 = floor((NX2+1)/2); CY2 = floor((NX2+1)/2); CZ2 = floor((NX2+1)/2);% �V������Ԃ̒��S
xmin = CX2-(CX-1); xmax = CX2+(NX-CX);
ymin = CY2-(CY-1); ymax = CY2+(NY-CY);
zmin = CZ2-(CZ-1); zmax = CZ2+(NZ-CZ);
NewSpace(xmin:xmax,ymin:ymax,zmin:zmax) = Model;% �V������ԂɃ��f�����i�[

%% �p���ω��𗘗p�������e
Labels = unique(Model(Model>0));
NL = length(Labels);
disp(strcat(num2str(NL),'�̊e���i�̓��e�摜��',Interpolation,'�ɂ���ԂŌv�Z��...'));

Proj = zeros(NX2, NT, NP);
ProjEachComponent = cell(NL,1);
for ipec = 1:NL
    ProjEachComponent{ipec} = Proj;
end

% NP �������������炿���ƑS���v�Z����
if mod(NP,2) == 0
    harfNP = NP;
end

% �{��
for it = 1:NT
    for ip = 1:harfNP
        elevation_ia = theta(it);% �ܓx
        azimuth_ia = phi(ip);% �o�x
        ModelRotated = rot3d(NewSpace, -1*elevation_ia, -1*azimuth_ia, Interpolation, true);% �p���ω�

        for il = 1:NL
            label = Labels(il);
            Component = (ModelRotated == label);            
            ProjEachComponent{il}(:,it,ip) = squeeze(sum(sum(Component)));% Z���ɓ��e�i���ϕ��j
            if mod(elevation_ia + pi/4, pi/2) == 0    % 45�x�p���ǂ���
                ProjEachComponent{il}(:,it,ip) = ProjEachComponent{il}(:,it,ip) / 1.0962;
            end
        end
    end
end

% NP �����������㔼�̓R�s�y
if mod(NP,2) == 1
    for il = 1:NL
        ProjEachComponent{il}(:,1:NT,(harfNP+1):NP-1) = flip(ProjEachComponent{il}(:,NT:-1:1,1:harfNP), 1);
        ProjEachComponent{il}(:,1:NT,NP) = flip(ProjEachComponent{il}(:,NT:-1:1,1), 1);
    end
end


end % fanction

