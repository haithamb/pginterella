function [Tasks,indf,groupf]=genHCTask(Pparam,Tasks,ind0,group0)

nSysHC=Pparam.HC.nSystems; % Number of systems
indf = ind0 + nSysHC;

if nSysHC ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.HC.N; % Number of states
param.M = Pparam.HC.M; % Number of inputs

param.dt = 0.01; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.HC.N); % Covariance matrix for Gaussian Policy 
    
% Identifiers for tasks and groups
param.ProblemID = 'HC';

counter = 1;
for i=ind0:ind0+nSysHC-1
    % No parameters for this model
    
    % Initial and reference (final) states
    param.my0 = Pparam.HC.my0(:,counter);
    param.xG = Pparam.HC.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end