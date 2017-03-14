function [PparamDCP]=initDCPTasks(nSystems)

PparamDCP.N = 6; % Number of states
PparamDCP.M = 1; % Number of inputs

PparamDCP.nSystems=nSystems; % Number of tasks
PparamDCP.ProblemID='DCP'; % Label of task group

% Range of parameters
PparamDCP.MaMax = 1.5; % 2.5;
PparamDCP.MaMin = 3.5;
PparamDCP.m1Max = .055; %.025;
PparamDCP.m1Min = .01;
PparamDCP.m2Max = .055; %.035;
PparamDCP.m2Min = .015;
PparamDCP.l1Max = .8; %.6;
PparamDCP.l1Min = .4;
PparamDCP.l2Max =  .9; %.7;
PparamDCP.l2Min = .5;
PparamDCP.muMax = .07; % .05;
PparamDCP.muMin = .03;
PparamDCP.dMax = .35; %.2;
PparamDCP.dMin = .05;
PparamDCP.g = 9.81;

% Reference (final) State
PparamDCP.xG=zeros(6,PparamDCP.nSystems);

% Initial State
PparamDCP.my0=rand(6,PparamDCP.nSystems);