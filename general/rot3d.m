% Rotaion 3d array (voxel)
% 
% INPUTS: 
%   img             - 3d array (voxel) 
%   elevation       - Amount of rotation in the elevation(É∆) direction
%   azimuth         - Amount of rotation in the azimuth(É”) direction 
%   interpolation   - Specification of interpolation method. If there is no input, linear interpolation
%   backRotation    - Flag for reverse conversion. 
% 
% OUTPUT:
%   img_rotated     - ratated 3d array
%
% EXAMPLES:
%   rot3d(img, pi/4, pi/3, 'nearest')
% 
% Nagayama Daisuke, 2017

function [img_rotated] = rot3d(img, elevation, azimuth, interpolation, backRotation)
if nargin < 4; interpolation = 'linear'; end
if nargin < 5; backRotation = false; end

[NX,NY,NZ] = size(img);
[x,y,z] = ndgrid( -NX/2:1:NX/2-1, -NY/2:1:NY/2-1, -NZ/2:1:NZ/2-1 );

% Ratation
coe = cos(elevation); sie = sin(elevation);
coa = cos(azimuth);   sia = sin(azimuth);
if not(backRotation)
    x1 = coa*x+sia*y;
    y1 = -sia*x+coa*y;
    z1 = z;
    
    xq = coe*x1-sie*z1;
    yq = y1;
    zq = sie*x1+coe*z1;
else
    x1 = coe*x+sie*z;
    y1 = y;
    z1 = -sie*x+coe*z;
    
    xq = coa*x1-sia*y1;
    yq = sia*x1+coa*y1;
    zq = z1;
end

% output
img_rotated = interpn(x,y,z,img,xq,yq,zq,interpolation,0);

end
