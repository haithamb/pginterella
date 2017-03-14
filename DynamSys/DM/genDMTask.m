function [Tasks,indf,groupf]=genDMTask(Pparam,Tasks,ind0,group0)

nSysDM=Pparam.DM.nSystems; % Number of systems
indf = ind0 + nSysDM;

if nSysDM ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.DM.N; % Number of states
param.M = Pparam.DM.M; % Number of inputs

param.dt = 0.05; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.DM.N); % Covariance matrix for Gaussian Policy 
    
% Identifiers for tasks and groups
param.ProblemID = 'DM';

counter = 1;
for i=ind0:ind0+nSysDM-1
    % Calculation of random parameters
    param.MassOne = (Pparam.DM.MassOneMax - Pparam.DM.MassOneMin)*rand()+Pparam.DM.MassOneMin;
    param.MassTwo = (Pparam.DM.MassTwoMax - Pparam.DM.MassTwoMin)*rand()+Pparam.DM.MassTwoMin;
    param.k1 = (Pparam.DM.Maxk1-Pparam.DM.Mink1)*rand()+Pparam.DM.Mink1;
    param.k2 = (Pparam.DM.Maxk2-Pparam.DM.Mink2)*rand()+Pparam.DM.Mink2;
    param.d1 = (Pparam.DM.Maxd1-Pparam.DM.Mind1)*rand()+Pparam.DM.Mind1;
    param.d2 = (Pparam.DM.Maxd2-Pparam.DM.Mind2)*rand()+Pparam.DM.Mind2;
    
    % Initial and reference (final) states
    param.my0 = Pparam.DM.my0(:,counter);
    param.xG = Pparam.DM.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end