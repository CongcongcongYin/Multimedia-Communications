%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 本算法实现的图像的误码掩盖；
% mbsize   表示blocksize的大小
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fid=fopen('Data_.txt','w');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_ori=imread('imL_cones.png');f_ori=rgb2gray(f_ori); %把彩色的变为黑白的
f_ori=uint8(f_ori);
figure,imshow(f_ori);title('原始图像');  
g_ori=imread('imR_cones.png');g_ori=rgb2gray(g_ori);

mbsize = 16;
f_loss = image_loss(f_ori,mbsize);       %产生丢失的图像；

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   假设图像大小为SATURN.bmp（438×328）
%   M  代表图像的高，     即图像矩阵所有的行数－328
%   N  代表图像的长（宽），即图像矩阵所有的列数－438
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N]=size(g_ori);

g=double(g_ori); f=double(f_loss);     %double将整数转换为双精度浮点数  
EBx=0; EBy=0; rx=0;ry=0;
temp=zeros(80,80);    
subimage=zeros(48,48);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 全部采用双线性内插
bif=double(f);
for i=1:mbsize:(M-mbsize+1)
    for j=1:mbsize:(N-mbsize+1)     
     %首先进行的是误码块的检测；   
     if bif(i:i+mbsize-1,j:j+mbsize-1)==0
         EBx=i;EBy=j;                   %找出图象中丢失块的左上角的坐标
         Out=BI(bif,EBx,EBy,mbsize);      %双线性插值
         bif(i:i+mbsize-1,j:j+mbsize-1)=Out;
     end
    end
end
bif=uint8(bif);

bipsnr=psnr(f_ori,bif);                  %计算整帧的psnr

figure,imshow(bif);title(strcat('双线性掩盖效果图  PSNR=',num2str(bipsnr)));  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %全部采用直接空间替代
 BIF=double(f);
for i=1:mbsize:(M-mbsize+1)
   for j=1:mbsize:(N-mbsize+1)     
     %首先进行的是误码块的检测；   
    if BIF(i:i+mbsize-1,j:j+mbsize-1)==0
       EBx=i;EBy=j;                     %找出图象中丢失块的左上角的坐标
        BIF(i:i+mbsize-1,j:j+mbsize-1)=g_ori(i:i+mbsize-1,j:j+mbsize-1);
     end
   end
end
BIF=uint8(BIF);
bipsnr=psnr(f_ori,BIF);                 %计算整帧的psnr

figure,imshow(BIF);title(strcat('直接空间替代效果图  PSNR=',num2str(bipsnr)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

