function [Tasks,indf,groupf]=genBKTask(Pparam,Tasks,ind0,group0)

nSysBK=Pparam.BK.nSystems; % Number of systems
indf = ind0 + nSysBK;

if nSysBK ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.BK.N; % Number of states
param.M = Pparam.BK.M; % Number of inputs

param.dt = 0.01; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.BK.N); % Covariance matrix for Gaussian Policy 
    
% Identifiers for tasks and groups
param.ProblemID = 'BK';

counter = 1;
for i=ind0:ind0+nSysBK-1
    % Calculation of random parameters
    param.m = (Pparam.BK.mMax-Pparam.BK.mMin)*rand()+Pparam.BK.mMin;
    param.a = (Pparam.BK.aMax-Pparam.BK.aMin)*rand()+Pparam.BK.aMin;
    param.h = (Pparam.BK.hMax-Pparam.BK.hMin)*rand()+Pparam.BK.hMin;
    param.b = (Pparam.BK.bMax-Pparam.BK.bMin)*rand()+Pparam.BK.bMin;
    param.c = (Pparam.BK.cMax-Pparam.BK.cMin)*rand()+Pparam.BK.cMin;
    param.lambda = (Pparam.BK.lambdaMax-Pparam.BK.lambdaMin)*rand()+Pparam.BK.lambdaMin;
    param.g = Pparam.BK.g;
            
    D = param.m*param.a*param.h;
    J = param.m*param.h^2;
    V = 20;

    k1 = param.b^2/(param.m*param.a*param.c*sin(param.lambda)*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda)));
    k2 = param.b*param.g/(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda));
    
    % Initial and reference (final) states
    param.my0 = Pparam.BK.my0(:,counter);
    param.xG = Pparam.BK.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end