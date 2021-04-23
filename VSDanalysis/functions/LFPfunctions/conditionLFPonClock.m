function cLFP = newConditionLFPonClock(d) 

%first fine where the VSD trial period is
trialP = d(:,3);
th = (max(trialP) + min(trialP))/2;
trialP(trialP< th) = 0;
trialP(trialP~=0) = 1;
trialP = find(trialP == 1);

%get the LFP and clock during the trial period
cLFP = d(:,1);
cLFP = cLFP(trialP);
clock = d(:,2);
clock = clock(trialP);

%find when VSD frames are being aquired.
th = (max(clock) + min(clock))/2;
clock(clock < th) = 0;
clock(clock ~= 0) = 1;

%method 1
% offSet = max(cLFP) + 1;
% cLFP = cLFP - abs(offSet);
% cLFP = cLFP.*clock;
% 
% S = segmentSeries(cLFP');
% cLFP = cellfun(@(x) mean(x), S(2:2:end));
% 
% cLFP = cLFP + offSet;


%method 2
nzidx = (1:length(clock)).*clock';
S = segmentSeries(nzidx);
c = cellfun(@(x) cLFP(x), S(2:2:end), 'UniformOutput', false);
cLFP = cellfun(@(x) mean(x), c);

end