
function [mask found] = autofindMask(directory)

directory = dirDelimiterCheck(directory);
S = dir(directory);
N = {S.name};
X = contains(N,'mask_', 'IgnoreCase', true);
found = false;

if sum(X) == 1;
    mask = N(X);
    mask = mask{1};
    if isfile([directory mask]);
        mask = [directory mask];
        found = true;
    else
       'mask file found but directory is potentially wrong. Make sure directory is the /path/to/Extra/ '
    end
    
elseif sum(X) > 1;
    mask = 'More than one mask found';
else
    mask = 'no mask found';
end

end
