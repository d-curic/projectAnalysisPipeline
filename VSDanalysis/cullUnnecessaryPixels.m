

ridx = 1;


%%
trimmedData = applyMask(data, mask);
[xx yy] = findSmallestBox(mask);
trimmedData = trimmedData(xx, yy, :);
trimmedMask = single(mask(xx,yy));

recordingData{ridx}.meta.Size = size(trimmedData);
recordingData{ridx}.meta.DataMachineF = class(trimmedData);
recordingData{ridx}.meta.MaskMachineF = class(trimmedMask);
recordingData{ridx}.meta.validPixelIdx = find(trimmedMask > 0);
recordingData{ridx}.meta.culledUnnecessaryPixels = true;

function [data, mask] = loadDataAndMask(recordingStructure)

sz = recordingStructure.

mask = openBinaryFile(recordingStructure.maskLocation, 'uint8');
mask = reshapeFlipRotRAW(mask, [128 128]);

recordingName = recordingStructure.folder;
recordingName = dirDelimiterCheck(recordingName);
recordingName = [recordingName recordingStructure.name];

data = openBinaryFile(recordingName, 'uint16');
data = reshapeFlipRotRAW(data, [128 128 90000]);

end