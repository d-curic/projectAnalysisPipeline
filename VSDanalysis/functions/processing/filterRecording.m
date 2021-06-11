function filteredIntensities =  filterRecording(data, filt, varargin)


useGPU = false;

p = inputParser;
addRequired(p,'data');
addRequired(p,'framerate');
addParameter(p,'useGPU',useGPU,@islogical);
parse(p,data,filt,varargin{:});

useGPU = p.Results.useGPU;


camera_srate = filt.FR;
  
NonZeroPixelsIndex = 1:size(data(:,1));%find(ones(1,rows*columns));
nFrames = size(data,2);
X = data;
X = X';
X = single(X);

%%




% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % tic

'performing SVD ...'


if useGPU
X = gpuArray(X);
end
[U, S, V] = svd(X(:,NonZeroPixelsIndex),0);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%% Deharmonization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % U_noharm = rmlinesc(U(:,1:M),params);
% %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% reconstruction of data matrix using first M eigenvectors %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear X
'Reconstructing from SVD ... '
M =50;
Xrecon = U(:,1:M) * S(1:M,1:M) * V(:,1:M)';
clear U S V X img_stk

if useGPU
Xrecon = gather(Xrecon);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Detrending %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Xrecon orginal (reconstructed signal after PCA/SVD)
%dXrecon is orginal minus the trend
'detrending .... '

dXrecon = locdetrend(Xrecon,camera_srate,[2 1]);


dXrecon_dff0 = single(zeros(nFrames,length(NonZeroPixelsIndex)));

dXrecon_dff0(:,NonZeroPixelsIndex) = 100 * dXrecon./(Xrecon-dXrecon);

% dXrecon_dff0 = single(dXrecon_dff0);
% figure; plot(mean(dXrecon_dff0(:,NonZeroPixelsIndex),2)); grid on
clear dXrecon Xrecon



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Filtering %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'FT filtering ... '
tic()
filter_coefficients = load(filt.coefffile);
% filter_coefficients = load('Filter_FIR_InverseSincLowPass_Fc6Hz_Fs20Hz_order5.txt');
dXrecon_dff0_filtered = zeros(nFrames, length(NonZeroPixelsIndex));
for ii = 1:size(dXrecon_dff0,2)
     if ~all(dXrecon_dff0(:,ii) == 0)
%       X_filtered(:,ii) = filtfilt(sos,g,X(:,ii));
%       X_filtered(:,ii) = filtfilt(filter_coefficients,1,X(:,ii));  
        

        %dXrecon_dff0_filtered(:,ii) = filtfilt(filter_coefficients,1,double(dXrecon_dff0(:,ii)));
        dXrecon_dff0_filtered(:,ii) = filter(filter_coefficients.hpFilt,double(dXrecon_dff0(:,ii)));

     
     end  
end
toc()
dXrecon_dff0_filtered = single(dXrecon_dff0_filtered);
clear dXrecon_dff0

size(dXrecon_dff0_filtered,1)
filteredIntensities = dXrecon_dff0_filtered';%reshape( dXrecon_dff0_filtered',rows,columns,size(dXrecon_dff0_filtered,1));%.*single(exp.mask);

%end


end