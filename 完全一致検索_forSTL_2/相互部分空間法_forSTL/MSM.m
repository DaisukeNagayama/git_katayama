function Similarity = MSM(U, V)
% 相互部分空間法による類似度計算
% 入力
%   U - 部分空間を格納した配列。
%   V - 部分空間を格納した配列。
% 出力
%   Similarity - 計算された類似度。

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