function vertexOUTPUT = vertex_RemoveWall(vertexINPUT, modelType)
% 定義された範囲外の頂点データを除去する関数
  switch modelType
    case 'clutch'
%   if strcmp(modelType, 'clutch')
%     meshXmin =  1.321323633193970;
%     meshXmax = 27.238931655883790;
%     meshYmin = 12.209986686706543;
%     meshYmax = 37.999488830566406;
%     meshZmin =  6.175634860992432;
%     meshZmax = 31.970764160156250;
    lower_limX =  2.00;
    upper_limX = 26.50;
    lower_limY = 13.00;
    upper_limY = 37.50;
    lower_limZ =  6.50;
    upper_limZ = 31.00;
    case 'die'
%   elseif strcmp(modelType, 'die')
%     meshXmin =  -9.0007;
%     meshXmax =  29.1993;
%     meshYmin = -19.0000;
%     meshYmax =  19.2000;
%     meshZmin = -13.6200;
%     meshZmax =  24.5800;
    lower_limX =  -8.00;
    upper_limX =  28.20;
    lower_limY = -18.00;
    upper_limY =  18.20;
    lower_limZ = -12.60;
    upper_limZ =  23.60;
    case 'gear'
%   elseif strcmp(modelType, 'gear')
%     meshXmin = -29.8476;
%     meshXmax =  16.3524;
%     meshYmin = -22.9923;
%     meshYmax =  23.2077;
%     meshZmin = -23.0000;
%     meshZmax =  23.2000;
    lower_limX = -28.85;
    upper_limX =  15.35;
    lower_limY = -22.00;
    upper_limY =  22.20;
    lower_limZ = -22.00;
    upper_limZ =  22.20;
    case 'hydraulic'
%       verCenter=   [1.29254600000000;2.18635700000000;2.45956200000000];
%     meshXmin = -4.357454000000000;
%     meshXmax =  6.942546000000000;
%     meshYmin = -3.463592000000000;
%     meshYmax =  7.836306000000000;
%     meshZmin = -2.167438000000000;
%     meshZmax =  7.086562000000000;
      lower_limX = -8.3;
      upper_limX =  10.3;
      lower_limY = -7.0;
      upper_limY =  11.0;
      lower_limZ = -4;
      upper_limZ =  14.0;  
    otherwise
      error('vertex_removeWall()の引数エラー');
  end
  facetNum = length(vertexINPUT);    
  for i = facetNum : - 1 : 1
      if vertexINPUT(i,1,1) < lower_limX || vertexINPUT(i,1,2) < lower_limX || vertexINPUT(i,1,3) < lower_limX ||...
         vertexINPUT(i,1,1) > upper_limX || vertexINPUT(i,1,2) > upper_limX || vertexINPUT(i,1,3) > upper_limX ||...
         vertexINPUT(i,2,1) < lower_limY || vertexINPUT(i,2,2) < lower_limY || vertexINPUT(i,2,3) < lower_limY ||...
         vertexINPUT(i,2,1) > upper_limY || vertexINPUT(i,2,2) > upper_limY || vertexINPUT(i,2,3) > upper_limY ||...
         vertexINPUT(i,3,1) < lower_limZ || vertexINPUT(i,3,2) < lower_limZ || vertexINPUT(i,3,3) < lower_limZ ||...
         vertexINPUT(i,3,1) > upper_limZ || vertexINPUT(i,3,2) > upper_limZ || vertexINPUT(i,3,3) > upper_limZ

         vertexINPUT(i,:,:) = [];
      end
  end
  vertexOUTPUT = vertexINPUT;
end