function [QueryProjection,DatabaseProjection] = InteglatePrj_forSato(exName, DatabaseGeodesicID, QueryGeodesicID, imgSize, modelTypeRow)

% gdid    = 2;
% imgSize = 128;
% modelTypes = {'clutch'; 'die'; 'gear';};
exType = 'Query';
prjData_Query = IntegratePrj2(exName, exType, QueryGeodesicID, imgSize, modelTypeRow);

modelNum = 15;
labelNum = 5;
for loopModel = 1 : modelNum
  for loopLabel = 1 : labelNum
    fieldN = strcat('Label' , num2str(prjData_Query{loopModel,2}(loopLabel), '%03d'));
    QueryProjection.(prjData_Query{loopModel,1}).(fieldN) = prjData_Query{loopModel,3}{loopLabel,1};
  end
end

exType = 'Database';
prjData_Database = IntegratePrj2(exName, exType, DatabaseGeodesicID, imgSize, modelTypeRow);

modelNum = 15;
labelNum = 5;
for loopModel = 1 : modelNum
  for loopLabel = 1 : labelNum
    fieldN = strcat('Label' , num2str(prjData_Database{loopModel,2}(loopLabel), '%03d'));
    DatabaseProjection.(prjData_Database{loopModel,1}).(fieldN) = prjData_Database{loopModel,3}{loopLabel,1};
  end
end

end