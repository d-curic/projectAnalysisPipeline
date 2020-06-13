
function maskedData = applyMask(data, mask)

data = single(data);
mask = single(mask);

if max(max(mask)) == 255;
    mask(mask == 255) = 1;
end

ogDataSize = size(data);

data = reshape(data, size(data,1)*size(data,2), []);
mask = reshape(mask, size(mask,1)*size(mask,2),1);

maskedData = mask.*data;

maskedData = reshape(maskedData, ogDataSize(1), ogDataSize(2), []);

end