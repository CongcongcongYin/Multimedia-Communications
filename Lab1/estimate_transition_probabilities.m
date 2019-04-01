function [p,q]=estimate_transition_probabilities(seq)
n_01=length(find(diff(seq)==1));
n_10=length(find(diff(seq)==-1));
[n_0, n_1] = binaryRunLengths(seq);
p=n_01/sum(n_0);
q=n_10/sum(n_1);
