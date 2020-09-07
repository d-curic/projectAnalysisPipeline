function exp = checkifCoefficientsExist(exp, project)

'wARNING: THIS HASNT BEEN TESTED WITH / \ TOGETHER BE CAREFUL WHEN SWITCHING TO LINUX'

parser1 = strfind(project.location, '\'); 
parser2 = strfind(project.location, '/'); 
parser = sort([parser1 parser2]);
parser = parser(end -1);
parentdir = project.location(1:parser);
parentdir = dirDelimiterCheck(parentdir);
processingLocation = [parentdir 'functions\processing\'];
filterdir = [processingLocation 'filterCoefficients\']


switch exp.band
    case 'BP'
    filtername = ['Filter_FIR_' exp.band '_' num2str(exp.filtparams(1)) '_' num2str(exp.filtparams(2)) '_' num2str(exp.FR) 'Hz_order' num2str(exp.filterorder)];
    case 'HP'
        'not yet implemented'
    case 'LP' 
        'not yet implemented'
    case 'BS'
        'not yet implemented'
    otherwise
        'valid filter bands are BP, HP, LP, BS'
end


if exist([filterdir filtername '.mat'], 'file') == 2
     'coefficients exist'
     exp.coefffile = [filterdir filtername '.mat'];
else
     'coefficients do not exist, generating .... '
     designFilter(exp, filterdir);
     exp.coefffile = [filterdir filtername '.mat'];
end

    

end
