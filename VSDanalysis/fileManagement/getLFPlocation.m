function [LFPlocation, found] = getLFPlocation(ExtraDir, identifier)
ExtraDir = dirDelimiterCheck(ExtraDir);
found = false;
if isfolder([ExtraDir 'LFP/'])
    
    S = dir([ExtraDir 'LFP/']);
    N = {S.name};
    
    X = contains(N,[identifier '.abf'], 'IgnoreCase', true);
    
    if sum(X) == 1;
        LFPlocation = N(X);
        LFPlocation = LFPlocation{1};
        LFPlocation = [ExtraDir LFPlocation];
        found = true;
    elseif sum(X) > 1;
        LFPlocation = 'More than one LFP found';
    else
        LFPlocation = 'LFP DNE';
    end
    
else
    LFPlocation = 'LFP directory not found'
end

end

