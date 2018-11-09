function GroundWallOfSpace(Model)

[NX,NY,NZ] = size(Model);
%% ３次元空間の外面にモデルが接地しているかをチェック
if sum(sum(squeeze( Model(1,:,:) + Model(NX,:,:) ))) ~=0% X方向の境界面
    disp('X接地');
    imagesc(squeeze(sum(Model,3)));pause;
end

if sum(sum(squeeze( Model(:,1,:) + Model(:,NY,:) ))) ~=0% X方向の境界面
    disp('Y接地');
    imagesc(squeeze(sum(Model,3)));pause;
end

if sum(sum(squeeze( Model(:,:,1) + Model(:,:,NZ) ))) ~=0% Z方向の境界面
    disp('Z接地');
    imagesc(squeeze(sum(Model,1)));pause;
end

end