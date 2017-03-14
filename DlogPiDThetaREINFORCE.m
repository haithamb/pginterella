function [der,der2] = DlogPiDThetaREINFORCE(policy,x,u,param)

% Programmed by Jan Peters (jrpeters@usc.edu).
N=param.N;
M=param.M;

sigma = max(policy.theta.sigma,0.00001);
k = policy.theta.k;
xx = x;
der = [];
for i=1:M
    der = [der;(u(i)-k(1+N*(i-1):N*(i-1)+N)'*xx)*xx/(sigma(i)^2)];
end
