
function project = loadProject(projectpath, projectname)

projectpath = dirDelimiterCheck(projectpath);
filename = [projectpath projectname];

load(filename, '-mat')

if ~strcmp(project.location, projectpath)
    'the project directory is not the same as the directory in file'
    'adding old directory as a project field for backup'
    
    project.oldlocation = project.location;
    project.location = projectpath;

    save(filename, 'project', '-mat')
end

'done!'

clearvars -except project
end