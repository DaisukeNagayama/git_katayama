function FeatureStruct = DescriptorForMSM(ProjectionStruct, nDivide)
% ���e����������o���s���֐��B
% ���ݕ�����Ԗ@�ɍœK�����Ă���B
% ����
%   ProjectionStruct - �d�ݕt�����e���i�[�����\���́B
%   nDivide          - �����̕����񐔁B
% �o��
%   FeatureStruct - �������i�[�����\���́B

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