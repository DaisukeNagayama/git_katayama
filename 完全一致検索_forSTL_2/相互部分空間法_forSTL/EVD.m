function [Subspace, EigenValue] = EVD(X, R)
% 特異値分解を行う関数。
% 入力
%   X - 特徴ベクトルを格納した配列。
%   R - 生成する部分空間の次元数。
% 出力
%   Subspace   - 部分空間を張るR本の固有ベクトルを格納した配列。
%   EigenValue - 各固有ベクトルに対応する固有値を格納したベクトル。

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