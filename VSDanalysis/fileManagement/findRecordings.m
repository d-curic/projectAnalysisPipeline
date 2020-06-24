
function recordings = findRecordings(rootfolder, varargin)

%any file containing the substring cullany will be removed. Ideally this
%would be a cell so that I can accept multiple strings 
cullany = '';
ignoreCase = true;

p = inputParser;
addRequired(p,'rootfolder', @ischar);
addParameter(p,'cullFlag',cullany,@ischar);
addParameter(p,'ignoreCase',ignoreCase,@islogical);
parse(p,rootfolder,varargin{:});

cullany = p.Results.cullFlag;
ignoreCase = p.Results.ignoreCase;

rootfolder = dirDelimiterCheck(rootfolder);
S = dir(fullfile(rootfolder, ['**/*' '.raw']));
names = {S.name};
folders = {S.folder};

count = 1;
for i = 1:length(names)
    if ~strcmp(cullany, '') & contains(names{i}, cullany, 'IgnoreCase', ignoreCase); continue; end
    recordings{count}.folder = dirDelimiterCheck(folders{i});
    recordings{count}.name = names{i}(1:end-4);
    recordings{count}.extension = names{i}(end-3:end);
    count = count + 1;
end



end