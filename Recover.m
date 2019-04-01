function [ Recovery ] = Recover(damaged_mbs,xs,ys,mbsize)
for j=1:128 % number of MBs to discard
    mbT=zeros(mbsize,mbsize);Bottom=0;
    mbL=zeros(mbsize,mbsize);Right=0;
    mbB=zeros(mbsize,mbsize);Top=0;
    mbR=zeros(mbsize,mbsize);Left=0;
    if (xs(j)-1)~=0
        mbT=damaged_mbs{xs(j)-1,ys(j)};
        Bottom=1;
    if (ys(j)-1)~=0
        mbL=damaged_mbs{xs(j),ys(j)-1};
        Right=1;
    end
    if (xs(j)+1)~=length(damaged_mbs)+1
        mbB=damaged_mbs{xs(j)+1,ys(j)};  
        Top=1;
    end
    if (ys(j)+1)~=length(damaged_mbs)+1
        mbR=damaged_mbs{xs(j),ys(j)+1};
        Left=1;
    end
    mb=zeros(mbsize,mbsize);
    for i=1:mbsize
        for k=1:mbsize
            mb(i,k)=uint8(((15-k)*Right*double(mbL(i,mbsize))+(k)*Left*double(mbR(i,1))+(15-i)*Top*double(mbT(mbsize,k))+(i)*Bottom*double(mbB(1,k)))/((k)*Left+(15-k)*Right+(i)*Bottom+(15-i)*Top));
        end
    end
    damaged_mbs{xs(j),ys(j)}=mb;
end
Recovery=damaged_mbs;
end

