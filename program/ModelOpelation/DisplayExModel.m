%% クエリとデータベースの２次元投影を表示する
%
%
function DisplayExModel(Query , Database)

scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)/2])

NQ = length(Query);
ND = length(Database);

L = max([NQ,ND]);
for iq = 1:NQ
    Prj = sum(Query{iq},3);
    subplot(2,L,iq);imagesc(Prj);title(strcat('Query',num2str(iq)));
end

for id = 1:ND
    Prj = sum(Database{id},3);
    subplot(2,L,L+id);imagesc(Prj);title(strcat('Database',num2str(id)));
end

pause(1);

end