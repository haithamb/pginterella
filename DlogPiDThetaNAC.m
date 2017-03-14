function [der1,der2] = DlogPiDThetaNAC(policy, x,u,param)

% Programmed by Jan Peters (jrpeters@usc.edu).
N = param.N;
M = param.M;

sigma = max(policy.theta.sigma,0.00001);
k = policy.theta.k;
xx = x;
der1 = [];
der2 = [];
for i=1:M
    der1 = [der1;(u(i)-k(1+N*(i-1):N*(i-1)+N)'*xx)*xx/(sigma(i)^2)];
%     der2 = [der2;((u(i)-k(1+N*(i-1):N*(i-1)+N)'*xx)^2-sigma(i)^2)/(sigma(i)^3)];
end

% der = [der1;der2]