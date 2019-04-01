% Convert a grayscale image into 8x8 macroblocks and process them to model
% packet loss impact.
clc;clear;close all;
mbsize = 8;         % size of macroblock (MB)

load('mandrills');  % load mandrill image (480x480 uint8 matrix)
figure(1);          % show original image
imshow(mandrill);

[imgx, imgy] = size(mandrill);  % image dimensions
mbx = imgx / mbsize;            % number of MBs in X
mby = imgy / mbsize;            % number of MBs in Y

mbs = cell(mbx, mby);           % cell array storing MBs
for i=1:mbx
    for j=1:mby
        mbs{i,j} = mandrill(mbsize*(i-1)+1:mbsize*i, mbsize*(j-1)+1:mbsize*j);
    end
end


%% random discard of MBs to model packet loss impact
nd = 10;    % number of MBs to discard
% xs=sort(unidrnd(mbx, 1, nd));	% X index of MBs to discard
% ys=sort(unidrnd(mby, 1, nd));	% Y index of MBs to discard
xs=[1,6,7,16,24,47,49,50,53,58];
ys=[9,9,9,11,16,26,33,35,53,55];
damaged_mbs = mbs;
for i=1:nd
    damaged_mbs{xs(i),ys(i)}=zeros(8,8);    % set values of discarded MBs to 0
end



%% convert damaged MBs back to an image
Y = zeros(imgx, imgy);
for i=1:mbx
    for j=1:mby
        Y(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=damaged_mbs{i,j};
    end
end

mandrill_damaged = uint8(Y);    % convert to uint8 as a grayscale image
figure(2);                      % show damaged image
imshow(mandrill_damaged);


%%
concealed_mbs = macroblock_based( damaged_mbs,xs,ys,mbsize);
% convert macroblock based concealed MBs back to an image
Y2 = zeros(imgx, imgy);
for i=1:mbx
    for j=1:mby
        Y2(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=concealed_mbs{i,j};
    end
end

macro_concealed = uint8(Y2);    % convert to uint8 as a grayscale image
figure(3);                      % show damaged image
imshow(macro_concealed);


%%
fprintf('\nPSNR = %0.4f\n', psnr(mandrill_damaged, mandrill));   % PSNR of damaged image
fprintf('\nPSNR = %0.4f\n', psnr(macro_concealed, mandrill));   % PSNR of damaged image