%% Clutch,Die,Gear �̃p�^�[���Ⴂ���Q�������e�ŉ���
% 
% ���s�e�X�g�p
% parts_show(Clutch64001,100);  % �֗��@Clutch: 100, 300, 400, 500, 600,
% 
%% �萔�̎w��
MODEL = 'Clutch';  % ���f����, �������͑啶���œ��� ('Clutch' / 'Die' / 'Gear')
SIZE  = 96;     % ���f���T�C�Y, ���l�œ��� (64 / 96)

dd = 3;         % �񎟌����e���B����� (1,2,3)
stacked = false; % ���e����i, ���i�ŕ����邩�ǂ���
SIDE = 'top';       % �㑤��������  ('top' / 'bottom')

%% ���[�N�X�y�[�X���烂�f���ǂݍ���
switch MODEL
    case 'Clutch'
        switch SIZE
            case 64
                Model1 = Clutch64001; Model2 = Clutch64002; Model3 = Clutch64003; Model4 = Clutch64004; Model5 = Clutch64005;
            case 96
                Model1 = Clutch96001; Model2 = Clutch96002; Model3 = Clutch96003; Model4 = Clutch96004; Model5 = Clutch96005;
        end
    case 'Die'
        switch SIZE
            case 64
                Model1 = Die64001; Model2 = Die64002; Model3 = Die64003; Model4 = Die64004; Model5 = Die64005;
            case 96
                Model1 = Die96001; Model2 = Die96002; Model3 = Die96003; Model4 = Die96004; Model5 = Die96005;
        end
    case 'Gear'
        switch SIZE
            case 64
                Model1 = Gear64001; Model2 = Gear64002; Model3 = Gear64003; Model4 = Gear64004; Model5 = Gear64005;
            case 96
                Model1 = Gear96001; Model2 = Gear96002; Model3 = Gear96003; Model4 = Gear96004; Model5 = Gear96005;
        end
    otherwise
        disp('error(showClutch.m): otherwise')
end

%% �J���[�}�b�v�̗p��
myColorMap = jet;
myColorMap(1,:) = zeros(1,3);   % �w�i�F�̎w��

% cc = jet;
% myColorMap(2:5,:) = repmat(cc(1,:), [4,1]);    % 
% myColorMap(6:13,:) = repmat(cc(10,:), [8,1]);  % 
% myColorMap(14:19,:) = repmat(cc(20,:), [6,1]);  % 
% myColorMap(20:24,:) = repmat(cc(30,:), [5,1]);  % 
% myColorMap(25:29,:) = repmat(cc(40,:), [5,1]);  % 
% myColorMap(30:39,:) = repmat(cc(50,:), [10,1]);  % 
% myColorMap(40:64,:) = repmat(cc(60,:), [25,1]);  % 

%% ���f���̃��x���ꗗ��\��
disp(strcat('���x���ꗗ'));
disp(strcat('�� ', num2str(unique([Model1; Model2; Model3; Model4; Model5]))));

%% 2�i�ɕ����ăv���b�g����Ƃ�
if stacked
    switch SIDE
        case 'top'
            Model1 = Model1(:,:,(1:SIZE/3));
            Model2 = Model2(:,:,(1:SIZE/3));
            Model3 = Model3(:,:,(1:SIZE/3));
            Model4 = Model4(:,:,(1:SIZE/3));
            Model5 = Model5(:,:,(1:SIZE/3));
        case 'bottom'
            Model1 = Model1(:,:,(1:SIZE/3) + SIZE/3);
            Model2 = Model2(:,:,(1:SIZE/3) + SIZE/3);
            Model3 = Model3(:,:,(1:SIZE/3) + SIZE/3);
            Model4 = Model4(:,:,(1:SIZE/3) + SIZE/3);
            Model5 = Model5(:,:,(1:SIZE/3) + SIZE/3);
    end
end

%% �ʏ�v���b�g
figure,
subplot(2,5,1), imagesc(squeeze(sum(Model1,dd))); axis off; %title(strcat(MODEL, num2str(1)));
subplot(2,5,2), imagesc(squeeze(sum(Model2,dd))); axis off; %title(strcat(MODEL, num2str(2)));
subplot(2,5,3), imagesc(squeeze(sum(Model3,dd))); axis off; %title(strcat(MODEL, num2str(3)));
subplot(2,5,4), imagesc(squeeze(sum(Model4,dd))); axis off; %title(strcat(MODEL, num2str(4)));
subplot(2,5,5), imagesc(squeeze(sum(Model5,dd))); axis off; %title(strcat(MODEL, num2str(5)));

%% �y��������ăv���b�g
Model1(Model1 == 100) = 0;
Model2(Model2 == 100) = 0;
Model3(Model3 == 100) = 0;
Model4(Model4 == 100) = 0;
Model5(Model5 == 100) = 0;

subplot(2,5,6), imagesc(squeeze(sum(Model1,dd))); axis off; %title(strcat(MODEL, num2str(1)));
subplot(2,5,7), imagesc(squeeze(sum(Model2,dd))); axis off; %title(strcat(MODEL, num2str(2)));
subplot(2,5,8), imagesc(squeeze(sum(Model3,dd))); axis off; %title(strcat(MODEL, num2str(3)));
subplot(2,5,9), imagesc(squeeze(sum(Model4,dd))); axis off; %title(strcat(MODEL, num2str(4)));
subplot(2,5,10), imagesc(squeeze(sum(Model5,dd))); axis off; %title(strcat(MODEL, num2str(5)));

colormap(myColorMap)
