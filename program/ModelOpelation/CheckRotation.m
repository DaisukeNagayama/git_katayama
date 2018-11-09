function CheckRotation(Model, ExL)

ResizedModel = ExtendSizeOfModel(Model, ExL);
[NX,NY,NZ] = size(ResizedModel);
disp(strcat(num2str(NX),'×',num2str(NY),'×',num2str(NZ),'のモデル'))
for i = 0:180
    for j = 0:360
    mr3d = rot3d(ResizedModel, i, j, 'nearest');
    %% ３次元空間の外面にモデルが接地しているかをチェック
    
    if sum(sum(squeeze( mr3d(1,:,:) + mr3d(NX,:,:) ))) ~=0% X方向の境界面
        disp(strcat('緯度',num2str(i),'/経度',num2str(j),'の回転'));
        disp('空間の壁Xに接地');
    end
    if sum(sum(squeeze( mr3d(:,1,:) + mr3d(:,NY,:) ))) ~=0% X方向の境界面
        disp(strcat('緯度',num2str(i),'/経度',num2str(j),'の回転'));
        disp('空間の壁Yに接地');
    end
    if sum(sum(squeeze( mr3d(:,:,1) + mr3d(:,:,NZ) ))) ~=0% Z方向の境界面
        disp(strcat('緯度',num2str(i),'/経度',num2str(j),'の回転'));
        disp('空間の壁Zに接地');
    end
    end
end

end