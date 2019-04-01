load('mandrills.mat');
figure(1)
imshow(mandrill)
figure(2)
imshow(mandrill_damaged);
mandrill_damaged=double(mandrill_damaged);
mbsize=16;
[w,h]=size(mandrill_damaged);

A=w/16;
B=h/16;

pad_mandrill=padarray(mandrill_damaged,[1,1],0,'both');
%imshow(pad_mandrill);
pad_orgmandrill=padarray(mandrill,[1,1],0,'both');
for j=1:A
    for i=1:B
        if sum(sum(pad_mandrill([mbsize*(j-1)+2:mbsize*j+1],[mbsize*(i-1)+2:mbsize*i+1])))==0
            
            mbl=pad_mandrill(mbsize*(j-1)+2:mbsize*j+1,mbsize*(i-1)+1);
            mbr=pad_mandrill(mbsize*(j-1)+2:mbsize*j+1,mbsize*i+2);
            
            mbt=pad_mandrill(mbsize*(j-1)+1,mbsize*(i-1)+2:mbsize*i+1);
            mbb=pad_mandrill(mbsize*(j)+2,mbsize*(i-1)+2:mbsize*i+1);
            
            for m=1:mbsize
                for n=1:mbsize
                    dl=n;dt=m;dr=mbsize-n+1;db=mbsize-m+1;
                    if sum(mbl)==0
                        dr=0;
                    end
                    if sum(mbr)==0
                        dl=0;
                    end
                    if sum(mbt)==0
                        db=0;
                    end
                    if sum(mbb)==0
                        dt=0;
                    end
                    pad_mandrill(mbsize*(j-1)+1+m,mbsize*(i-1)+1+n)=(dr*mbl(m,1)+dl*mbr(m,1)+db*mbt(1,n)+dt*mbb(1,n))/(dl+dt+dr+db);
                    
                end
            end
            
        end
    end
end
pad_mandrill=uint8(pad_mandrill);
figure; imshow(pad_mandrill);
psnr(pad_mandrill,pad_orgmandrill);

