function Similarity = MSM(U, V)
% ‘ŠŒÝ•”•ª‹óŠÔ–@‚É‚æ‚é—ÞŽ—“xŒvŽZ
% “ü—Í
%   U - •”•ª‹óŠÔ‚ðŠi”[‚µ‚½”z—ñB
%   V - •”•ª‹óŠÔ‚ðŠi”[‚µ‚½”z—ñB
% o—Í
%   Similarity - ŒvŽZ‚³‚ê‚½—ÞŽ—“xB

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