function [di ni] = PPLdata(X,Nd)
dmax = max(X);
logdi = (0:Nd) * log(dmax) / Nd;
di    = unique(round(exp(logdi)));

for i = 1:length(di)-1
    di(i)
    ni(i) = length(find(X>=di(i) & X< di(i+1)))/((di(i+1) - di(i)));
end
di = di(1:end-1);
ni = ni/length(X);
%logni = alpha * (log(dmax) - log(di));
%ni    = round(exp(logni));
end