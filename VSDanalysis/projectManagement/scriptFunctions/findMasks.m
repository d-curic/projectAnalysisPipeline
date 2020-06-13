function project = findMasks(project)

for i = 1:length(project.recordings)
    recordingLocation = dirDelimiterCheck(project.recordings{i}.folder);
    project.recordings{i}.ExtrasDirectory = getSubDirectory(recordingLocation, 'Extra');
    [project.recordings{i}.maskLocation, project.recordingsWithMasks(i)] = autofindMask(project.recordings{i}.ExtrasDirectory);
end

end