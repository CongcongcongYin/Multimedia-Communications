function c = m2c(m,rate)
[h,w] = size(m);
% c = cell(floor(h/rate),floor(w/rate));
 for i = 1:floor(h/rate)
     for j = 1:floor(w/rate)
         c{i,j} = m(rate*(i-1)+1:rate*i,rate*(i-1)+1:rate*i);
     end
 end