%get the shape of the avalnahce projected onto the XY place.
%input: CC: the bwconncomp object
%       sz: the size of the FOV
%output: the distribution of avalanche shapes. 

function avShape = getAvShapeFromBWconncomp(CC, sz)
    func = @(y) mod(y, prod(sz));
    avShape = cellfun(func, CC.PixelIdxList, 'UniformOutput', false );
    avShape = cellfun(@unique, avShape, 'UniformOutput', false );
    avSshape = cellfun(@length, avShape);
end
