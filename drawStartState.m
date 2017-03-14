function x0 = drawStartState(param);
% Based on Jan Peters' codes 

N = param.N;

my0 = param.my0;
S0 = param.S0;
x0 = mvnrnd(my0, S0, 1);