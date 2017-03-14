function [PparamDM] = initDMTasks(nSystems)

PparamDM.N = 4; % Number of states
PparamDM.M = 1; % Number of inputs

PparamDM.nSystems = nSystems; % Number of tasks
PparamDM.ProblemID = 'DM'; % Label of task group

% Range of parameters
PparamDM.MassOneMin = 3; 
PparamDM.MassOneMax = 4; 
PparamDM.MassTwoMin = 1; 
PparamDM.MassTwoMax = 2; 
PparamDM.Mink1 = 1; 
PparamDM.Maxk1 = 3; 
PparamDM.Mink2 = 1; 
PparamDM.Maxk2 = 3; 
PparamDM.Maxd1 = 0.1;
PparamDM.Mind1 = 0.01; 
PparamDM.Maxd2 = 0.1;
PparamDM.Mind2 = 0.01; 

% Reference (final) State
PparamDM.xG = zeros(PparamDM.N,PparamDM.nSystems); 

% Initial State
PparamDM.my0 = 5*rand(PparamDM.N,PparamDM.nSystems);
