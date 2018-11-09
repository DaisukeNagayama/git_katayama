function [ResizedModel] = ExtendSizeOfModel(Model, ExtendLength)
%%すべての姿勢変化に対応できるように配列を拡張する。拡張分の配列の値は0とした。

%% X方向の拡張
[NX,NY,NZ] = size(Model);
BlockX = zeros(ExtendLength, NY, NZ);
ModelX = cat(1, BlockX, Model, BlockX);
%% Y方向の拡張
[NXx,NYx,NZx] = size(ModelX);
BlockY = zeros(NXx, ExtendLength, NZx);
ModelY = cat(2, BlockY, ModelX, BlockY);
%% Z方向の拡張
[NXy,NYy,NZy] = size(ModelY);
BlockZ = zeros(NXy, NYy, ExtendLength);
ResizedModel = cat(3, BlockZ, ModelY, BlockZ);

end