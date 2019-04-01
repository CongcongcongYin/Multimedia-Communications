% Convert a grayscale image into 8x8 macroblocks and process them to model
% packet loss impact.

mbsize = 16;         % size of macroblock (MB)

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

% random discard of MBs to model packet loss impact
nd = 128;    % number of MBs to discard
xs=unidrnd(mbx, 1, nd);	% X index of MBs to discard
ys=unidrnd(mby, 1, nd);	% Y index of MBs to discard
damaged_mbs = mbs;
for i=1:nd
    damaged_mbs{xs(i),ys(i)}=zeros(mbsize,mbsize);    % set values of discarded MBs to 0
end

% convert damaged MBs back to an image
Y = zeros(imgx, imgy);

for i=1:mbx
    for j=1:mby
        Y(mbsize*(i-1)+1:mbsize*i,mbsize*(j-1)+1:mbsize*j)=damaged_mbs{i,j};
    end
end

mandrill_damaged = uint8(Y);    % convert to uint8 as a grayscale image
figure(2);                      % show damaged image
imshow(mandrill_damaged);

fprintf('\nPSNR = %0.4f\n', psnr(mandrill_damaged, mandrill));   % PSNR of damaged image