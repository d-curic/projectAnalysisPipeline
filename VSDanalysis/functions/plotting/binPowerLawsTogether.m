
function [md, fq, bins] =  binPowerLawsTogether(data, nbins)
%data is a 1xN cell where N is the number of individual observations to be
%binned

xmax = max(cellfun(@max, data));
xmin = min(cellfun(@min, data));
bins = 10.^linspace(log10(xmin), log10(xmax), nbins);

for j = 1:length(data)
    for k = 1:length(bins)-1
        f(k) = length(find(data{j} > bins(k) & data{j} < bins(k+1)));
    end
    widths = diff(bins);
    fq(j,:) = f./widths/sum(f);
    
end
md = bins(1:end-1) + diff(bins)/2;


end