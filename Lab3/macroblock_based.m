function [ concealed_mbs ] = macroblock_based( damaged_mbs,xs,ys,mbsize)

L=mbsize;
temp_mbs=damaged_mbs;
for l=1:16
for j=1:16
        mbT=zeros(L,L);BB=0;
        mbL=zeros(L,L);RR=0;
        mbB=zeros(L,L);TT=0;
        mbR=zeros(L,L);LL=0;
        if (xs(l)-1)~=0
            mbT=temp_mbs{xs(l)-1,ys(j)};
            BB=1;
        end
        if (ys(j)-1)~=0
            mbL=temp_mbs{xs(l),ys(j)-1};
            RR=1;
        end
        if (xs(l)+1)~=length(damaged_mbs)+1
            mbB=temp_mbs{xs(l)+1,ys(j)};
            TT=1;
        end
        if (ys(j)+1)~=length(damaged_mbs)+1
            mbR=temp_mbs{xs(l),ys(j)+1};
            LL=1;
        end
        mb=zeros(L,L);
        for i=1:L
            for k=1:L
                nominator=(L+1-k)*RR*double(mbL(i,L))+(k)*LL*double(mbR(i,1))+(L+1-i)*TT*double(mbT(L,k))+(i)*BB*double(mbB(1,k));
                denominator=(k)*LL+(L+1-k)*RR+(i)*BB+(L+1-i)*TT;
                temp=nominator/denominator;
                mb(i,k)=uint8(temp);
            end
        end
        temp_mbs{xs(l),ys(j)}=mb;
        for p=1:30
            for q=1:30
                temp_mbs2(mbsize*(p-1)+1:mbsize*p,mbsize*(q-1)+1:mbsize*q)=temp_mbs{p,q};
            end
        end
    end
    concealed_mbs=temp_mbs;
end
end

