function [EmphasizedModel] = EmphasizeModel(Model, EmphasisValue)

Labels = unique(Model(Model>0));
NL = length(Labels);

%% 強調モデル作成
EmphasizedModel = cell(NL,1);
for iL = 1:NL
    L = Labels(iL);% ラベルを１つ選択
    EmphasizedComponent = (Model == L);% ラベルと同じ値を持つ部品を抜き出す。
    OthersComponent = (Model>0) - EmphasizedComponent;% 抜き出した部品以外の部品集合
    EmphasizedModel{iL} = (EmphasizedComponent * EmphasisValue) + OthersComponent;% ラベルをつけて再構成
end

end