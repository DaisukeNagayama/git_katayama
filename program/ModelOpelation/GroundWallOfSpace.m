function GroundWallOfSpace(Model)

[NX,NY,NZ] = size(Model);
%% �R������Ԃ̊O�ʂɃ��f�����ڒn���Ă��邩���`�F�b�N
if sum(sum(squeeze( Model(1,:,:) + Model(NX,:,:) ))) ~=0% X�����̋��E��
    disp('X�ڒn');
    imagesc(squeeze(sum(Model,3)));pause;
end

if sum(sum(squeeze( Model(:,1,:) + Model(:,NY,:) ))) ~=0% X�����̋��E��
    disp('Y�ڒn');
    imagesc(squeeze(sum(Model,3)));pause;
end

if sum(sum(squeeze( Model(:,:,1) + Model(:,:,NZ) ))) ~=0% Z�����̋��E��
    disp('Z�ڒn');
    imagesc(squeeze(sum(Model,1)));pause;
end

end