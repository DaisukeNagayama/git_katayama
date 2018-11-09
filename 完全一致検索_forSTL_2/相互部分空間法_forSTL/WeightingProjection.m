function WeightedProjectionStruct = WeightingProjection(ProjectionStruct)
% ���e�摜�̃��x����̐ς̋t���ɂ���čĕt�^����B
% ����
%   ProjectionStruct - ���e�摜���i�[�����\���́B
% �o��
%   WeightedProjectionStruct - ���x����̐ς̋t���ɂ��ĕt�^�������e�摜���i�[�����\���́B
    
    LabelName = fieldnames(ProjectionStruct);
    for iLabel = 1 : length(LabelName)
        % ���ڂ���T�u�A�Z���u���̓��e�𔲂��o��
        FocusingProjection = ProjectionStruct.(LabelName{iLabel});
        % ���e�̃T�C�Y�Ɩ������擾����
        [Py, Px, nProjection] = size(FocusingProjection);
        % �d�ݕt���������e�Q���i�[����ϐ�
        WeightedProjection = zeros(Py, Px, nProjection);
        % ���ڂ���T�u�A�Z���u���̓��e�ɑ΂��d�ݕt������
        for iProjection = 1 : nProjection
            Focusing = FocusingProjection(:, :, iProjection);
            vFocusing = sum(Focusing(:));
            WeightedProjection(:, :, iProjection) = Focusing / vFocusing;
        end
        % ���ڂ���T�u�A�Z���u���̏d�ݕt�����e�ɒ��ڂ��Ȃ��T�u�A�Z���u���̏d�ݕt�����e��������
        for iProjection = 1 : nProjection
            Other = zeros(Py, Px);
            vOther = 0;
            for jLabel = 1 : length(LabelName)
                if jLabel == iLabel
                    continue;
                end
                OtherProjection = ProjectionStruct.(LabelName{jLabel});
                tOther = OtherProjection(:, :, iProjection);
                Other = Other + tOther;
                vOther = vOther + sum(tOther(:));
            end
            WeightedProjection(:, :, iProjection) = ...
                WeightedProjection(:, :, iProjection) + Other / vOther;
        end
        WeightedProjectionStruct.(LabelName{iLabel}) = WeightedProjection;

    end

end