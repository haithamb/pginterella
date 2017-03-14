function [PparamCP]=initCPTasks(nSystems)

PparamCP.N = 4; % Number of states
PparamCP.M = 1; % Number of inputs

PparamCP.nSystems = nSystems; % Number of tasks
PparamCP.ProblemID = 'CP'; % Label of task group

% Range of parameters
PparamCP.MassCartMax = 1.5; 
PparamCP.MassCartMin = 0.5; 
PparamCP.MassPoleMax = 0.2; 
PparamCP.MassPoleMin = 0.1;
PparamCP.InertiaMax = 0.002; 
PparamCP.InertiaMin = 0.001;
PparamCP.MaxLength = 0.8; 
PparamCP.MinLength = 0.5; 
PparamCP.Maxd = 0.2; 
PparamCP.Mind = 0.01;

% Reference (final) State
PparamCP.xG = zeros(4,PparamCP.nSystems);

% Initial State
PparamCP.my0 = pi/6*rand(4,PparamCP.nSystems);