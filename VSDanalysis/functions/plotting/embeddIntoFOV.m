function volume = embeddIntoFOV(data, validPixels, FOVsize, varargin)


useParfor = false;
method = 'bilinear';

p = inputParser;
addRequired(p,'data');
addRequired(p,'validPixels');
addRequired(p,'FOVsize');

addParameter(p,'useParfor',useParfor, @islogical);

parse(p,data,validPixels, FOVsize,varargin{:});

useParfor = p.Results.useParfor;

%parfor does not work yet!
if useParfor
    volume = zeros(FOVsize(1)*FOVsize(2), size(data,2));
    'WARNING PARFOR DOES NOT WORK YET!'
    tic()
    parfor i = 1:size(volume,1)%length(validPixels)
        if ismember(i, validPixels)
            volume(i) = data(i,:);
        end
    end
else
    
    volume = zeros(FOVsize(1), FOVsize(2), size(data,2));
    for i = 1:length(validPixels)
        [xx yy] =  ind2sub(FOVsize, validPixels(i));
        volume(xx, yy, :) = data(i, :);
    end
end



end