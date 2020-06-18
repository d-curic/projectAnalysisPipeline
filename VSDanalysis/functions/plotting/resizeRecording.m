
function [resizedRecording, newValidPix] = resizeRecording(data, validPixels, scale, varargin)
%Resize a recording in space
%INPUT: data: matrix where the columns are frames and rows
%are the N<=128*128 individual pixels. Currently only set up for a 128 by 128 recording. 
%validPixels: indcies of the N pixels to be considered. 
%scale: scale by which we want to resize
%useParfor (optional): use cpu parallelization for faster computation

useParfor = false;
method = 'bilinear';

p = inputParser;
addRequired(p,'data');
addRequired(p,'validPixels');
addRequired(p,'scale');

addParameter(p,'useParfor',useParfor, @islogical);
addParameter(p,'method',method, @islogical);


parse(p,data,validPixels, scale,varargin{:});

useParfor = p.Results.useParfor;
method = p.Results.method;

OGsize = 128;
resizedRecording = zeros(OGsize*scale, OGsize*scale, size(data,2));


if ~useParfor
    for i = 1:size(data,2)
        frame = zeros(OGsize,OGsize);
        frame(validPixels) = data(:,i);
        resizedRecording(:,:,i) = imresize(frame, scale, method);
    end
else
    'using parfor!'
    parfor i = 1:size(data,2)
        frame = zeros(OGsize,OGsize);
        frame(validPixels) = data(:,i);
        resizedRecording(:,:,i) = imresize(frame, scale, method);
    end
    
end

newValidPix = find(abs(mean(resizedRecording,3)) > 0);

end
