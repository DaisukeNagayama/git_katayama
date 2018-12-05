function [T,C] = ProjectionByDepthVolume7(loadPath, saveDir, partsName, affTemp, imgSize, azimuthRow, elevationRow, verAreaCenter, getAffineF, pTTime)
% 深度バッファ法で投影を作成する関数
% アフィン決定版
% 頂点内側でロード版
% vertex  : 頂点データ。ポリゴン(i)*座標(x,y,z)*頂点(1st,2nd,3rd)
% imgSize : 投影の1辺の長さ(px)。

t1=0;co1=0;
t2=0;co2=0;
t3=0;co3=0;
t4=0;co4=0;
t5=0;co5=0;
t6=0;co6=0;
% パーツのロード
%tt1 = tic;
load(loadPath, 'vertex');


facetNum = size(vertex,1);
anglesNum = length(azimuthRow);
prjData = cell(anglesNum,1);

%配列の形の変換
vertex2 = permute(vertex, [1 3 2]);
vertex_Re3 = [reshape(vertex2,facetNum*3,3), ones(facetNum*3,1)];

%tt2 = tic;
for loopAngles = 1 : anglesNum  
  prjFront = zeros(imgSize,imgSize);
  prjBack = zeros(imgSize,imgSize);
  prjCountFront = zeros(imgSize,imgSize);
  prjCountBack = zeros(imgSize,imgSize);
  
  affR3 = getAffineF.RotationX(-azimuthRow(loopAngles), verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
  affR4 = getAffineF.RotationY(-elevationRow(loopAngles), verAreaCenter(1), verAreaCenter(2), verAreaCenter(3));
  affAll = affTemp*affR3*affR4;
  vertex_Re4 = vertex_Re3*affAll;
  
  v1rot= vertex_Re4(1:facetNum,1:3);
  v2rot = vertex_Re4(facetNum+1:facetNum*2,1:3);
  v3rot = vertex_Re4(facetNum*2+1:facetNum*3,1:3);
  
  tmpX =  [v1rot(:,1), v2rot(:,1), v3rot(:,1)];
  tmpY =  [v1rot(:,2), v2rot(:,2), v3rot(:,2)];
  % 描画範囲用
  coordMaxX = max(ceil(tmpX),[],2);
  coordMinX = min(floor(tmpX),[],2);
  coordMaxY = max(ceil(tmpY),[],2);
  coordMinY = min(floor(tmpY),[],2);
  % サンプリングしない部分カット用
  cutMaxX = max(floor(tmpX),[],2);
  cutMinX = min(ceil(tmpX),[],2);
  cutMaxY = max(floor(tmpY),[],2);
  cutMinY = min(ceil(tmpY),[],2);
    
  ABcol =  v2rot - v1rot;
  BCcol =  v3rot - v2rot;
  CAcol =  v1rot - v3rot;
  n1col = ABcol(:,2).*-CAcol(:,3)-ABcol(:,3).*-CAcol(:,2);
  n2col = ABcol(:,3).*-CAcol(:,1)-ABcol(:,1).*-CAcol(:,3);
  n3col = ABcol(:,1).*-CAcol(:,2)-ABcol(:,2).*-CAcol(:,1);
  
  %tt3 = tic;
  %   clear vertex
  for loopFacet = 1 : facetNum
    normal3 = n3col(loopFacet);
    if (cutMinX(loopFacet) <= cutMaxX(loopFacet)) ...
    && (cutMinY(loopFacet) <= cutMaxY(loopFacet)) ...
    && normal3 ~= 0
    A = v1rot(loopFacet,:);
    B = v2rot(loopFacet,:);
    C = v3rot(loopFacet,:);
    
    AB = ABcol(loopFacet,:);
    BC = BCcol(loopFacet,:);
    CA = CAcol(loopFacet,:);
    
    normal1 = n1col(loopFacet);
    normal2 = n2col(loopFacet);
%     normal3 = n3col(loopFacet);
    
    Xmin = coordMinX(loopFacet);
    Xmax = coordMaxX(loopFacet);
    Ymin = coordMinY(loopFacet);
    Ymax = coordMaxY(loopFacet);
    
    %tt4 = tic;   
    %真横向きのポリゴンは無視
%     if (cutMinX(loopFacet) <= cutMaxX(loopFacet)) ...
%     && (cutMinY(loopFacet) <= cutMaxY(loopFacet)) ...
%     && normal3 ~= 0
      %当たり判定部分      
      for j = Ymin : Ymax
        for i = Xmin : Xmax 
          %サンプリング点とポリゴンの頂点との外積
          c1 = AB(1)*(j-B(2)) - AB(2)*(i-B(1));
          c2 = BC(1)*(j-C(2)) - BC(2)*(i-C(1));
          c3 = CA(1)*(j-A(2)) - CA(2)*(i-A(1));
          %tt5 = tic;
          %ポリゴン通過時処理
          if ( c1 >= 0 && c2 >= 0 && c3 >= 0 ) || ( c1 <= 0 && c2 <= 0 && c3 <= 0 )
            %tt6 = tic;
            depth = (((normal1 * (i-A(1)) + normal2 * (j-A(2))) / -normal3) + A(3) );
            % 辺以外を通過時の係数:1
            if c1 ~= 0 && c2 ~= 0 && c3 ~= 0            
            factor = 1;
            % 頂点通過時の係数:(なす角/2pi)
            elseif c1 == 0 && c2 == 0
              factor = subspace(AB(1:2)',BC(1:2)') / (2*pi);
            elseif c2 == 0 && c3 == 0
              factor = subspace(BC(1:2)',CA(1:2)') / (2*pi);
            elseif c3 == 0 && c1 == 0
              factor = subspace(CA(1:2)',AB(1:2)') / (2*pi);              
            % 辺の上を通過時の係数:0.5
            elseif c1 == 0 || c2 == 0 || c3 == 0
              factor = 0.5;
            end %if
            
            if sign(normal3) < 0
              prjCountFront(j, i) = prjCountFront(j, i) + factor;
              prjFront(j,i) = prjFront(j,i) + depth * factor;
            elseif sign(normal3) > 0
              prjCountBack(j, i) = prjCountBack(j, i) + factor;
              prjBack(j,i)  = prjBack(j,i)  + depth * factor;
            end
            %t6 = t6 + toc(tt6); co6 = co6+1;
          end %if
          %t5 = t5 + toc(tt5); co5 = co5+1;
        end %for i =
      end %for j =
    end %if normal3 ~= 0
    %t4 = t4 + toc(tt4); co4 = co4+1;
  end %for loopFacet
  %t3 = t3 + toc(tt3); co3 = co3+1;
% 負の値出現防止
tempPrj = prjBack - prjFront;
tempPrj(tempPrj <0) = 0;
prjData(loopAngles,1) = {tempPrj};
  
% 投影エラー検知
CheckPrjCount =  round(prjCountBack,15) - round(prjCountFront,15);
% CheckPrjCount =  prjCountBack - prjCountFront;
% if 0
% if 1
if sum(sum(CheckPrjCount)) ~= 0
  fprintf('/PrjectionError/');
  debugFlag = 0;
  if debugFlag == 1
  takasa = 2;
  haba = 6;
  half = round(imgSize/2);
  cMax = max(max(prjBack));
  tempImg = prjFront;
  subplot(takasa, haba, 1); imagesc(tempImg); colorbar; title(sum(sum(tempImg))); caxis([0 cMax]);
  tempImg = prjBack;
  subplot(takasa, haba, 2); imagesc(tempImg); colorbar; title(sum(sum(tempImg))); caxis([0 cMax]);
  tempImg = prjBack - prjFront;
  cMax = max(max(tempImg));
  subplot(takasa, haba, 3); imagesc(tempImg); colorbar; title(sum(sum(tempImg))); caxis([0 cMax]);
  tempImg = prjCountFront(:,:);
  subplot(takasa, haba, 4); imagesc(tempImg); colorbar; title(sum(sum(tempImg)));
  tempImg = prjCountBack(:,:);
  subplot(takasa, haba, 5); imagesc(tempImg); colorbar; title(sum(sum(tempImg)));
  tempImg = prjCountFront(:,:)-prjCountBack(:,:);
  subplot(takasa, haba, 6); imagesc(tempImg); colorbar; title(sum(sum(tempImg)));
  ofs = haba*1;
  tempImg = prjFront(half,:);
  subplot(takasa, haba, 1+ofs); plot(tempImg);  title(sum(tempImg));
  tempImg = prjBack(half,:);
  subplot(takasa, haba, 2+ofs); plot(tempImg);  title(sum(tempImg));
  tempImg = prjBack(half,:)- prjFront(half,:);
  subplot(takasa, haba, 3+ofs); plot(tempImg);  title(sum(tempImg));
  tempImg = prjCountFront(half,:);
  subplot(takasa, haba, 4+ofs); plot(tempImg); title(sum(tempImg));
  tempImg = prjCountBack(half,:);
  subplot(takasa, haba, 5+ofs); plot(tempImg); title(sum(tempImg));
  tempImg = prjCountFront(half,:) - prjCountBack(half,:);
  subplot(takasa, haba, 6+ofs); plot(tempImg); title(sum(tempImg));
  end  
end
end % loopAngles
%t2 = t2 + toc(tt2); co2 = co2+1;
savePath = [saveDir, filesep, partsName, '.mat'];
% save(savePath, 'prjData');
save(savePath, 'prjData', '-v7.3');
%t1 = t1 + toc(tt1); co1 = co1+1;
T = [t1;t2;t3;t4;t5;t6;];
C = [co1;co2;co3;co4;co5;co6;];
end %function