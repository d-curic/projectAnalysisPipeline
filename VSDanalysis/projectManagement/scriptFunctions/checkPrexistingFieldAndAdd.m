

function project = checkPrexistingFieldAndAdd(project, field, value, varargin)
    %take in a structure
    %check to see if the field exists, if so do nothing
    %if field does not exist, OR field exists but override is set to true,
    %then add in the field and give it the value 'value'

    defaultOverride = false;

    p = inputParser;
    addRequired(p,'project', @isstruct);
    addRequired(p,'field', @ischar);
    addRequired(p,'value');
    addParameter(p,'override',defaultOverride,@islogical);
    parse(p,project, field, value ,varargin{:});

    defaultOverride = p.Results.override;
    
    if isfield(project, field) & ~defaultOverride 
       'this is already a field'
    else
        if isfield(project, field) & defaultOverride
           'overriding pre-existing field'
       end
       
       project = setfield(project, field, value);
    end


end
