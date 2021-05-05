
function plotPowerLawsWithErrorbars(md, data, errbarptile, varargin)
    %data is Nxnbins where N is the number of individual binned powerlaws and
    %nbins is the number of bins used to make the binning
    %md is the middle of the powerlaw histograms
    %errbbarptile is the percentile used to make the errorbars
    %example use:
    %given avalanche stats stored in X (1 x N cell)
    %[md, data] =  binPowerLawsTogether(X, nbins)
    %plotPowerLawsWithErrorbars(md, data, errbarptile)
    
    clr = ColorList(1);
    lw = 1.5;
    falpha = 0.25;
    ealpha = 0.25;
    
    p = inputParser;
    addRequired(p,'md');
    addRequired(p,'data');
    addRequired(p,'errbarptile');
    
    addParameter(p,'color',clr);%,@ischar | @isnumeric);
    addParameter(p,'facealpha',falpha);
    addParameter(p,'edgealpha',ealpha);
    addParameter(p,'LineWidth',lw);
    
    
    tfq = prctile(data, errbarptile);
    bfq = prctile(data, 100 - errbarptile);
    fq = mean(data);
    idx = find(tfq == 0); tfq(idx) = []; bfq(idx) = []; md(idx) = []; fq(idx) = [];
    idx = find(bfq == 0); tfq(idx) = []; bfq(idx) = []; md(idx) = []; fq(idx) = [];
    loglog(md, fq, 'LineWidth', lw, 'color', clr)
    hold on
    fillBetweenCurves(md, tfq, bfq, 'color', clr, 'facealpha', falpha, 'edgealpha', ealpha)


end