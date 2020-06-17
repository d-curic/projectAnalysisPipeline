projectpath = 'E:\newVSDpipeline\VSDanalysis\ADvsControl\';
projectname = 'ADvsControl2';
filename = [projectpath projectname];
project = loadProject(projectpath, [projectname '.proj']);
save([filename  '_backup.proj'], 'project', '-mat')

%%
project = findMasks(project);
project = findLFPs(project);

for i = 1:length(project.recordings)
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'FOVsize', [128 128]);
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'frameRateHz', 100);
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'dataMachineF', 'uint16');
    project.recordings{i}.meta = checkPrexistingFieldAndAdd(project.recordings{i}.meta, 'maskMachineF', 'uint8');
end

save([filename '.proj'], 'project', '-mat')

clearvars -except project


