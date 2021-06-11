

function BandRatio = getWaveletBandRatio(x, lowband, highband, framerate, varargin)



useGPU = false;

p = inputParser;
addRequired(p,'x');
addRequired(p,'band1');
addRequired(p,'band2');
addRequired(p,'framerate');

addParameter(p,'useGPU',useGPU,@islogical);

parse(p,x, lowband, highband, framerate,varargin{:});

useGPU = p.Results.useGPU;




if useGPU
    x = gpuArray(x);
end


[wt, f] = cwt(x, framerate);

lowidx = find(f <= lowband(2) & f >= lowband(1));
highidx = find(f <= highband(2) & f >= highband(1));

totalPower = sum(abs(wt).^2);

low = sum(abs(wt(lowidx,:)).^2)./totalPower;
high = sum(abs(wt(highidx,:)).^2)./totalPower;

BandRatio = high./low;
if useGPU
   BandRatio = gather(BandRatio); 
end

end
