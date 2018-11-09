function [Subspace, EigenValue] = EVD(X, R)
% ���ْl�������s���֐��B
% ����
%   X - �����x�N�g�����i�[�����z��B
%   R - �������镔����Ԃ̎������B
% �o��
%   Subspace   - ������Ԃ𒣂�R�{�̌ŗL�x�N�g�����i�[�����z��B
%   EigenValue - �e�ŗL�x�N�g���ɑΉ�����ŗL�l���i�[�����x�N�g���B

    C = X' * X;
    [EigenVector, EigenValue] = eig(C);
    [Value, Index] = sort(diag(EigenValue), 'descend');
    EigenValue = Value;
    Subspace = [];
    for iR = 1 : R
        Vector = (X * EigenVector(:, Index(iR))) ./ sqrt(Value(iR));
        Subspace = [Subspace, Vector];
    end

end