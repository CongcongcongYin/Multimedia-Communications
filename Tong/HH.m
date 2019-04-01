function [ concealed_mbs ] = HH( damaged_mbs,xs,ys,mbsize)
L=mbsize;
temp_mbs=damaged_mbs;
for j=1:10
    mbT=zeros(L,L);
    mbL=zeros(L,L);
    mbB=zeros(L,L);
    mbR=zeros(L,L);
    if (xs(j)-1)~=0 
        mbT=temp_mbs{xs(j)-1,ys(j)};

    end
    if (ys(j)-1)~=0
        mbL=temp_mbs{xs(j),ys(j)-1};

    end
    if (xs(j)+1)~=length(damaged_mbs)+1
        mbB=temp_mbs{xs(j)+1,ys(j)};  

    end
    if (ys(j)+1)~=length(damaged_mbs)+1
        mbR=temp_mbs{xs(j),ys(j)+1};

    end
    mb=zeros(L,L);
    for i=1:L
        for k=1:length(mb)
            nominator=(9-k)*double(mbL(i,L))+(k)*double(mbR(i,1))+(9-i)*double(mbT(L,k))+(i)*double(mbB(1,k));
            denominator=(k)+(9-k)+(i)+(9-i);
            temp=nominator/denominator;
            mb(i,k)=uint8(temp);
        end
    end
    temp_mbs{xs(j),ys(j)}=mb;
end
concealed_mbs=temp_mbs;
end

