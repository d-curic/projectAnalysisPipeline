<<<<<<< HEAD
function adj = latticeAdjMat(N, conn)
%get the adjacency matrix of a 2d NxN lattice.
%code taken from https://stackoverflow.com/questions/3277541/construct-adjacency-matrix-in-matlab
% conn is the connectivity (4 neighbours or 8 neighbours)

if conn == 8
r = N;% Get the matrix size
diagVec1 = repmat([ones(N-1, 1); 0], r, 1);  % Make the first diagonal vector
                                             %   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);                % Remove the last value
diagVec2 = [0; diagVec1(1:(N*(r-1)))];       % Make the second diagonal vector
                                             %   (for anti-diagonal connections)
diagVec3 = ones(N*(r-1), 1);                 % Make the third diagonal vector
                                             %   (for vertical connections)
diagVec4 = diagVec2(2:end-1);                % Make the fourth diagonal vector
                                             %   (for diagonal connections)
adj = diag(diagVec1, 1)+...                  % Add the diagonals to a zero matrix
      diag(diagVec2, N-1)+...
      diag(diagVec3, N)+...
      diag(diagVec4, N+1);
adj = adj+adj.';                             % Add the matrix to a transposed copy of
                                             %   itself to make it symmetric
elseif conn == 4
                   % Sample matrix
r = N;                          % Get the matrix size
diagVec1 = repmat([ones(N-1, 1); 0], r, 1);  % Make the first diagonal vector
                                             %   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);                % Remove the last value
diagVec2 = ones(N*(r-1), 1);                 % Make the second diagonal vector
                                             %   (for vertical connections)
adj = diag(diagVec1, 1)+diag(diagVec2, N);   % Add the diagonals to a zero matrix
adj = adj+adj.';                             % Add the matrix to a transposed copy of
                                             %   itself to make it symmetric
end
end
=======
function adj = latticeAdjMat(N, conn)
%get the adjacency matrix of a 2d NxN lattice.
%code taken from https://stackoverflow.com/questions/3277541/construct-adjacency-matrix-in-matlab
% conn is the connectivity (4 neighbours or 8 neighbours)

if conn == 8
r = N;% Get the matrix size
diagVec1 = repmat([ones(N-1, 1); 0], r, 1);  % Make the first diagonal vector
                                             %   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);                % Remove the last value
diagVec2 = [0; diagVec1(1:(N*(r-1)))];       % Make the second diagonal vector
                                             %   (for anti-diagonal connections)
diagVec3 = ones(N*(r-1), 1);                 % Make the third diagonal vector
                                             %   (for vertical connections)
diagVec4 = diagVec2(2:end-1);                % Make the fourth diagonal vector
                                             %   (for diagonal connections)
adj = diag(diagVec1, 1)+...                  % Add the diagonals to a zero matrix
      diag(diagVec2, N-1)+...
      diag(diagVec3, N)+...
      diag(diagVec4, N+1);
adj = adj+adj.';                             % Add the matrix to a transposed copy of
                                             %   itself to make it symmetric
elseif conn == 4
                   % Sample matrix
r = N;                          % Get the matrix size
diagVec1 = repmat([ones(N-1, 1); 0], r, 1);  % Make the first diagonal vector
                                             %   (for horizontal connections)
diagVec1 = diagVec1(1:end-1);                % Remove the last value
diagVec2 = ones(N*(r-1), 1);                 % Make the second diagonal vector
                                             %   (for vertical connections)
adj = diag(diagVec1, 1)+diag(diagVec2, N);   % Add the diagonals to a zero matrix
adj = adj+adj.';                             % Add the matrix to a transposed copy of
                                             %   itself to make it symmetric
end
end
>>>>>>> 9e5192aed4193bb352db99b5646de355cb5aec1b
