%INPUT: CC = result of BWconncomp()
%       siz = size of the movie ([x, y, t]);
%       save directory
%       save name
%output: Roots = cell array
%       column1 = number of roots in a frame, for every frame of avalanche
%       column2 = number of roots in the event
%       column3 = time at which root occured
%       columb4 = spatial profile of the root.

function roots = findNumberOfBWconncompRoots(CC,siz, rootdir, rootname)

if isfile(rootname)
    'roots exist, loading ...'
    roots = load(rootname); roots = roots.roots;
else
    'roots do not exist, generating ....'

%CC = bwconncomp(mov);

ll = cellfun(@length, CC.PixelIdxList);

for EventIdx = 1:CC.NumObjects


    %if an event has only 2 pixels there is no way to have more than 1
    %root.

    % if ll(EventIdx) == 1 || ll(EventIdx) == 2; TOTnumroots(EventIdx) =1;
   % else
    p = CC.PixelIdxList{EventIdx};


    %[x,y,z] = ind2sub(size(mov) , p);
    [x,y,z] = ind2sub(siz , p);

    zuq = unique(z);


    EventFrames = [];
    for t = 1:length(zuq)

        zidx = find(z == zuq(t));
        
        frame = zeros(siz([1 2]));
        pix = sub2ind(siz([1 2]), x(zidx), y(zidx));
        
        frame(pix) = 1;
        EventFrames(:,:,t) = frame;
    end

    se = offsetstrel('ball',6,6);

    numroots = [];
    roottime = [];
    rootprofile = {};
    if length(zuq) ~= 1;
    for t = length(zuq):-1:2
        numroots(t) = 0;
        roottime(t) = nan;
        rootprofile{t}= {};

        fr1 = EventFrames(:,:,t);
        fr2 = EventFrames(:,:,t-1);

        fr1 = imdilate(fr1,se); fr1 = fr1 - min(min(fr1));
        fr1(fr1 > 0) = 1;
        fr2 = imdilate(fr2,se); fr2 = fr2 - min(min(fr2));
        fr2(fr2 > 0) = 1;

        CC1 = bwconncomp(fr1);
        CC2 = bwconncomp(fr2);

        clear OLP
        for i = 1:CC1.NumObjects
            OLP = 0; %OLP serves as a count, if it sums to zero at the end of the j loop, it means there were no inters$            
            for j = 1:CC2.NumObjects
                OLP = length(intersect(CC1.PixelIdxList{i},CC2.PixelIdxList{j}))+OLP;
            end
            if OLP == 0;
                numroots(t) = numroots(t) +1;
                roottime(t) = zuq(t);
                rootprofile{t}{i} = CC1.PixelIdxList{i};
            end
        end
    end
    end

    %this is handles the first frame
    fr2 = EventFrames(:,:,1);
    fr2 = imdilate(fr2,se); fr2 = fr2 - min(min(fr2));
    fr2(fr2 > 0) = 1;
    CC2 = bwconncomp(fr2);
    numroots(1) = CC2.NumObjects;
    roottime(1) = zuq(1);
%
     for i = 1:numroots(1)
          rootprofile{1}{i} = CC2.PixelIdxList{i};
     end

    roots{EventIdx,1} = numroots;
    roots{EventIdx,2} = sum(numroots);
    roots{EventIdx,3} = roottime;
    roots{EventIdx,4} = rootprofile;
    end

end

