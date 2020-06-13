function rawdata = openBinaryFile(filename, dataType, varargin)
%PURPOSE: open a .RAW file
%input: (Required) name of file
%       (Required) dataType: eg uint16
%       (optional) 'endian': 'ieee-le' or 'ieee-be' for little or big
%       endian respectivly. Default = 'ieee-be';

defaultEndian = 'ieee-be';

p = inputParser;
addRequired(p,'filename');
addRequired(p,'dataType', @ischar);
addParameter(p,'endian',defaultEndian,@ischar);
parse(p,filename,dataType,varargin{:});

defaultEndian = p.Results.endian;


[fid, messg] = fopen(filename);
if fid == -1
  error(messg);
end
rawdata = fread(fid, inf, ['*' dataType], defaultEndian);



fclose(fid);
end