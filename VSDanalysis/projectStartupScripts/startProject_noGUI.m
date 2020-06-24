pathtoDir = 'E:\newVSDpipeline\VSDanalysis_noGUI';
projectname = 'testproject';
originalRecordingsRootFolder = 'E:\PhD\allADvsCtrl';

%% create project locations and fetch recording names

project = createProject(pathtoDir, projectname);
recordings = findRecordings(originalRecordingsRootFolder, 'cullFlag', 'mask');
project = createRecordingsSubdirectories(project, recordings);


%% masks and LFPs

project = findMasks(project);
project = findLFPs(project);

for i = 1:length(project.recordings)
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'FOVsize', [128 128]);
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'frameRateHz', 100);
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'dataMachineF', 'uint16');
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'maskMachineF', 'uint8');
end
%% create experiment

expname = 'testexp';



%create the experiment in a field
if isfield(project, 'experiments')
    experiment = struct;
    experiment.name = expname;
    experiment.recordingIds = 1:length(project.recordings);
    project.experiments = setfield(project.experiments, expname, experiment);
else
    project = setfield(project, 'experiments', struct);
    experiment = struct;
    experiment.name = expname;
    experiment.recordingIds = 1:length(project.recordings);
    project.experiments = setfield(project.experiments, expname, experiment);
end

%create an experiment subdirectory in each recording directory
projdir = dirDelimiterCheck(project.location);
for i = 1:length(project.recordings)
    expdir = [projdir 'recordings/' project.recordings{i}.name '/experiments/' ];
    if ~isdir([expdir '/' expname '/'])
        [expdir '/' expname '/' ' is already a directory']
        mkdir([expdir '/' expname '/'])
    end
end

if ~isdir([dirDelimiterCheck(project.location) 'experiments/' expname '/'])
    mkdir([dirDelimiterCheck(project.location) 'experiments/' expname '/'])
end
if ~isdir([dirDelimiterCheck(project.location) 'experiments/' expname '/scripts/'])
    mkdir([dirDelimiterCheck(project.location) 'experiments/' expname '/scripts/'])
end

%%

filename = [pathtoDir projectname];

save([filename '.proj'], 'project', '-mat')

clearvars -except project