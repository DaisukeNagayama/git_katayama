function [verMin, verMax, verCenter, verRange] = vertex_CalculateData(vertex, mode)
% 頂点データ範囲の定義
% modeが'clutch', 'die', 'gear'の場合はあらかじめ定義した範囲を返す。
% modeが'true'の場合は実際の範囲を調べて返す。
  switch mode
    case 'clutch'
%     meshXmin =  1.321323633193970;
%     meshXmax = 27.238931655883790;
%     meshYmin = 12.209986686706543;
%     meshYmax = 37.999488830566406;
%     meshZmin =  6.175634860992432;
%     meshZmax = 31.970764160156250;
      meshXmin = 1.25;
      meshXmax = 27.25;
      meshYmin = 12.00;
      meshYmax = 38.00;
      meshZmin = 6.00;
      meshZmax = 32.00;
    case 'die'
%     meshXmin =  -9.0007;
%     meshXmax =  29.1993;
%     meshYmin = -19.0000;
%     meshYmax =  19.2000;
%     meshZmin = -13.6200;
%     meshZmax =  24.5800;
      meshXmin =  -10.50;
      meshXmax =  30.70;
      meshYmin = -20.50;
      meshYmax =  20.70;
      meshZmin = -15.10;
      meshZmax =  26.10;
    case 'gear'
%     meshXmin = -29.8476;
%     meshXmax =  16.3524;
%     meshYmin = -22.9923;
%     meshYmax =  23.2077;
%     meshZmin = -23.0000;
%     meshZmax =  23.2000;
      meshXmin = -29.85;
      meshXmax =  16.35;
      meshYmin = -23.00;
      meshYmax =  23.20;
      meshZmin = -23.00;
      meshZmax =  23.20;
    case 'hydraulic'
%       verCenter=   [1.29254600000000;2.18635700000000;2.45956200000000];
%     meshXmin = -4.357454000000000;
%     meshXmax =  6.942546000000000;
%     meshYmin = -3.463592000000000;
%     meshYmax =  7.836306000000000;
%     meshZmin = -2.167438000000000;
%     meshZmax =  7.086562000000000;
      meshXmin = -8.3;
      meshXmax =  10.3;
      meshYmin = -7.0;
      meshYmax =  11.0;
      meshZmin = -5.0;
      meshZmax =  13.0;   
    case 'true'
      meshXmin = min(min(vertex(:,1,:)));
      meshYmin = min(min(vertex(:,2,:)));
      meshZmin = min(min(vertex(:,3,:)));
      meshXmax = max(max(vertex(:,1,:)));
      meshYmax = max(max(vertex(:,2,:)));
      meshZmax = max(max(vertex(:,3,:)));
    otherwise 
    error('vertex_culculateData()の引数エラー');
  end
  verCenter = zeros(3,1);
  verRange  = zeros(3,1);
  verMin    = zeros(3,1);
  verMax    = zeros(3,1);
  verMin(1) = meshXmin;
  verMin(2) = meshYmin;
  verMin(3) = meshZmin;
  verMax(1) = meshXmax;
  verMax(2) = meshYmax;
  verMax(3) = meshZmax;
  verRange(1) = (meshXmax-meshXmin);
  verRange(2) = (meshYmax-meshYmin);
  verRange(3) = (meshZmax-meshZmin);
  verCenter(1) = (meshXmax+meshXmin) / 2;
  verCenter(2) = (meshYmax+meshYmin) / 2;
  verCenter(3) = (meshZmax+meshZmin) / 2;
end