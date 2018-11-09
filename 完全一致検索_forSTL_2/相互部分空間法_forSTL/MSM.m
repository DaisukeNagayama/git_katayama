function Similarity = MSM(U, V)
% ���ݕ�����Ԗ@�ɂ��ގ��x�v�Z
% ����
%   U - ������Ԃ��i�[�����z��B
%   V - ������Ԃ��i�[�����z��B
% �o��
%   Similarity - �v�Z���ꂽ�ގ��x�B

    UR = size(U, 2);
    VR = size(V, 2);
    
    if UR > VR
        S = (U') * V * (V') * U;
    else
        S = (V') * U * (U') * V;
    end
    
    [~, EigenValue] = eig(S);
    Similarity = max(diag(EigenValue));
    Similarity = sqrt(1 - Similarity^2);

end