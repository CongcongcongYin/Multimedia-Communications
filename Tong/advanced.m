function [a] = advanced( damaged_mbs,xs,ys,mbsize)
L=mbsize;
temp_mbs=damaged_mbs;
for i=1:10
   if xs(i)~=1
        top_MB=temp_mbs{xs(i)-1,ys(i)};
        if ys(i)~=1
            top_left_MB=temp_mbs{xs(i)-1,ys(i)-1};
            left_MB=temp_mbs{xs(i),ys(i)-1};
        end
        if ys(i)~=length(damaged_mbs)
            top_right_MB=temp_mbs{xs(i)-1,ys(i)+1};
            right_MB=temp_mbs{xs(i),ys(i)+1};
        end
   end
   if xs(i)~=length(damaged_mbs)
       bottom_MB=temp_mbs{xs(i)+1,ys(i)};
        if ys(i)~=1
            bottom_left_MB=temp_mbs{xs(i)+1,ys(i)-1};
            left_MB=temp_mbs{xs(i),ys(i)-1};
        end
        if ys(i)~=length(damaged_mbs)
            bottom_right_MB=temp_mbs{xs(i)+1,ys(i)+1};
            right_MB=temp_mbs{xs(i),ys(i)+1};
        end
   end
   
   if xs(i)~=1
       if ys(i)~=1 
           top_strip=[top_left_MB(L-2:L,L),top_MB(L-2:L,:)];
       else 
           top_strip=[top_MB(L-2:L,1),top_MB(L-2:L,:)];
       end
       if ys(i)~=length(damaged_mbs) 
           top_strip=[top_strip,top_right_MB(L-2:L,1)];
       else 
           top_strip=[top_strip,top_strip(L-2:L,L)];
       end
   end 
   
   if xs(i)~=length(damaged_mbs)
       if ys(i)~=1 
           bottom_strip=[bottom_left_MB(1:3,L),bottom_MB(1:3,:)];
       else 
           bottom_strip=[bottom_MB(1:3,1),bottom_MB(1:3,:)];
       end
       if ys(i)~=length(damaged_mbs) 
           bottom_strip=[bottom_strip,bottom_right_MB(1:3,1)];
       else 
           bottom_strip=[bottom_strip,bottom_MB(1:3,L)];
       end
   end 
   
   if ys(i)~=1
       if xs(i)~=1 
           left_strip=[top_left_MB(L,L-2:L);left_MB(:,L-2:L)];
       else 
           left_strip=[left_MB(1,L-2:L);left_MB(:,L-2:L)];
       end
       if xs(i)~=length(damaged_mbs) 
           left_strip=[left_strip;bottom_left_MB(1,L-2:L)];
       else 
           left_strip=[left_strip;left_MB(L,L-2:L)];
       end
   end 
   
   if ys(i)~=length(damaged_mbs)
       if xs(i)~=1 
           right_strip=[top_right_MB(L,1:3);right_MB(:,1:3)];
       else 
           right_strip=[right_MB(L,1:3);right_MB(:,1:3)];
       end
       if xs(i)~=length(damaged_mbs) 
           right_strip=[right_strip;bottom_right_MB(1,1:3)];
       else 
           right_strip=[right_strip;right_MB(L,1:3)];
       end
   end 
   Hr=[1 0 -1;2 0 -2;1 0 -1]*1/4;
   Hc=[-1 -2 -1;0 0 0;1 2 1]*1/4;
   top_conv_Hr=conv2(double(top_strip()),Hr,'same');
   top_conv_Hc=conv2(double(top_strip),Hc,'same');
   bottom_conv_Hr=conv2(double(bottom_strip),Hr,'same');
   bottom_conv_Hc=conv2(double(bottom_strip),Hc,'same');
   left_conv_Hr=conv2(double(left_strip),Hr,'same');
   left_conv_Hc=conv2(double(left_strip),Hc,'same');
   right_conv_Hr=conv2(double(right_strip),Hr,'same');
   right_conv_Hc=conv2(double(right_strip),Hc,'same');
   
   Gr_top=double(top_conv_Hr(2,2:9));
   Gc_top=double(top_conv_Hc(2,2:9));
   Gr_bottom=double(bottom_conv_Hr(2,2:9));
   Gc_bottom=double(bottom_conv_Hc(2,2:9));
   Gr_left=double(left_conv_Hr(2:9,2));
   Gc_left=double(left_conv_Hc(2:9,2));
   Gr_right=double(right_conv_Hr(2:9,2));
   Gc_right=double(right_conv_Hc(2:9,2));
   
   A_top=sqrt(Gr_top.^2+Gc_top.^2);
   A_bottom=sqrt(Gr_bottom.^2+Gc_bottom.^2);
   A_right=sqrt(Gr_right.^2+Gc_right.^2);
   A_left=sqrt(Gr_left.^2+Gc_left.^2);
   theta_top=atan(Gr_top./Gc_top);
   theta_bottom=atan(Gr_bottom./Gc_bottom);
   theta_right=atan(Gr_right./Gc_right);
   theta_left=atan(Gr_left./Gc_left);
   
   Threshold_top=sum((top_strip(2,2:9)-mean(top_strip(2,2:9))).^2)/length(top_strip(2,2:9));
   Threshold_bottom=sum((bottom_strip(2,2:9)-mean(bottom_strip(2,2:9))).^2)/length(bottom_strip(2,2:9));
   Threshold_right=sum((right_strip(2:9,2)-mean(right_strip(2:9,2))).^2)/length(right_strip(2:9,2));
   Threshold_left=sum((left_strip(2:9,2)-mean(left_strip(2:9,2))).^2)/length(left_strip(2:9,2));   
   
   A_top(A_top<Threshold_top)=0;
   A_bottom(A_bottom<Threshold_bottom)=0;
   A_right(A_right<Threshold_right)=0;
   A_left(A_left<Threshold_left)=0;
   
   Damaged_MB=temp_mbs{xs(i),ys(i)};
   
%    left_bound_strip=
%    bottom_bound_strip=
%    right_bound_strip=
end
a=1;
end

