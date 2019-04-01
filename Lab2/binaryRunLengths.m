function [zerorl, onerl] = binaryRunLengths(seq)
%BINARYRUNLENGTHS obtain run lengths from a binary sequence
%   [ZERORL, ONERL] = BINARYRUNLENGTHS(SEQ) generates a sequence of run
%   lengths for zero, ZERORL, and one, ONERL, respectively. SEQ is a binary
%   sequence.

w = [ 1 seq 1 ];	% auxiliary vector
zerorl = find(diff(w)==1) - find(diff(w)==-1);

w = [ 0 seq 0 ];	% auxiliary vector
onerl = find(diff(w)==-1) - find(diff(w)==1);
