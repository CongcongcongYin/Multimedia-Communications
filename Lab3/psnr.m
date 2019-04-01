function[ps]=psnr(i0,i1)
%i0为真实原始图像，i1为重建图像
% [M,N]=size(g);
%  M  代表图像的高，     即图像矩阵所有的行数－328
%  N  代表图像的长（宽），即图像矩阵所有的列数－438

[imgrownumber, imgcolnumber]=size(i0); %求图像大小
b0=double(i0);
b1=double(i1);
sum=0.0;
a=255;
for i=1:imgrownumber
    for j=1:imgcolnumber
        sum=sum+(b0(i,j)-b1(i,j))^2;%两幅图像对应位置相减求平方再累加
    end
end
p=(imgrownumber*imgcolnumber*(a^2))/sum;
ps=10*log10(p);