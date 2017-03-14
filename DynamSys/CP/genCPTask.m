function [Tasks,indf,groupf]=genCPTask(Pparam,Tasks,ind0,group0)

nSysCP=Pparam.CP.nSystems; % Number of systems
indf = ind0 + nSysCP;

if nSysCP ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.CP.N; % Number of states
param.M = Pparam.CP.M; % Number of inputs

param.dt = 0.05; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.CP.N); % Covariance matrix for Gaussian Policy 
    
% Identifiers for tasks and groups
param.ProblemID = 'CP';

counter = 1;
for i=ind0:ind0+nSysCP-1
    % Calculation of random parameters
    param.mc=(Pparam.CP.MassCartMax-Pparam.CP.MassCartMin)*rand()+Pparam.CP.MassCartMin; 
    param.mp=(Pparam.CP.MassPoleMax-Pparam.CP.MassPoleMin)*rand()+Pparam.CP.MassPoleMin;
    param.I=(Pparam.CP.InertiaMax-Pparam.CP.InertiaMin)*rand()+Pparam.CP.InertiaMin; 
    param.l=(Pparam.CP.MaxLength-Pparam.CP.MinLength)*rand()+Pparam.CP.MinLength; 
    param.g=9.81; 
    param.d=(Pparam.CP.Maxd-Pparam.CP.Mind)*rand()+Pparam.CP.Mind;
    
    % Initial and reference (final) states
    param.my0 = Pparam.CP.my0(:,counter);
    param.xG = Pparam.CP.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end