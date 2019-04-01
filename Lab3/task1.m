load('mandrills.mat');%load .mat file in MATLAB
mandrill_damaged=double(mandrill_damaged);%change data type for calculation
mbsize=16; %Setting MB size

[w,h]=size(mandrill_damaged);%Get the size of damaged image 
C=w/16;  %Calculate calculation times
R=h/16;

mandrill_pad=padarray(mandrill_damaged,[1,1],0,'both');%Padding the damaged image with 1 pixel%
orgmandrill_pad=padarray(mandrill,[1,1],0,'both');%Padding the original image for PSNR comparation%

for j=1:C
    for i=1:R
     %Judge whether the current 16*16 block is an error block%   
        if sum(sum(mandrill_pad([mbsize*(j-1)+2:mbsize*j+1],[mbsize*(i-1)+2:mbsize*i+1])))==0
     %Estimate which pixel will be choosen       
            mbl=mandrill_pad(mbsize*(j-1)+2:mbsize*j+1,mbsize*(i-1)+1);
            mbr=mandrill_pad(mbsize*(j-1)+2:mbsize*j+1,mbsize*i+2);
            mbt=mandrill_pad(mbsize*(j-1)+1,mbsize*(i-1)+2:mbsize*i+1);
            mbb=mandrill_pad(mbsize*(j)+2,mbsize*(i-1)+2:mbsize*i+1);
            for m=1:mbsize
            for n=1:mbsize
            
            dl=n;dt=m;dr=mbsize-n+1;db=mbsize-m+1; 
                    if sum(mandrill_pad(mbsize*(j-1)+2:mbsize*j+1,mbsize*(i-1)+1))==0
                        dr=0;%No left boundary%
                    end
                    if sum(mandrill_pad(mbsize*(j-1)+2:mbsize*j+1,mbsize*i+2))==0
                        dl=0; %No right boundary%
                    end
                    if sum(mandrill_pad(mbsize*(j-1)+1,mbsize*(i-1)+2:mbsize*i+1))==0
                        db=0; %No top boundary%
                    end
                    if sum(mandrill_pad(mbsize*(j)+2,mbsize*(i-1)+2:mbsize*i+1))==0
                        dt=0; %No bottom boundary%
                    end
                    %Interpolation Process%
                    mandrill_pad(mbsize*(j-1)+1+m,mbsize*(i-1)+1+n)=(dr*mbl(m,1)+dl*mbr(m,1)+db*mbt(1,n)+dt*mbb(1,n))/(dl+dt+dr+db);
                end
            end
        end
    end
end
mandrill_pad=uint8(mandrill_pad);%Transfer the data type to uint8%
figure; imshow(mandrill_pad);    %Show the result image%
psnr(mandrill_pad,orgmandrill_pad);%Evaluate the performance for algorithm%
