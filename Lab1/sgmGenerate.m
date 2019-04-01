function seq = sgmGenerate(len,tr)
%SGMGENERATE generate a loss sequence based on a Simple Guilbert Model
%   SEQ = SGMGENERATE(LEN,TRANSITIONS) generates a binary sequence of
%   0 (GOOD) and 1 (BAD), SEQ, of length LEN from an SGM specified by a
%   2x2 transition probability matrix, TRANSITIONS. TRANSITIONS(I,J) is
%   the probability of transition from state I to state J; note that due
%   to the matlab matrix indexing (i.e., starting from 1), TRANSITIONS(1,2)
%   is the probability of transition from GOOD (0) state to BAD (1) state.
%
%   This function always starts the model in GOOD (0) state.
%
%   Examples:
%
%   tr = [0.95,0.10;
%         0.05,0.90];
%
%   seq = sgmGenerate(100, tr)


seq = zeros(1,len);

% tr must be 2x2 matrix
if size(tr,1) ~= 2 || size(tr,2) ~= 2
    error(message('size of transition matrix is not 2x2'));
end

% create a random sequence for state changes
statechange = rand(1,len);

% Assume that we start in state 1.
state = 1;

% main loop
for count = 1:len
    if statechange(count) > tr(state,state)
        % transition into the other state
        state = mod(state,2)+1;
    end
    % add a binary value to output
    seq(count) = state-1;
end