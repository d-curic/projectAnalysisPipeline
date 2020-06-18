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

volume = zeros(FOVsize(1), FOVsize(2), size(data,2));

for i = 1:length(validPixels)
   [xx yy] =  ind2sub(FOVsize, validPixels(i));
   volume(xx, yy, :) = data(i, :);
end


% func = @(x) ind2sub(FOVsize, x);
% 
% [xx2 yy2] = arrayfun(@(x) ind2sub(FOVsize, x), validPixels);
% 



end