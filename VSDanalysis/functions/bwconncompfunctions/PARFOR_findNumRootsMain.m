%INPUT: CC = result of BWconncomp()
%       siz = size of the movie ([x, y, t]);
%       save directory
%       save name
%output: Roots = cell array
%       column1 = number of roots in a frame, for every frame of avalanche
%       column2 = number of roots in the event
%       column3 = time at which root occured
%       columb4 = spatial profile of the root.

function R = PARFOR_findNumRootsMain(CC,siz, rootdir, rootname, params)

if isfile(rootname)
    'roots exist, loading ...'
    roots = load(rootname); roots = roots.roots;
else
    'roots do not exist, generating ....'


    volumes = cellfun(@length,CC.PixelIdxList);
    durations = getAvDurationFromBWconncomp(CC, siz([1 2]));
    sizes = getAvShapeFromBWconncomp(CC, siz([1 2]));
    
    parfor EventIdx = 1:CC.NumObjects

    p = CC.PixelIdxList{EventIdx};
        
        
    
    [rootsPerFrame, numroots, roottime, rootprofile] = findNumRootsOfSingleCluster(p, siz, params );
    
%     roots{EventIdx}{1} = rootsPerFrame;
%     roots{EventIdx}{2} = numroots;
%     roots{EventIdx}{3} = roottime;
%     roots{EventIdx}{4} = rootprofile;
%         
    roots1{EventIdx} = rootsPerFrame;
    roots2{EventIdx} = numroots;
    roots3{EventIdx} = roottime;
    roots4{EventIdx} = rootprofile;    
    roots5{EventIdx} = volumes(EventIdx);
    roots6{EventIdx} = durations(EventIdx);
    roots7{EventIdx} = sizes(EventIdx);
    
    end
    

  
    R = {roots1{:};roots2{:};roots3{:};roots4{:}; roots5{:}; roots6{:}; roots7{:}};
    R = R';
    
end

