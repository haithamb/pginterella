function [Tasks,indf,groupf]=genSMTask(Pparam,Tasks,ind0,group0)

nSysSM=Pparam.SM.nSystems; % Number of systems
indf = ind0 + nSysSM;
if nSysSM ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.SM.N; % Number of states
param.M = Pparam.SM.M; % Number of inputs

param.dt = .05; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.SM.N); % Covariance matrix for Gaussian Policy
    
% Identifiers for tasks and groups
param.ProblemID = 'SM';


counter = 1;
for i=ind0:ind0+nSysSM-1
    % Calculation of random parameters
    param.Mass=(Pparam.SM.MassMax-Pparam.SM.MassMin)*rand()+Pparam.SM.MassMin;
    param.k=(Pparam.SM.Maxk-Pparam.SM.Mink)*rand()+Pparam.SM.Mink;
    param.d=(Pparam.SM.Maxd-Pparam.SM.Mind)*rand()+Pparam.SM.Mind;
    
    % Initial and reference (final) states
    param.my0 = Pparam.SM.my0(:,counter);
    param.xG = Pparam.SM.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end