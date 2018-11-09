function [EmphasizedModel] = EmphasizeModel(Model, EmphasisValue)

Labels = unique(Model(Model>0));
NL = length(Labels);

%% �������f���쐬
EmphasizedModel = cell(NL,1);
for iL = 1:NL
    L = Labels(iL);% ���x�����P�I��
    EmphasizedComponent = (Model == L);% ���x���Ɠ����l�������i�𔲂��o���B
    OthersComponent = (Model>0) - EmphasizedComponent;% �����o�������i�ȊO�̕��i�W��
    EmphasizedModel{iL} = (EmphasizedComponent * EmphasisValue) + OthersComponent;% ���x�������čč\��
end

end