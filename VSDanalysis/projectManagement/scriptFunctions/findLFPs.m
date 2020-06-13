function project = findLFPs(project)

for i = 1:length(project.recordings)
    recordingLocation = dirDelimiterCheck(project.recordings{i}.folder);
    project.recordings{i}.ExtrasDirectory = getSubDirectory(recordingLocation, 'Extra');

    name = project.recordings{i}.name;
    lfpid = ['00' name(1:2)];
    [project.recordings{i}.LFP, project.recordingsWithLFPs(i)] = getLFPlocation(project.recordings{i}.ExtrasDirectory, lfpid);
    
end
end