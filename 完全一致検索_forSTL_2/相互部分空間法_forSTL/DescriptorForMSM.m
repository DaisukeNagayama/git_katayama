function FeatureStruct = DescriptorForMSM(ProjectionStruct, nDivide)
% 投影から特徴抽出を行う関数。
% 相互部分空間法に最適化している。
% 入力
%   ProjectionStruct - 重み付き投影を格納した構造体。
%   nDivide          - 特徴の分割回数。
% 出力
%   FeatureStruct - 特徴を格納した構造体。

    LabelName = fieldnames(ProjectionStruct);

    for iLabel = 1 : length(LabelName)
        
        Projection = ProjectionStruct.(LabelName{iLabel});
        [Py, Px, nProjection] = size(Projection);
        nRadon = length(radon(zeros(Py, Px), 1));
        nTheta = 180;
        CentreY = ceil(nRadon / 2);
        CentreX = ceil(nTheta / 2);
        nRadonDivided = ceil(nRadon / (2 ^ (nDivide)));
        nThetaDivided = ceil(nTheta / (2 ^ (nDivide)));
        Left = CentreX - ceil(nThetaDivided / 2) + 1;
        Top = CentreY - ceil(nRadonDivided / 2) + 1;
        Feature = zeros(nRadonDivided * nThetaDivided, nProjection);
        for iProjection = 1 : nProjection
            FeatureMatrix = abs(ShiftFFT(abs(ShiftFFT(radon(Projection(:, :, iProjection)), 1)), 2));
            FeatureMatrix = FeatureMatrix(Top : Top + nRadonDivided - 1, Left : Left + nThetaDivided - 1);
            Feature(:, iProjection) = MatrixToVector(FeatureMatrix);
        end
        FeatureStruct.(LabelName{iLabel}) = Feature;
        
    end

end

function G = ShiftFFT(F, N)

    G = ifftshift(fft(fftshift(F, N), [], N), N);

end

function Vector = MatrixToVector(Matrix)

    Vector = Matrix(:);
    
    M = mean(Vector);
    Vector = Vector - M;
    N = sqrt(sum(Vector .* Vector));
    Vector = Vector / N;

end