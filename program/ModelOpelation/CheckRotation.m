function CheckRotation(Model, ExL)

ResizedModel = ExtendSizeOfModel(Model, ExL);
[NX,NY,NZ] = size(ResizedModel);
disp(strcat(num2str(NX),'�~',num2str(NY),'�~',num2str(NZ),'�̃��f��'))
for i = 0:180
    for j = 0:360
    mr3d = rot3d(ResizedModel, i, j, 'nearest');
    %% �R������Ԃ̊O�ʂɃ��f�����ڒn���Ă��邩���`�F�b�N
    
    if sum(sum(squeeze( mr3d(1,:,:) + mr3d(NX,:,:) ))) ~=0% X�����̋��E��
        disp(strcat('�ܓx',num2str(i),'/�o�x',num2str(j),'�̉�]'));
        disp('��Ԃ̕�X�ɐڒn');
    end
    if sum(sum(squeeze( mr3d(:,1,:) + mr3d(:,NY,:) ))) ~=0% X�����̋��E��
        disp(strcat('�ܓx',num2str(i),'/�o�x',num2str(j),'�̉�]'));
        disp('��Ԃ̕�Y�ɐڒn');
    end
    if sum(sum(squeeze( mr3d(:,:,1) + mr3d(:,:,NZ) ))) ~=0% Z�����̋��E��
        disp(strcat('�ܓx',num2str(i),'/�o�x',num2str(j),'�̉�]'));
        disp('��Ԃ̕�Z�ɐڒn');
    end
    end
end

end