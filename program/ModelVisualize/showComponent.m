%% モデルの特定のラベル値の部品だけを取り出す
% 
% showComponent(Clutch96001,100)/1000;
% 
% figure, imshow(sum(showComponent(Clutch96001,100),3)/2000,[],'InitialMagnification',300), colormap(bone)
% 
%%
function parts=showComponent(model,number)
s_m=size(model);
parts=zeros(s_m(1),s_m(2),s_m(3));
for i =1:s_m(1)
    for j = 1:s_m(2)
        for k=1:s_m(3)
            if model(i,j,k)==number
                parts(i,j,k)=number;
            end
        end
    end
end
imagesc(squeeze(sum(parts,3)))
end


% D = showComponent(Clutch96001,100)/1000;
% Ds = smooth3(D); hiso = patch(isosurface(Ds,5),'FaceColor','blue', 'EdgeColor','none'); isonormals(Ds,hiso)
