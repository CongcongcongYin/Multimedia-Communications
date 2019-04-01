clear;
load('mandrills.mat');

imshow(mandrill_damaged);
mandrill_damaged=double(mandrill_damaged);
% size of macroblock
mbsize=16;
[m,n]=size(mandrill_damaged);
% number of macroblocks
x=m/mbsize;
y=n/mbsize;
% dicide into 30*30
damagecell=cell(x,y);
for i=1:x
    for j=1:y
        damagecell{i,j} = mandrill_damaged(mbsize*(i-1)+1:mbsize*i, mbsize*(j-1)+1:mbsize*j);
    end
end
% get the location of block
[p,q]=size(damagecell);
r = 0;
for i=1:p
    for j=1:q
        if sum(sum(damagecell{i,j}))==0 % according to the summation equales to or not 0, we can get the xs and ys 
            r = r+1;
            xs(1,r) = i;
            ys(1,r) = j;
        end
    end
end
% convert MBs back to a damaged image
for j=1:121 % number of MBs to discard
    mbT=zeros(mbsize,mbsize);Bottom=0;
    mbL=zeros(mbsize,mbsize);Right=0;
    mbB=zeros(mbsize,mbsize);Top=0;
    mbR=zeros(mbsize,mbsize);Left=0;
    if (xs(j)-1)~=0
        if sum(sum(damagecell{xs(j)-1,ys(j)}))~=0 % To judge whether it is a connected block
            mbT=damagecell{xs(j)-1,ys(j)}; % To judge whether there is bottom block
            Bottom=1;
        end
    end
    if (ys(j)-1)~=0
        if sum(sum(damagecell{xs(j),ys(j)-1}))~=0 % To judge whether it is a connected block
            mbL=damagecell{xs(j),ys(j)-1}; % To judge whether there is right block
            Right=1;
        end
    end
    if (xs(j)+1)~=length(damagecell)+1
        if sum(sum(damagecell{xs(j)+1,ys(j)}))~=0 % To judge whether it is a connected block
            mbB=damagecell{xs(j)+1,ys(j)}; % To judge whether there is top block
            Top=1;
        end
    end
    if (ys(j)+1)~=length(damagecell)+1
        if sum(sum(damagecell{xs(j),ys(j)+1}))~=0 % To judge whether it is a connected block
            mbR=damagecell{xs(j),ys(j)+1}; % To judge whether there is left block
            Left=1;
        end
    end
    % use the function for calculate
    macroblock=zeros(mbsize,mbsize);
    for i=1:mbsize
        for k=1:mbsize
            macroblock(i,k)=uint8(((17-k)*Right*double(mbL(i,mbsize))+(k)*Left*double(mbR(i,1))+(17-i)*Top*double(mbB(mbsize,k))+(i)*Bottom*double(mbT(1,k)))/((k)*Left+(17-k)*Right+(i)*Bottom+(17-i)*Top));
        end
    end
    damagecell{xs(j),ys(j)}=macroblock;
end
Conceal = cell2mat(damagecell);   
Conceal = uint8(Conceal); % convert to uint8 as a grayscale image
figure(3); % show recovery image
imshow(Conceal);

fprintf('\nPSNR_Conceal = %0.4f\n', psnr(uint8(Conceal), mandrill)); 