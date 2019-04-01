function [ concealed_mbs ] = macroblock_based( damaged_mbs,xs,ys,mbsize)
L=mbsize;
temp_mbs=damaged_mbs;
for j=1:10
    mbT=zeros(L,L);BB=0;
    mbL=zeros(L,L);RR=0;
    mbB=zeros(L,L);TT=0;
    mbR=zeros(L,L);LL=0;
    if (xs(j)-1)~=0 
        mbT=temp_mbs{xs(j)-1,ys(j)};
        BB=1;
    end
    if (ys(j)-1)~=0
        mbL=temp_mbs{xs(j),ys(j)-1};
        RR=1;
    end
    if (xs(j)+1)~=length(damaged_mbs)+1
        mbB=temp_mbs{xs(j)+1,ys(j)};  
        TT=1;
    end
    if (ys(j)+1)~=length(damaged_mbs)+1
        mbR=temp_mbs{xs(j),ys(j)+1};
        LL=1;
    end
    mb=zeros(L,L);
    for i=1:L
        for k=1:length(mb)
            nominator=(9-k)*RR*double(mbL(i,L))+(k)*LL*double(mbR(i,1))+(9-i)*TT*double(mbT(L,k))+(i)*BB*double(mbB(1,k));
            denominator=(k)*LL+(9-k)*RR+(i)*BB+(9-i)*TT;
            temp=nominator/denominator;
            mb(i,k)=uint8(temp);
        end
    end
    temp_mbs{xs(j),ys(j)}=mb;
end
concealed_mbs=temp_mbs;
end

