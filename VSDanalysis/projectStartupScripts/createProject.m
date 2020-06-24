
function project = createProject(pathtoDir, projectname)

mkdir([dirDelimiterCheck(pathtoDir) projectname '/'])

project.name = projectname;
project.location = [dirDelimiterCheck(pathtoDir) projectname '/'];

save([project.location project.name '.proj'], '-mat')

end