%% 部品強調投影（Geodesic Dome）
% 部品ごとに投影を撮り、体積に基づいてラベル値を付与し直して、それぞれの部品を強調した投影を作成する
% Geodesic Dome ではなく球面直交座標で投影作成するようにProjectionEmphasizedModel()を改造したもの
% 
% Output: ProjectionEmphasizedComponent{Label}(X,Y,theta,phi) / そのラベル値の部品が強調された投影集合
% 
% ProjectionEachComponent = {
%   Projection(X,Y,theta,phi),
%   Projection(X,Y,theta,phi),
%   Projection(X,Y,theta,phi), ... }
% 
% 
%%
function [ProjectionEmphasizedComponent] = ProjectionEmphasizedModel3(Model, theta, phi, EmphasisValue)
%% ラベル値ごとに投影
ProjectionEachComponent = VerticesProjectionEachLabel2(Model, theta, phi);

%% 全部品の投影を足し合わせて全体の投影を得る
NL = length(ProjectionEachComponent);       % 部品の数
ProjectionAllComponent = zeros(size(ProjectionEachComponent{1}));
for iA = 1:NL
    ProjectionAllComponent = ProjectionAllComponent + ProjectionEachComponent{iA}; % 全部品の投影画像を合成
end

%% 部品ごとに、ラベルを振り直しつつ強調投影を作成
ProjectionEmphasizedComponent = cell(NL,1);% 強調モデルの投影画像
for iE = 1:NL
    EmphasizedProjection = ProjectionEachComponent{iE};% 強調する部品の投影画像
    OthersProjection = ProjectionAllComponent - EmphasizedProjection;
    
    %%% 体積でラベルをふってみた５
    % %{
    disp('体積でラベルをふってみた５');
    VolumeEP = (sum(sum(EmphasizedProjection)));    % ラベル値 iE の投影画像の総和
    VolumeOP = (sum(sum(OthersProjection)));
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iT = 1:length(theta)
        for iP = 1:length(phi)
            ReEP(:,:,iT,iP) = EmphasizedProjection(:,:,iT,iP) / VolumeEP(iT,iP); % 体積値で割る（逆数を掛ける）
            ReOP(:,:,iT,iP) = OthersProjection(:,:,iT,iP) / VolumeOP(iT,iP);
        end
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% 体積でラベルをふってみた４
    % projection3dEachLabel.m に合わせて書き直したもの
    %{
    disp('体積でラベルをふってみた４');
    VolumeEP = sum(EmphasizedProjection,1);     % ラベル値 iE の投影画像の Z方向総和 (1,theta,phi)
    VolumeOP = sum(OthersProjection,1);         % 
    
    NX = size(EmphasizedProjection,1);          % Z 方向の要素数
    VolumeEP = repmat(VolumeEP, [NX,1,1]);      % 対応要素ごと演算するために配列サイズ調整(Z,theta,phi)
    VolumeOP = repmat(VolumeOP, [NX,1,1]);      % 
    
    ReEP = EmphasizedProjection ./ VolumeEP;    % 体積値で割る（逆数を掛ける）
    ReOP = OthersProjection ./ VolumeOP;        %
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;  
    %}
    
    %%% 体積でラベルをふってみた３
    % 論文に書く時にわかりやすいラベル設定（2015/12/13時点では、検証段階）
    %{ 
    disp('体積でラベルをふってみた３');
    Labels = unique(Model(Model>0));
    ModelBin = Model>0;
    VolumeALL = sum(ModelBin(:));
    
    ModelEP = Model == Labels(iE);
    VolumeEP = sum(ModelEP(:));
    VolumeOP = VolumeALL - VolumeEP;
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iP = 1:NumberOfVertices
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP; % 元々のラベル値で撮った投影を体積値で割る（逆数を掛ける）
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP;
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% 体積でラベルをふってみた２
    % 2015/12/13時点で論文にしようとしている設定。
    %{
    disp('体積でラベルをふってみた２');
    VolumeEP = (sum(sum(EmphasizedProjection)));    % ラベル値 iE の投影画像の総和
    VolumeOP = (sum(sum(OthersProjection)));
    
    ReEP = zeros(size(EmphasizedProjection));
    ReOP = zeros(size(OthersProjection));
    for iP = 1:NumberOfVertices
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP(iP); % 体積値で割る（逆数を掛ける）
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP(iP);
    end
    
    ProjectionEmphasizedComponent{iE} = EmphasisValue * ReEP + ReOP;
    %}
    
    %%% 体積でラベルをふってみた１
    % これはいらないかも
    %{
    disp('体積でラベルをふってみた１');
    VolumeEP = mean(sum(sum(EmphasizedProjection)));
    VolumeOP = mean(sum(sum(OthersProjection)));
    
    ProjectionEmphasizedComponent{iE} = ...
         EmphasizedProjection / VolumeEP ...
         + OthersProjection / VolumeOP;
    %}
    
    %%% 固定した値によるラベル付け
    %{
    ProjectionEmphasizedComponent{iE} = ...
        (EmphasizedProjection * EmphasisValue) ... % 部品の投影を強調値で強調する。 
        + (ProjectionAllComponent - EmphasizedProjection); % 全部品の投影から強調する部品の投影を取り除く。
    %}
        
end

end