function dJdtheta = episodicREINFORCE(policy, data,param)

N = param.N;
M = param.M;
gamma = param.gamma;
   
dJdtheta = zeros(size(DlogPiDThetaREINFORCE(policy,ones(N,1),ones(M,1),param)));

for Trials = 1 : max(size(data))
    dSumPi = zeros(size(DlogPiDThetaREINFORCE(policy,ones(N,1),ones(M,1),param)));
    sumR   = 0;   
    for Steps = 1 : max(size(data(Trials).u))
        dSumPi = dSumPi + DlogPiDThetaREINFORCE(policy, data(Trials).x(:,Steps), data(Trials).u(:,Steps),param);
        sumR   = sumR   + gamma^(Steps-1)*data(Trials).r(Steps);
    end
    dJdtheta = dJdtheta + dSumPi * sumR;
end
     
dJdtheta = (1-gamma)*dJdtheta / max(size(data));