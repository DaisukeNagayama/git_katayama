% hungarian algorithm
% 
% 
% Step 1:
%   Subtract the minimum value from each row and each column.
% 
% Step 2:
%   If you can select 0 from each row and each column one by one,
%   the position of 0 becomes the assignment plan.
% 
% Step 3:
%   Cover all zeros with as few vertical or horizontal lines as possible.
% 
% Step 4:
%   Subtract their minimum values from elements that are not erased by lines.
%   Then add that value to the element whose vertical and horizontal lines overlap.
%   Return to Step 2.
% 
% Nagayama Daisuke, 2018

function [zero_coordinate,cost] = hungarian(input_array)

array = input_array;

array = step1(array);

while true
    FLAG = false;
    [FLAG, zero_coordinate] = step2(array);
    
    if FLAG; break; end
    
    line = step3(array,zero_coordinate);
    mat = step4(array,line);
end

for iv = find(zero_coordinate)
    

    not(all(selected_row) && all(selected_col))
    check_row = false(1,NR);
    check_col = false(1,NC);
    selected_row = false(1,NR);
    selected_col = false(1,NC);
    
    zero_coordinate = array==0;
    
    % Step 3
    for i_row = 1:NR
        ROW = zero_coordinate(i_row,:);
        check_col(and(selected_col,ROW)) = true;
        if sum(ROW(not(selected_col))) == 1
            selected_col = or(selected_col,ROW);
        end
    end
    
    for i_col = 1:NC
        COL = zero_coordinate(:,i_col)';
        check_row(and(selected_row,COL)) = true;
        if sum(ROW(selected_col)) == 1
            selected_row = or(selected_row,COL);
        end
    end
    
    % Step 4
    remaining = array(selected_row,selected_col);
    remaining_min = min(min(remaining));
    array(selected_row,selected_col) = remaining - remaining_min;
    array(check_row,check_col) = array(check_row,check_col) + remaining_min; 
end

cost = sum(array(zero_coordinate));

end

% Step 1
function array = step1(array)
array = array - repmat(min(array,[],2),[1,NC]);
array = array - repmat(min(array,[],1),[NR,1]);
end

% Step 2
function [RESULT, zero_coordinate] = step2(array,row,col,zero_coordinate)
[NR,NC] = size(array);
if nargin==1
    row = 1:NR;
    col = 1:NC;
    zero_coordinate = false(NR,NC);
end

remained_array = array(row,col);

if (size(remained_array)==[1 1])
    if remained_array==1
        RESULT = true;  return
    else
        RESULT = false; return
    end
end

for iC = find(and(array(1,:),col))
    remained_row = row(2:end);
    remained_col = col(col ~= iC);
    [RESULT, zero_coordinate] = step2(array,remained_row,remained_col,zero_coordinate);
    if RESULT == true
        iR = sum(sum(zero_coordinate)) + 1;
        zero_coordinate(iR,iC) = true;
    end
end

end

% Step 3
function line = step3(array, zero_coordinate)

end

% Step 4
function mat = step4(array, line)

end


