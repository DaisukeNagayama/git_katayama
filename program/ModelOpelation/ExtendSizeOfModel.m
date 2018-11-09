function [ResizedModel] = ExtendSizeOfModel(Model, ExtendLength)
%%���ׂĂ̎p���ω��ɑΉ��ł���悤�ɔz����g������B�g�����̔z��̒l��0�Ƃ����B

%% X�����̊g��
[NX,NY,NZ] = size(Model);
BlockX = zeros(ExtendLength, NY, NZ);
ModelX = cat(1, BlockX, Model, BlockX);
%% Y�����̊g��
[NXx,NYx,NZx] = size(ModelX);
BlockY = zeros(NXx, ExtendLength, NZx);
ModelY = cat(2, BlockY, ModelX, BlockY);
%% Z�����̊g��
[NXy,NYy,NZy] = size(ModelY);
BlockZ = zeros(NXy, NYy, ExtendLength);
ResizedModel = cat(3, BlockZ, ModelY, BlockZ);

end