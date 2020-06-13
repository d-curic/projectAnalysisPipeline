
function [xidx, yidx] = findSmallestBox(mask)
    maskY = sum(mask,1);
    maskX = sum(mask,2);

    xidx = find(maskX > 0);
    yidx = find(maskY > 0);
    
end
