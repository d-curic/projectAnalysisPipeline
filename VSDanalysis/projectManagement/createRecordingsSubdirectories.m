
function project = createRecordingsSubdirectories(project, recordings)
    projectdir = dirDelimiterCheck(project.location);
    
    for i = 1:length(recordings)
        project.recordings{i}.name = recordings{i}.name;
        project.recordings{i}.folder = recordings{i}.folder;
        project.recordings{i}.extention = recordings{i}.extension;
        project.recordings{i}.meta = struct;
        
        mkdir([projectdir '/recordings/'  project.recordings{i}.name '/'])
        mkdir([projectdir '/recordings/'  project.recordings{i}.name '/experiments/'])
        mkdir([projectdir '/recordings/'  project.recordings{i}.name '/originalData/'])
    end

end
