%% ���i�������e�iGeodesic Dome�j
% ���i���Ƃɓ��e���B��A�̐ςɊ�Â��ă��x���l��t�^�������āA���ꂼ��̕��i�������������e���쐬����
% Geodesic Dome �ł͂Ȃ����ʒ������W�œ��e�쐬����悤��ProjectionEmphasizedModel()��������������
% 
% Output: ProjectionEmphasizedComponent{Label}(X,Y,theta,phi) / ���̃��x���l�̕��i���������ꂽ���e�W��
% 
% ProjectionEachComponent = {
%   Projection(X,Y,theta,phi),
%   Projection(X,Y,theta,phi),
%   Projection(X,Y,theta,phi), ... }
% 
% 
%%
function [ProjectionEmphasizedComponent] = ProjectionEmphasizedModel3(Model, theta, phi, EmphasisValue)
%% ���x���l���Ƃɓ��e
ProjectionEachComponent = VerticesProjectionEachLabel2(Model, theta, phi);

%% �S���i�̓��e�𑫂����킹�đS�̂̓��e�𓾂�
NL = length(ProjectionEachComponent);       % ���i�̐�
ProjectionAllComponent = zeros(size(ProjectionEachComponent{1}));
for iA = 1:NL
    ProjectionAllComponent = ProjectionAllComponent + ProjectionEachComponent{iA}; % �S���i�̓��e�摜������
end

%% ���i���ƂɁA���x����U�蒼���������e���쐬
ProjectionEmphasizedComponent = cell(NL,1);% �������f���̓��e�摜
for iE = 1:NL
    EmphasizedProjection = ProjectionEachComponent{iE};% �������镔�i�̓��e�摜
    OthersProjection = ProjectionAllComponent - EmphasizedProjection;
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��T
    % %{
    disp('�̐ςŃ��x�����ӂ��Ă݂��T');
    VolumeEP = (sum(sum(EmphasizedProjection)));    % ���x���l iE �̓��e�摜�̑��a
    VolumeOP = (sum(sum(OthersProjection)));
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iT = 1:length(theta)
        for iP = 1:length(phi)
            ReEP(:,:,iT,iP) = EmphasizedProjection(:,:,iT,iP) / VolumeEP(iT,iP); % �̐ϒl�Ŋ���i�t�����|����j
            ReOP(:,:,iT,iP) = OthersProjection(:,:,iT,iP) / VolumeOP(iT,iP);
        end
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��S
    % projection3dEachLabel.m �ɍ��킹�ď�������������
    %{
    disp('�̐ςŃ��x�����ӂ��Ă݂��S');
    VolumeEP = sum(EmphasizedProjection,1);     % ���x���l iE �̓��e�摜�� Z�������a (1,theta,phi)
    VolumeOP = sum(OthersProjection,1);         % 
    
    NX = size(EmphasizedProjection,1);          % Z �����̗v�f��
    VolumeEP = repmat(VolumeEP, [NX,1,1]);      % �Ή��v�f���Ɖ��Z���邽�߂ɔz��T�C�Y����(Z,theta,phi)
    VolumeOP = repmat(VolumeOP, [NX,1,1]);      % 
    
    ReEP = EmphasizedProjection ./ VolumeEP;    % �̐ϒl�Ŋ���i�t�����|����j
    ReOP = OthersProjection ./ VolumeOP;        %
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;  
    %}
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��R
    % �_���ɏ������ɂ킩��₷�����x���ݒ�i2015/12/13���_�ł́A���ؒi�K�j
    %{ 
    disp('�̐ςŃ��x�����ӂ��Ă݂��R');
    Labels = unique(Model(Model>0));
    ModelBin = Model>0;
    VolumeALL = sum(ModelBin(:));
    
    ModelEP = Model == Labels(iE);
    VolumeEP = sum(ModelEP(:));
    VolumeOP = VolumeALL - VolumeEP;
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iP = 1:NumberOfVertices
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP; % ���X�̃��x���l�ŎB�������e��̐ϒl�Ŋ���i�t�����|����j
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP;
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��Q
    % 2015/12/13���_�Ř_���ɂ��悤�Ƃ��Ă���ݒ�B
    %{
    disp('�̐ςŃ��x�����ӂ��Ă݂��Q');
    VolumeEP = (sum(sum(EmphasizedProjection)));    % ���x���l iE �̓��e�摜�̑��a
    VolumeOP = (sum(sum(OthersProjection)));
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iP = 1:NumberOfVertices
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP(iP); % �̐ϒl�Ŋ���i�t�����|����j
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP(iP);
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��P
    % ����͂���Ȃ�����
    %{
    disp('�̐ςŃ��x�����ӂ��Ă݂��P');
    VolumeEP = mean(sum(sum(EmphasizedProjection)));
    VolumeOP = mean(sum(sum(OthersProjection)));
    
    ProjectionEmphasizedComponent{iE} = ...
         EmphasizedProjection / VolumeEP ...
         + OthersProjection / VolumeOP;
    %}
    
    %%% �Œ肵���l�ɂ�郉�x���t��
    %{
    ProjectionEmphasizedComponent{iE} = ...
        (EmphasizedProjection * EmphasisValue) ... % ���i�̓��e�������l�ŋ�������B 
        + (ProjectionAllComponent - EmphasizedProjection); % �S���i�̓��e���狭�����镔�i�̓��e����菜���B
    %}
        
end

end