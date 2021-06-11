

function totalPower = getWaveletTotalPower(x, framerate, varargin)



useGPU = false;

p = inputParser;
addRequired(p,'x');
addRequired(p,'framerate');

addParameter(p,'useGPU',useGPU,@islogical);

parse(p,x, framerate,varargin{:});

useGPU = p.Results.useGPU;




if useGPU
    x = gpuArray(x);
end


wt = cwt(x, framerate);

totalPower = sum(abs(wt).^2);


end
