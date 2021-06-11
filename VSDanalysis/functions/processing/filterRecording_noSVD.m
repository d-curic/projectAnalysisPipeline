function filteredData =  filterRecording(data, filt, varargin)


useGPU = false;

p = inputParser;
addRequired(p,'data');
addRequired(p,'framerate');
addParameter(p,'useGPU',useGPU,@islogical);
parse(p,data,filt,varargin{:});

useGPU = p.Results.useGPU;


camera_srate = filt.FR;
  
NonZeroPixelsIndex = 1:size(data(:,1));%find(ones(1,rows*columns));
nFrames = size(data,2);
X = data;
X = X';
X = single(X);


filter_coefficients = load(filt.coefffile);
 filteredData = filter(filter_coefficients.hpFilt,double(X));

 

end