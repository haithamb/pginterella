function [PparamSM] = initSMTasks(nSystems)

PparamSM.N = 2; % Number of states
PparamSM.M = 1; % Number of inputs

PparamSM.nSystems = nSystems; % Number of tasks
PparamSM.ProblemID = 'SM'; % Label of task group

% Range of parameters
PparamSM.MassMin = 3;
PparamSM.MassMax = 5; 
PparamSM.Mink = 1; 
PparamSM.Maxk = 7; 
PparamSM.Maxd = 0.1;
PparamSM.Mind = 0.01; 

% Reference (final) State
PparamSM.xG = zeros(2,PparamSM.nSystems);

% Initial State
PparamSM.my0 = 2*rand(2,PparamSM.nSystems);