function  f = image_loss(image,step)
%f=imread(image);
%f=rgb2gray(f);
f=image;

% figure,imshow(f);
% title('ԭʼͼ��');

[h,w]=size(f);

 s=step  % block size16*16�Ķ�
for i=3*s+1:3*s:h-2*s
    for j=3*s+1:3*s:w-2*s     %�ڶ�λ��
        f(i:i+s-1,j:j+s-1)=zeros(s,s);%��ֵ�ڶ�
    end
end
%image= uint8(image)  ;
figure,imshow(f);  %��ʾ��ʧ����֮���ͼ�󣬶�ʧ��Ϊ50��
title('��ʧ����֮���ͼ��');