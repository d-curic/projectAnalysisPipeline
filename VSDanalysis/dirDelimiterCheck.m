

function name = dirDelimiterCheck(name)

    if ~strcmp(name(end),'/') & ~strcmp(name(end),'\')
        name = [name '/'];
    end

end