clear all;
I1=imread('imL_cones.png');
I1=rgb2gray(I1);
I1=uint8(I1);
I11=I1;
figure,imshow(uint8(I11));title('L');
I2=imread('imR_cones.png');
I2=rgb2gray(I2);
I2=uint8(I2);
I21=I2;
figure,imshow(uint8(I21));title('R');

[m, n]=size(I1); 

step=16;
I12=image_loss(I1,step);

for i=3*step+1:3*step:m-2*step
    for j=3*step+1:3*step:n-2*step
        I1(i:i+step-1,j:j+step-1)=I2(i:i+step-1,j:j+step-1);
    end
end

bipsnr=psnr(I11,I1); 
figure,imshow(I1);title(strcat('直接空间替代后 PSNR= ',num2str(bipsnr)));