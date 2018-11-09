function range = xlsrange2(startCell, writingSize)
% constucts a range in excel syntax from row and column numbers
%
% requires 'xlsrange.m' and 'xlscol.m'

row1 = startCell(1);
col1 = startCell(2);
row2 = row1 + writingSize(1) - 1;
col2 = col1 + writingSize(2) - 1;

range = xlsrange(row1, col1, row2, col2);

end
