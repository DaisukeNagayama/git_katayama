%% Let's LIFE GAME!!
% ��Ԃ݂Ƀ��C�t�Q�[���쐬
% ��ł��Ńp�^�[�����͂��Č�͍X�V�𒭂߂邾���̎蔲���v���O����
% 
% 

% 1 -> 2,3
% 0 -> 3 


%% initialize
clear
close all

fps = 0.05;
sizeOfBoard = 64;     % size of board
board = zeros(sizeOfBoard+2);
B = zeros(size(board));

lifeFilter = [1,1,1; 1,1i,1; 1,1,1];

%% Patterns

% All Random
board = randi([0 1], size(board));

% % ���
% OSgx = 32;
% OSgy = 32;
% board(OSgy - 4 : OSgy + 1, OSgx - 4 : OSgx - 3) = 1;
% board(OSgy - 4 : OSgy - 3, OSgx - 1 : OSgx + 4) = 1;
% board(OSgy - 1 : OSgy + 4, OSgx + 3 : OSgx + 4) = 1;
% board(OSgy + 3 : OSgy + 4, OSgx - 4 : OSgx + 1) = 1;
% 
% % �O���C�_�[�i�E��j
% OSrux = 15;
% OSruy = 15;
% board(OSruy - 1 : OSruy + 1, OSrux + 1) = 1;
% board(OSruy - 1            , OSrux    ) = 1;
% board(OSruy                , OSrux - 1) = 1;
% 
% % �O���C�_�[�i�E���j
% OSrdx = 45;
% OSrdy = 15;
% board(OSrdy - 1 : OSrdy + 1, OSrdx + 1) = 1;
% board(OSrdy + 1            , OSrdx    ) = 1;
% board(OSrdy                , OSrdx - 1) = 1;

%% Draw initial figure
figure(1);
imshow(board(2:end-1,2:end-1), 'InitialMagnification', 1000)
colormap(gray)

%% Animation Loop
while(1)
    B = board;
    
    % looping the edge
    B(1,:) = board(end - 1,:);
    B(end,:) = board(2,:);
    B(:,1) = board(:,end - 1);
    B(:,end) = board(:,2);
    
    % calculation
    BConvoluted = conv2(B, lifeFilter);  % ���͂�1�}�X�����āA��ӂ̃T�C�Y��2������
    B = BConvoluted(2:end-1,2:end-1);    % �g���~���O���Ĉ�ӂ̃T�C�Y�����ɖ߂�
    B(real(B) >= 4) = 0;            % �ߖ� / Lonely
    B = real(B) + imag(B);          % 
    B(B <= 2) = 0;                  % �ߑa / Over-crowded
    B = sign(abs(B));               % �l�� 0,1 �ɑ�����
    
    % update
    board = B;
    imagesc(board(2:end-1,2:end-1));
    drawnow;
    colormap(gray)
    pause(fps)
end


 