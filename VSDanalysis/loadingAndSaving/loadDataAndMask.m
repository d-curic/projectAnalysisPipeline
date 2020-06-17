
function [data, mask] = loadDataAndMask(recordingStructure)

sz = recordingStructure.meta.FOVsize;
maskMachineF = recordingStructure.meta.maskMachineF;
dataMachineF = recordingStructure.meta.dataMachineF;

mask = openBinaryFile(recordingStructure.maskLocation, maskMachineF);
mask = reshapeFlipRotRAW(mask, sz);

recordingName = recordingStructure.folder;
recordingName = dirDelimiterCheck(recordingName);
recordingName = [recordingName recordingStructure.name recordingStructure.extension];

data = openBinaryFile(recordingName, dataMachineF);
data = reshapeFlipRotRAW(data, [sz 1]); %the one is a bit of a hack just to tell the function it should be a 3d array, it is not actually used and can be any value

end