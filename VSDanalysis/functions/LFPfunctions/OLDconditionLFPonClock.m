function lfpSignalDuringVSDcapture = conditionLFPonClock(clock, LFP, trialPeriod)

vsdCaptureTimes = clock;
vsdCaptureTimes = vsdCaptureTimes.*trialPeriod;
m = mean(clock);%max(vsdCaptureTimes);

vsdCaptureTimes(vsdCaptureTimes < m) = 0;
vsdCaptureTimes(vsdCaptureTimes ~= 0) = 1;

lfpSignalDuringVSDcapture = LFP.*vsdCaptureTimes;
%plot(lfpSignalDuringVSDcapture)
lfpSignalDuringVSDcapture = segmentSeries(lfpSignalDuringVSDcapture');
lfpSignalDuringVSDcapture = cellfun(@sum, lfpSignalDuringVSDcapture);
%lfpSignalDuringVSDcapture = cellfun(@(v)v(1), lfpSignalDuringVSDcapture);
lfpSignalDuringVSDcapture(lfpSignalDuringVSDcapture == 0) = [];

end
