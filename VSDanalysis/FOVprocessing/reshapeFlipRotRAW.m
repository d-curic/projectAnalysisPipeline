
function data = reshapeFlipRotRAW(data, sz)
%reshape the raw file
%when matlab reads a raw file it typically gets the orientation wrong. Here
%we will correct that

X = sz(1);
Y = sz(2);
if length(sz) == 3
    Z = sz(3);
    data = reshape(data, X,Y,[]);
elseif length(sz) == 2
    data = reshape(data, X, Y);
end

data = flipud(data);
data = rot90(data, -1);


end