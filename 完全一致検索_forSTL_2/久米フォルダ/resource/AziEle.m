
num_az = 8;
num_el = 5;

sprintf('azimth = %f,elevation = %f',  (360 / (num_az)), (180 / (num_el-1)))

azimuth =  0 : (360 / (num_az)) : 360;
azimuth(end) = [];
elevation = -90 : (180 / (num_el-1)) : 90;

az = repmat(azimuth',[1,num_el]);
el = repmat(elevation,[num_az,1]);
r  = ones(num_az, num_el);

[x,y,z] = sph2cart(az,el,r);
ue = [x(:), y(:), z(:)];

%saveName = ['ico_az',num2str(num_az),'el',num2str(num_el),'.mat'];
saveName = ['projectionPoints\ico_az',num2str(num_az),'el',num2str(num_el),'.mat'];
save(saveName, 'ue');