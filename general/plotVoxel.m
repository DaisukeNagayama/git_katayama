% plotBoxcel ボリュームデータを平滑化ポリゴンモデルで可視化
% 
% 
% plotVoxel( Clutch96001 )

function plotVoxel( Model )

sizeX = size(Model,2);
sizeY = size(Model,1);
sizeZ = size(Model,3);

%===parameter===%
th=0.5;

%===3D image===%
figure, axis equal off;
    fv=isosurface(Model,th);
    p1 = patch(fv,'FaceColor',[0.3,0.3,1],'EdgeColor','none');
    isonormals(Model,p1)
    daspect([1,1,1]);
    axis([0,sizeX+1,0,sizeY+1,0,sizeZ+1]);
    view(-45,45);
    % camzoom(sizeX * 10)
    camlight
    lightangle(60,60);
    lighting gouraud
    grid on;

% hold on;
% [sx,sz]=meshgrid(1:0.1:9,-3:0.1:3);
% ob=slice(x,y,z,v,sx,0*ones(size(sz)),sz);
% set(ob,'FaceColor','interp','EdgeColor','none');


% return;


