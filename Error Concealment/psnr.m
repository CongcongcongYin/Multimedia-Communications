function[ps]=psnr(i0,i1)
%i0Ϊ��ʵԭʼͼ��i1Ϊ�ؽ�ͼ��
% [M,N]=size(g);
%  M  ����ͼ��ĸߣ�     ��ͼ��������е�������328
%  N  ����ͼ��ĳ���������ͼ��������е�������438

[imgrownumber, imgcolnumber]=size(i0); %��ͼ���С
b0=double(i0);
b1=double(i1);
sum=0.0;
a=255;
for i=1:imgrownumber
    for j=1:imgcolnumber
        sum=sum+(b0(i,j)-b1(i,j))^2;%����ͼ���Ӧλ�������ƽ�����ۼ�
    end
end
p=(imgrownumber*imgcolnumber*(a^2))/sum;
ps=10*log10(p);