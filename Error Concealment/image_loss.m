function  f = image_loss(image,step)
%f=imread(image);
%f=rgb2gray(f);
f=image;

% figure,imshow(f);
% title('原始图像');

[h,w]=size(f);

 s=step  % block size16*16的洞
for i=3*s+1:3*s:h-2*s
    for j=3*s+1:3*s:w-2*s     %黑洞位置
        f(i:i+s-1,j:j+s-1)=zeros(s,s);%赋值黑洞
    end
end
%image= uint8(image)  ;
figure,imshow(f);  %显示丢失内容之后的图象，丢失率为50％
title('丢失内容之后的图像');