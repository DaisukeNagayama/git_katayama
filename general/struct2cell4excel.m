function [aCell,row,col] = struct2cell4excel(aCell, aStruct, row, col)
% aCell   : cell for output in excel
% aStruct : output data structure
% row,col : position to start input
% 
% e.g. [aCell,row,col] = struct2cell4excel(cell(100), structure, 1, 1);
% 
% 
% 

fields = fieldnames(aStruct);
for idx = 1:length(fields)
    % fieldName
    aCell{row,col} = fields{idx};
    col = col+1;    % column of fieldValue
    % fieldValue
    aField = aStruct.(fields{idx});
    if isstruct(aField)
        % Recursive processing
        [aCell,row,col] = struct2cell4excel(aCell, aField, row, col);
    else
        % assign value
        [m,n] = size(aField);
        subField = num2cell(aField);
        aCell(row+(1:m)-1,col+(1:n)-1) = subField;
        row = row+m;  % nextline
        col = col-1;  % column of subfieldName
    end
end
col = col-1;    % column of fieldName
end
