function u = drawAction(policy,x,param);
% Based on Jan Peters' code.

u = mvnrnd((reshape(policy.theta.k,param.N,param.M)'*x)', policy.theta.sigma);