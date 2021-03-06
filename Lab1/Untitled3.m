clc,clear

load('loss_seq.mat');
[p,q]=estimate_transition_probabilities(seq);

tr=[1-p,q;p,(1-q)];
len=length(seq);
seq_SGM=sgmGenerate(len,tr);

[zero_1, one_1] = binaryRunLengths(seq);
[zero_2, one_2] = binaryRunLengths(seq_SGM);

figure;
histogram(zero_1);
hold on;
title('run length for zero');
histogram(zero_2);
legend('the given seq','the seq generated by SGM');

figure;
histogram(one_1);
hold on;
title('run length for one');
histogram(one_2);
legend('the given seq','the seq generated by SGM');
