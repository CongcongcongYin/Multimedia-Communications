function Outimage = BI(image,EBx,EBy,step)
%BIIMAGE interplote the EB by bilinear��
%image is the original image.
%EBx and EBy is the coordinate of the EB.

smallimage = zeros((step+2),(step+2)); %BI����Ҫ�Ĵ��ڴ�СΪ18��18
rx=EBx-1;ry=EBy-1;
rowhigh=EBx+step;
colhigh=EBy+step;
Outimage=zeros(step,step);
smallimage = image(rx:rowhigh,ry:colhigh);      %��ȡ��ʧ����Χ���õ�����
smallimage = double(smallimage);
for i=2:(step+1)
    for j=2:(step+1)
       small=(double(smallimage(1,j))*((step+2)-i)+double(smallimage((step+2),j))*(i-1)+double(smallimage(i,1))*((step+2)-j)+...
             double(smallimage(i,(step+2)))*(j-1))/(step*2+2);
       smallimage(i,j)=round(small);           %��˫���ȵ���ֵ��ȡΪ����.
    end
end
Outimage=smallimage(2:(step+1),2:(step+1));