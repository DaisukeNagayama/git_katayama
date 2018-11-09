function alignedCell = struct2cell4excel(aStruct, precision)
% aStruct   : output data structure
% precision : a significant figure
% 
% e.g. 
% alignedCell = struct2cell4excel(structure, 6);
% 

% position to input to cell
row = 1;
col = 1;

[alignedCell,~,~] = struct2cell4excelRecursive({}, aStruct, precision, row, col);

end

function [aCell,row,col] = struct2cell4excelRecursive(aCell, aStruct, precision, row, col)

fields = fieldnames(aStruct);

for idx = 1:length(fields)
    % fieldName
    aCell{row,col} = fields{idx};
    col = col+1;    % column of fieldValue
    
    % fieldValue
    aField = aStruct.(fields{idx});
    if isstruct(aField)
        % Recursive processing
        [aCell,row,col] = struct2cell4excelRecursive(aCell, aField, precision, row, col);
    else
        % assign value
        [m,n] = size(aField);
        
        if iscell(aField)
            aCell(row+(1:m)-1,col+(1:n)-1) = aField;
        elseif isnumeric(aField)
            subField = num2cell(aField);
            precisionField = num2cell(ones(size(subField)) * precision);
            aCell(row+(1:m)-1,col+(1:n)-1) = cellfun(@num2str, subField, precisionField, 'UniformOutput', false);
        elseif ( ischar(aField) || isstring(aField) )
            subField = cellstr(aField);
            [m,n] = size(subField);
            aCell(row+(1:m)-1,col+(1:n)-1) = subField;
        end
        
        row = row+m;  % nextline
        col = col-1;  % column of subfieldName
    end
    
end
col = col-1;    % column of fieldName
end
