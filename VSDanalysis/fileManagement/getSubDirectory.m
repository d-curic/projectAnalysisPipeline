function ExtraDirPath = getSubDirectory(path, sub)

path = dirDelimiterCheck(path);

ExtraDirPath = [path sub];
ExtraDirPath = dirDelimiterCheck(ExtraDirPath);

if ~isdir(ExtraDirPath); 
     ExtraDirPath = 'WARNING!!! Sub directory not found!';
end
 
end