% Output structure to Excel.
% 
% INPUTS:
%   filePath       - Excel file path.                                     [char]
%   bodyStruct     - The structure you want to output.                    [struct]
%   (headerStruct) - The structure with supplemental information written. [struct]
%   (startCell)    - Position to start writing to Excel file.             [1x2]
%   (sheet)        - Sheet number of Excel.                               [1x1]
%   (precision)    - Significant digits.                                  [1x1]
% 
% str
% 
% 
% EXAMPLE:
%   filePath = [pwd, filesep, 'saveStructure.xlsx'];
%   bodyStruct = struct;
%       bodyStruct.field1 = magic(5);
%       bodyStruct.field2.subfield21 = 'Hello World!';
%       bodyStruct.field2.subfield22 = pi;
%       bodyStruct.field2.subfield23 = magic(5);
%   headerStruct = struct;
%       headerStruct.title = 'Testing the saveStructure.m';
%       headerStruct.comment = {'DFC is perfect.'; 'Behold blessed perfection.'};
%   saveStructure(filePath,bodyStruct,headerStruct)
%   disp(['OUTPUT - filePath : ',filePath])
% 
% 
% Nagayama Daisuke, 2018

function saveStructure(filePath,bodyStruct,headerStruct,startCell,sheet,precision)
if nargin < 3
    headerStruct = struct;
end
if nargin < 4
    startCell = [1 1];
end
if nargin < 5
    sheet = 1;
end
if nargin < 6
    precision = 6;
end

bodyCell = struct2cell4excel(bodyStruct, precision);
if size(fieldnames(headerStruct)) ~= 0
    headerCell = struct2cell4excel(headerStruct, precision);
    headerCell{size(headerCell,1)+2, size(bodyCell,2)} = [];
end

cell4excel = [headerCell; bodyCell];

xlRange = xlsrange2(startCell, size(cell4excel));    % requires 'xlsrange.m' and 'xlscol.m'
xlswrite(filePath, cell4excel, sheet, xlRange)
% % The XLSWRITE function can not generate an Excel file on the Mac OS,
% % but instead saves the file in CSV (Comma Separated) format.

end