function policy = initGaussPolicy(param)
% Adapted by original code from Jan Peters (jrpeters@usc.edu).

    N = param.N;
    M = param.M;

    policy.theta.k = rand(N*M,1);
    policy.theta.sigma = rand(1,M);