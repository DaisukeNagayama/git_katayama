function WeightedProjectionStruct = WeightingProjection(ProjectionStruct)
% 投影画像のラベルを体積の逆数によって再付与する。
% 入力
%   ProjectionStruct - 投影画像を格納した構造体。
% 出力
%   WeightedProjectionStruct - ラベルを体積の逆数により再付与した投影画像を格納した構造体。
    
    LabelName = fieldnames(ProjectionStruct);
    for iLabel = 1 : length(LabelName)
        % 着目するサブアセンブリの投影を抜き出す
        FocusingProjection = ProjectionStruct.(LabelName{iLabel});
        % 投影のサイズと枚数を取得する
        [Py, Px, nProjection] = size(FocusingProjection);
        % 重み付けした投影群を格納する変数
        WeightedProjection = zeros(Py, Px, nProjection);
        % 着目するサブアセンブリの投影に対し重み付けする
        for iProjection = 1 : nProjection
            Focusing = FocusingProjection(:, :, iProjection);
            vFocusing = sum(Focusing(:));
            WeightedProjection(:, :, iProjection) = Focusing / vFocusing;
        end
        % 着目するサブアセンブリの重み付き投影に着目しないサブアセンブリの重み付き投影を加える
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