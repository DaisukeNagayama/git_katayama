%% 部品強調投影（Geodesic Dome）
% 部品ごとにラベル値を付与し直し、それぞれの部品を強調した投影を作成する
% 
% 出力: ProjectionEmphasizedComponent{Label}(X,Y,頂点番号) / そのラベル値の部品が強調された投影集合
%
% ProjEachComponent{Label}(X,Y,頂点番号)
%
% 使用する関数
%   VerticesProjectionEachLabel(Model, NumberOfVertices) 
%     Geodesic Dome を視点に用いた2次元投影
%%
function [ProjectionEmphasizedComponent] = ProjectionEmphasizedModel(Model, NumberOfVertices, EmphasisValue)
%% ラベル値ごとに投影
ProjectionEachComponent = VerticesProjectionEachLabel(Model, NumberOfVertices);

%% 全部品の投影を足し合わせて全体の投影を得る
NL = length(ProjectionEachComponent);
ProjectionAllComponent = zeros(size(ProjectionEachComponent{1}));
for iA = 1:NL
    ProjectionAllComponent = ProjectionAllComponent + ProjectionEachComponent{iA}; % 全部品の投影画像を合成
end

%% 部品ごとに、ラベルを振り直しつつ強調投影を作成
ProjectionEmphasizedComponent = cell(NL,1);% 強調モデルの投影画像
for iE = 1:NL
    EmphasizedProjection = ProjectionEachComponent{iE};% 強調する部品の投影画像
    OthersProjection = ProjectionAllComponent - EmphasizedProjection;
    
    %%% 体積でラベルをふってみた３
    % 論文に書く時にわかりやすいラベル設定（2015/12/13時点では、検証段階）
    % %{ 
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
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP;
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
        ReEP(:,:,iP) = EmphasizedProjection(:,:,iP) / VolumeEP(iP); % 投影を体積値で割る（逆数を掛ける）
        ReOP(:,:,iP) = OthersProjection(:,:,iP) / VolumeOP(iP);     % sum(sum(ReEP(:,:,1)))==1, sum(sum(ReOP(:,:,1)))==1;
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