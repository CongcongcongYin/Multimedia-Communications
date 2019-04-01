clc,clear
load('loss_patterns.mat');
[n_0_1,n_1_1] = binaryRunLengths(loss_pattern1);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
n_0_1=sum(n_0_1);%This n_0 means n0 that is the number of 0 at intervals. Add up all the n_0, we can caculate the n0
n_1_1=sum(n_1_1);%This n_1 means n0 that is the number of 1 at intervals. Add up all the n_1, we can caculate the n1
n_01_1=length(find(diff(loss_pattern1)==1));%n01 is the number of times in the observed time series that 1 follows 0
n_10_1=length(find(diff(loss_pattern1)==-1));%n10 is the number of times in the observed time series that 0 follows 1
p_1=n_01_1/n_0_1;%According to the simple method proposed by Yajnik, we can cacultae the p=n01/n0
q_1=n_10_1/n_1_1;%According to the simple method proposed by Yajnik, we can cacultae the q=n10/n1
Packet_loss1=p_1/(p_1+q_1);%packet loss rate

[n_0_2,n_1_2] = binaryRunLengths(loss_pattern2);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
n_0_2=sum(n_0_2);%This n_0 means n0 that is the number of 0 at intervals. Add up all the n_0, we can caculate the n0
n_1_2=sum(n_1_2);%This n_1 means n0 that is the number of 1 at intervals. Add up all the n_1, we can caculate the n1
n_01_2=length(find(diff(loss_pattern2)==1));%n01 is the number of times in the observed time series that 1 follows 0
n_10_2=length(find(diff(loss_pattern2)==-1));%n10 is the number of times in the observed time series that 0 follows 1
p_2=n_01_2/n_0_2;%According to the simple method proposed by Yajnik, we can cacultae the p=n01/n0
q_2=n_10_2/n_1_2;%According to the simple method proposed by Yajnik, we can cacultae the q=n10/n1
Packet_loss2=p_2/(p_2+q_2);%packet loss rate

[n_0_3,n_1_3] = binaryRunLengths(loss_pattern3);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
n_0_3=sum(n_0_3);%This n_0 means n0 that is the number of 0 at intervals. Add up all the n_0, we can caculate the n0
n_1_3=sum(n_1_3);%This n_1 means n0 that is the number of 1 at intervals. Add up all the n_1, we can caculate the n1
n_01_3=length(find(diff(loss_pattern3)==1));%n01 is the number of times in the observed time series that 1 follows 0
n_10_3=length(find(diff(loss_pattern3)==-1));%n10 is the number of times in the observed time series that 0 follows 1
p_3=n_01_3/n_0_3;%According to the simple method proposed by Yajnik, we can cacultae the p=n01/n0
q_3=n_10_3/n_1_3;%According to the simple method proposed by Yajnik, we can cacultae the q=n10/n1
Packet_loss3=p_3/(p_3+q_3);%packet loss rate

[n_0_4,n_1_4] = binaryRunLengths(loss_pattern4);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
n_0_4=sum(n_0_4);%This n_0 means n0 that is the number of 0 at intervals. Add up all the n_0, we can caculate the n0
n_1_4=sum(n_1_4);%This n_1 means n0 that is the number of 1 at intervals. Add up all the n_1, we can caculate the n1
n_01_4=length(find(diff(loss_pattern4)==1));%n01 is the number of times in the observed time series that 1 follows 0
n_10_4=length(find(diff(loss_pattern4)==-1));%n10 is the number of times in the observed time series that 0 follows 1
p_4=n_01_4/n_0_4;%According to the simple method proposed by Yajnik, we can cacultae the p=n01/n0
q_4=n_10_4/n_1_4;%According to the simple method proposed by Yajnik, we can cacultae the q=n10/n1
Packet_loss4=p_4/(p_4+q_4);%packet loss rate

Packet_loss1_Ber=sum(loss_pattern1)/length(loss_pattern1);
Packet_loss2_Ber=sum(loss_pattern2)/length(loss_pattern2);
Packet_loss3_Ber=sum(loss_pattern3)/length(loss_pattern3);
Packet_loss4_Ber=sum(loss_pattern4)/length(loss_pattern4);

