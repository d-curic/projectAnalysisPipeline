

function [gamma, dgamma, fitrange, dd] =  getGammaRobustFit(X, Y, xmin, xmax, dmin, dmax)

idx = find((X < xmin)| (X > xmax));
X(idx) = [];
Y(idx) = [];
% idx = find(Y < dmin | Y > dmax);
% X(idx) = [];
% Y(idx) = [];

if length(X) ~= 0
    
    xx = X; yy = Y;
    
    [md, fq] = lnbin(xx, 30);
    clear dd
    for kk = 1:length(md)-1
        idx = find(xx > md(kk) & xx < md(kk+1));
        dd(kk) = mean(yy(idx));
    end
    
    fitrange = md(1:end-1);
    idx = find(fitrange > xmin & fitrange < xmax);
    fitrange = fitrange(idx);
    dd = dd(idx);
    [b stats] = robustfit(log(fitrange),log(dd));
    gamma = b(2);
    dgamma = stats.s;
    
else
    
    gamma = nan;
    dgamma = nan;
    
end

end
