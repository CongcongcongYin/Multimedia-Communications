clc,clear
load('loss_seq.mat');

[n_0,n_1] = binaryRunLengths(seq);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
n_0=sum(n_0);%This n_0 means n0 that is the number of 0 at intervals. Add up all the n_0, we can caculate the n0
n_1=sum(n_1);%This n_1 means n0 that is the number of 1 at intervals. Add up all the n_1, we can caculate the n1
n_01=length(find(diff(seq)==1));%n01 is the number of times in the observed time series that 1 follows 0
n_10=length(find(diff(seq)==-1));%n10 is the number of times in the observed time series that 0 follows 1
p=n_01/n_0;%According to the simple method proposed by Yajnik, we can cacultae the p=n01/n0
q=n_10/n_1;%According to the simple method proposed by Yajnik, we can cacultae the q=n10/n1

tr=[(1-p),q;p,(1-q)];%The transition matrix for the SGM is given by P_SGM=[(1-p),q;p,(1-q)]
len=length(seq);
SGM_seq=sgmGenerate(len,tr);%Generate a Loss Pattern based on SGM

[zerorl_seq, onerl_seq] = binaryRunLengths(seq);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run
[zerorl_SGM_seq, onerl_SGM_seq] = binaryRunLengths(SGM_seq);%[zerorl, onerl] = binaryrunlengths(SEQ) generates a sequence of run

figure;
histogram(zerorl_seq);%Drawing a histogram
title('zero');
hold on
histogram(zerorl_SGM_seq);%Drawing a histogram
legend('original seq','SGM_seq');


figure;
histogram(onerl_seq);%Drawing a histogram
title('one');
hold on
histogram(onerl_SGM_seq);%Drawing a histogram
legend('original seq','SGM_seq');

