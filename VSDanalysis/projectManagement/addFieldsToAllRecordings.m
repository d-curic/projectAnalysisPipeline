projectfile = 'E:\newVSDpipeline\ADvsControl\ADvsControl.proj';
load(projectfile, '-mat');

project = findMasks(project);
project = findLFPs(project);

for i = 1:length(project.recordings)
    project.recordings{i} = checkPrexistingFieldAndAdd(project.recordings{i}, 'FOVsize', [128 128]);
    project.recordings{i} = checkPrexistingFieldAndAdd(project.recordings{i}, 'frameRateHz', 100);
    project.recordings{i} = checkPrexistingFieldAndAdd(project.recordings{i}, 'dataMachineF', 'uint16');
    project.recordings{i} = checkPrexistingFieldAndAdd(project.recordings{i}, 'maskMachineF', 'uint8');
end




