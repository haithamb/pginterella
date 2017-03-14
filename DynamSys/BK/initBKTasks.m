function [PparamBK]=initBKTasks(nSystems)

PparamBK.N = 2; % Number of states
PparamBK.M = 2; % Number of inputs

PparamBK.nSystems = nSystems; % Number of tasks
PparamBK.ProblemID = 'BK'; % Label of task group

% Range of parameters
PparamBK.mMax = 14;
PparamBK.mMin = 10;
PparamBK.aMax = .6;
PparamBK.aMin = .2;
PparamBK.hMax = .8;
PparamBK.hMin = .4;
PparamBK.bMax = 3;
PparamBK.bMin = 1;
PparamBK.cMax = .1;
PparamBK.cMin = .05;
PparamBK.lambdaMax = 80*pi/180;
PparamBK.lambdaMin = 60*pi/180;
PparamBK.g = 9.81;

% D = PparamBK.m*PparamBK.a*PparamBK.h;
% J = PparamBK.m*PparamBK.h^2;
% V = 20;

% Reference (final) State
PparamBK.xG = zeros(2,PparamBK.nSystems);

% Initial State
PparamBK.my0 = rand(2,PparamBK.nSystems);