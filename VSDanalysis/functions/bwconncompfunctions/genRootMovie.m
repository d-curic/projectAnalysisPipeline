
function rootMovie = genRootMovie(roots, mov, exp)

"Generating RootMovie"
times = ([roots{:,3}]);
rootprofile = {roots{:,4}};
rootprofile =  rootprofile(~cellfun('isempty',rootprofile));
rootprofile = [rootprofile{:}];

for tval = 1:max(times);
tidx = find(times == tval);
Tframe = zeros(exp.size(1:2));
for t=tidx
    frame = zeros(exp.size(1:2));
    for i = 1:length(rootprofile{t})
        frame(rootprofile{t}{i}) = 1;
    end
   % imagesc(frame)
   % drawnow
   % title(num2str(t))
    %pause(0.5)

    Tframe = frame + Tframe;

end
Tframe(Tframe > 1) = 1;
frameRoot = (mov(:,:,tval) + Tframe);
frameRoot(frameRoot < 2) = 0;
frameRoot(frameRoot ~=0 ) = 1;
rootMovie(:,:,tval) = frameRoot;
end
end