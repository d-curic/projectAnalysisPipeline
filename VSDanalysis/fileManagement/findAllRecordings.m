function fileStructure = findAllRecordings(rootfolder, fileExt, varargin)
%Purpose: find all of the files within a root folder
%input: (Required): rootfolder: the folder which in which we will search
%all subdirectories
%output: a cellfile where each cell is a strcuture containing the directory
%and the files within that directory with the appropriate extension
%of rootfolder and a list of all the new

p = inputParser;
addRequired(p,'rootfolder', @ischar);
addRequired(p,'fileExt', @ischar);
parse(p,rootfolder, fileExt, varargin{:});

rootfolder = dirDelimiterCheck(rootfolder);

S = dir(fullfile(rootfolder, ['**\*' fileExt]));
names = {S.name};
folders = {S.folder};
uniqueFolders = unique(folders);

for i = 1:6
   uniqueFolders{i} 
end

fileStructure = {};

for i = 1:length(uniqueFolders)
    idx = find(strcmp(folders, uniqueFolders{i})==1);
    for j = 1:length(idx)
        files{j} = [names{idx(j)}];
    end
    
    fileStructure{i}.folder = dirDelimiterCheck(uniqueFolders{i});
    fileStructure{i}.files = files;
    
    
end
end