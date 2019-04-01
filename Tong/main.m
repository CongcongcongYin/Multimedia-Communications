clc;clear;close all;
mbsize = 8;        
load('mandrills');  
figure(1);         
imshow(mandrill);
[imgx, imgy] = size(mandrill);  % image dimensions
mbx = imgx / mbsize;            % number of MBs in X
mby = imgy / mbsize;            % number of MBs in Y
% cell array storing MBs
mbs = cell(mbx, mby);           
for i=1:mbx
    for j=1:mby
        mbs{i,j} = mandrill(mbsize*(i-1)+1:mbsize*i, mbsize*(j-1)+1:mbsize*j);
    end
end


% random discard of MBs to model packet loss impact
nd = 10;    % number of MBs to discard
% xs=sort(unidrnd(mbx, 1, nd));	% X index of MBs to discard
% ys=sort(unidrnd(mby, 1, nd));	% Y index of MBs to discard
xs=[2,6,8,16,24,47,49,50,53,58];
ys=[9,9,9,11,16,26,33,35,53,55];
damaged_mbs = mbs;
for i=1:nd
    damaged_mbs{xs(i),ys(i)}=zeros(8,8);    % set values of discarded MBs to 0
end
% cell to image of damaged frame
Y = zeros(imgx, imgy);
for i=1:mbx
    for j=1:mby
        Y(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=damaged_mbs{i,j};
    end
end

mandrill_damaged = uint8(Y);    % convert to uint8 as a grayscale image
figure(2);                      % show damaged image
imshow(mandrill_damaged);


a = advanced( damaged_mbs,xs,ys,mbsize);
imshow(a);



















