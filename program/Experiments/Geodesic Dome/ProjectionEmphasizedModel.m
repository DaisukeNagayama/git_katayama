%% ���i�������e�iGeodesic Dome�j
% ���i���ƂɃ��x���l��t�^�������A���ꂼ��̕��i�������������e���쐬����
% 
% �o��: ProjectionEmphasizedComponent{Label}(X,Y,���_�ԍ�) / ���̃��x���l�̕��i���������ꂽ���e�W��
%
% ProjEachComponent{Label}(X,Y,���_�ԍ�)
%
% �g�p����֐�
%   VerticesProjectionEachLabel(Model, NumberOfVertices) 
%     Geodesic Dome �����_�ɗp����2�������e
%%
function [ProjectionEmphasizedComponent] = ProjectionEmphasizedModel(Model, NumberOfVertices, EmphasisValue)
%% ���x���l���Ƃɓ��e
ProjectionEachComponent = VerticesProjectionEachLabel(Model, NumberOfVertices);

%% �S���i�̓��e�𑫂����킹�đS�̂̓��e�𓾂�
NL = length(ProjectionEachComponent);
ProjectionAllComponent = zeros(size(ProjectionEachComponent{1}));
for iA = 1:NL
    ProjectionAllComponent = ProjectionAllComponent + ProjectionEachComponent{iA}; % �S���i�̓��e�摜������
end

%% ���i���ƂɁA���x����U�蒼���������e���쐬
ProjectionEmphasizedComponent = cell(NL,1);% �������f���̓��e�摜
for iE = 1:NL
    EmphasizedProjection = ProjectionEachComponent{iE};% �������镔�i�̓��e�摜
    OthersProjection = ProjectionAllComponent - EmphasizedProjection;
    
    %%% �̐ςŃ��x�����ӂ��Ă݂��R
    % �_���ɏ������ɂ킩��₷�����x���ݒ�i2015/12/13���_�ł́A���ؒi�K�j
    % %{ 
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
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP;
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
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP(iP); % ���e��̐ϒl�Ŋ���i�t�����|����j
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP(iP);     % sum(sum(ReEP(:,:,1)))==1, sum(sum(ReOP(:,:,1)))==1;
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