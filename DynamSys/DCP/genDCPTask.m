function [Tasks,indf,groupf]=genDCPTask(Pparam,Tasks,ind0,group0)

nSysDCP=Pparam.DCP.nSystems; % Number of systems
indf = ind0 + nSysDCP;

if nSysDCP ~= 0
    groupf = group0 + 1;
    param.Group = group0;
else
    groupf = group0;
    param.Group = 0;
end


param.N = Pparam.DCP.N; % Number of states
param.M = Pparam.DCP.M; % Number of inputs

param.dt = 0.01; % dt for integration
    
% Parameters for policy
param.rewardType = 'Distance';
param.polType = 'Gauss';
param.baselearner = 'NAC';
param.gamma = 0.9;
param.S0 = 0.0001*eye(Pparam.DCP.N); % Covariance matrix for Gaussian Policy 
    
% Identifiers for tasks and groups
param.ProblemID = 'DCP';

counter = 1;
for i=ind0:ind0+nSysDCP-1
    % Calculation of random parameters
        param.Ma = (Pparam.DCP.MaMax-Pparam.DCP.MaMin)*rand()+Pparam.DCP.MaMin;
        param.m1 = (Pparam.DCP.m1Max-Pparam.DCP.m1Min)*rand()+Pparam.DCP.m1Min;
        param.m2 = (Pparam.DCP.m2Max-Pparam.DCP.m2Min)*rand()+Pparam.DCP.m2Min;
        param.l1 = (Pparam.DCP.l1Max-Pparam.DCP.l1Min)*rand()+Pparam.DCP.l1Min;
        param.l2 = (Pparam.DCP.l2Max-Pparam.DCP.l2Min)*rand()+Pparam.DCP.l2Min;
        param.mu = (Pparam.DCP.muMax-Pparam.DCP.muMin)*rand()+Pparam.DCP.muMin;
        param.d = (Pparam.DCP.dMax-Pparam.DCP.dMin)*rand()+Pparam.DCP.dMin;
        param.g = Pparam.DCP.g;
        param.J1 = param.m1*param.l1^2/3;
        param.J2 = param.m2*param.l2^2/3;
        % Auxiliary variables
        l11 = (param.J1+param.m1*param.l1^2)/(param.m1*param.l1);
        l21 = (param.J2+param.m2*param.l2^2)/(param.m2*param.l2);
        Delta = param.Ma + param.J1/(param.l1*l11) + param.J2/(param.l2*l21);
    
    % Initial and reference (final) states
    param.my0 = Pparam.DCP.my0(:,counter);
    param.xG = Pparam.DCP.xG(:,counter);
    
    % Assignation of parameters to task i
    param.TaskId = i;
    Tasks(i).param = param; 
    
    counter = counter + 1;
end