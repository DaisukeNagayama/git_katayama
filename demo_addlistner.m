% �{�����[���f�[�^�̕\��
% addlistener: �C�x���g�����m���ăv���b�g��ω�������
% 

% % �f�[�^�ǂݍ���
% load mri  % �l�̓�����MRI�f�[�^
D = load('C:\Users\Nagayama\Documents\MATLAB\program\Models\Size96\Clutch96001.mat');
if isstruct(D)      % �\���̂Ȃ�
    fields = fieldnames(D);
    D = getfield(D,fields{1});  % 1�Ԗڂ̃t�B�[���h��\��
end
D = squeeze(D);

% �����ɉ�]
% D = rot3d(D,pi/4,0);

% Plot
figure(1)
[~,handle_surf] = contour(D(:,:,1));
title('�X�J���[ �{�����[�� �f�[�^�̉���');

% �X���C�_�[�o�[�쐬
sliderMin = 1;
sliderMax = size(D,3);
sliderInitial = round((sliderMin + sliderMax)/2);
handle_slider = uicontrol('Style','slider','Position',[10 50 20 340],'Min',sliderMin,'Max',sliderMax,'Value',1);

% �C�x���g���X�i�[�̍쐬
addlistener(handle_slider,'Value','PostSet',@(event,obj) update(event,obj,D,handle_surf,handle_slider));

% �`��̃A�b�v�f�[�g�����p�֐�

function update(event,obj,D,handle_surf,handle_slider)
index = round(handle_slider.Value);
handle_surf.ZData = double(D(:,:,index));
end