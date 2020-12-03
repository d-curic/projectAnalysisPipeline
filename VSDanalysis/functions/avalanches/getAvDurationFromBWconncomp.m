%get the durration of the avalnahces
%input: CC: the bwconncomp object
%       sz: the size of the FOV
%output: the distribution of avalanche durations.


function avDurr = getAvDurationFromBWconncomp(CC, sz)

divfun = @(y) floor(y/(prod(sz)));

avStart = cellfun(@min, CC.PixelIdxList);
avStart = arrayfun(divfun, avStart);
avEnd = cellfun(@max, CC.PixelIdxList);
avEnd = arrayfun(divfun, avEnd);
avDurr = avEnd - avStart+1;
end
