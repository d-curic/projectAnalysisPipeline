

function name = extensionCheck(name)
%i think this just checks to see that the extenstion exists in the
%substring... Need to find where this is used...
    if ~strcmp(name(1),'.')
        name = ['.' name];
    end

end