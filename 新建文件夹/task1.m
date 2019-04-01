clc;clear;
load('mandrills.mat');
[m,n]=size(mandrill_damaged);

%size of macroblock
mbsize=16; 

%number of macroblocks
x=m/mbsize;
y=n/mbsize;

%set cell array storing macroblocks
damagecell=cell(x,y);

%set a matrix to store the coordinates of lost blocks and 
%divide it into x*y cells
bw=ones(m,n);
bw_cell=mat2cell(bw,ones(1,x)*mbsize,ones(1,y)*mbsize);

%store the macroblocks
for p=1:x
    for q=1:y
        damagecell{p,q}=mandrill_damaged(mbsize*(p-1)+1:mbsize*p,mbsize*(q-1)+1:mbsize*q);
        %check whether it is a damaged block and set the first pixel to 0 
        if sum(damagecell{p,q})==0
            bw_cell{p,q}(1,1)=0;
        end
    end
end

%combine the cells to matrix
bw2=cell2mat(bw_cell);

%record the coordinates of lost blocks
[r,c,v]=find(bw2==0);

%convert the coordinates of lost blocks to coordinates of lost cells
r=(r-1)/mbsize+1;
c=(c-1)/mbsize+1;

%zero padding the damaged image and divide it into cells
damage=cell2mat(damagecell);
damagepad=double(padarray(damage,[mbsize mbsize],'both'));
damagepadcell=mat2cell(damagepad,ones(1,x+2)*mbsize,ones(1,y+2)*mbsize);

%use the macroblock-based spatial interpolation technique to conceal the
%lost blocks
l=length(r);
for j=1:l
    for i=1:mbsize
       for k=1:mbsize
           %if the surrounding macroblocks do not exist, set the distance
           %to zero
            if sum(damagepadcell{r(j),c(j)+1})~=0
                dB=mbsize+1-i;
            else
                dB=0;
            end
            if sum(damagepadcell{r(j)+2,c(j)+1})~=0
                dT=i;
            else
                dT=0;
            end
            if sum(damagepadcell{r(j)+1,c(j)})~=0
                dR=mbsize+1-k;
            else 
                dR=0;
            end
            if sum(damagepadcell{r(j)+1,c(j)+2})~=0
                dL=k;
            else
                dL=0;
            end
            %interpolates each pixel of the lost macroblocks with the
            %neighbouring macroblocks
            damagepadcell{r(j)+1,c(j)+1}(i,k)=(dR*damagepadcell{r(j)+1,c(j)}(i,mbsize)...
                                                                +dL*damagepadcell{r(j)+1,c(j)+2}(i,1)...
                                                                +dB*damagepadcell{r(j),c(j)+1}(mbsize,k)...
                                                                +dT*damagepadcell{r(j)+2,c(j)+1}(1,k))...
                                                                /(dR+dL+dB+dT);
        end
    end
end

%remove the zero padding
image=cell2mat(damagepadcell);
image_conceal=image(mbsize+1:mbsize+m,mbsize+1:mbsize+n);

%plot the original image and error-concealed image
subplot(1,2,1);imshow(mandrill);title('Original Image');
subplot(1,2,2);imshow(uint8(image_conceal));title('Concealed Image');

%calculate the PSNR of the damaged image and erro-concealed image
fprintf('\nPSNR_damage = %0.4f\n', psnr(mandrill_damaged, mandrill));
fprintf('\nPSNR_conceal = %0.4f\n', psnr(uint8(image_conceal), mandrill));                        