

function name = extensionCheck(name)

    if ~strcmp(name(1),'.')
        name = ['.' name];
    end

end