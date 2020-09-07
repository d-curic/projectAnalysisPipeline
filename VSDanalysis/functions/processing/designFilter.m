function hpFilt = designFilter(exp, filterdir)

close all
samplerate = exp.FR;
order = exp.filterorder;
bandstart = exp.filtparams(1);
bandend = exp.filtparams(2);

switch exp.band
    case 'BP'
    hpFilt = designfilt('bandpassfir','FilterOrder',order, ...
          'CutoffFrequency1',bandstart,'CutoffFrequency2',bandend, ...
          'SampleRate',samplerate);
    filtername = ['Filter_FIR_' exp.band '_' num2str(exp.filtparams(1)) '_' num2str(exp.filtparams(2)) '_' num2str(exp.FR) 'Hz_order' num2str(exp.filterorder)];  
    case 'HP'  
%     hpFilt = designfilt('highpassfir','StopbandFrequency',0.45, ...
%           'PassbandFrequency',0.5,'PassbandRipple',0.5, ...
%           'StopbandAttenuation',65,'DesignMethod','kaiserwin','SampleRate',100);
    case 'LP' 
        'not yet implemented'
    case 'BS'
        'not yet implemented'
    otherwise
        'valid filter bands are BP, HP, LP, BS'
end

checkifDirExists(filterdir);
save([filterdir filtername '.mat'], 'hpFilt')
['filter saved as ' [filterdir filtername '.mat']]
% fvtool(hpFilt)
% 
% plot(hpFilt.Coefficients)
% hold on
% plot(FilterFIR056100Hzorder1,'--')



end