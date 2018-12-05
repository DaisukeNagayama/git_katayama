function CulcProcessingTime_forSato(exName, DatabaseGeodesicID, QueryGeodesicID, imgSize, modelTypeRow)

% gdidRow        = [1,2];
% imgSizeRow     = [32,64,128];
% modelTypeRow = {'clutch'; 'die'; 'gear';};

exType      = 'Query';
[pt,pti, pTime, pCount] =  MakePrj4(exName, exType, QueryGeodesicID, imgSize, modelTypeRow) ;

exType      = 'Database';
[pt,pti, pTime, pCount] =  MakePrj4(exName, exType, DatabaseGeodesicID, imgSize, modelTypeRow) ;

end
