function [PparamHC]=initHCTasks(nSystems)

PparamHC.N = 4; % Number of states
PparamHC.M = 2; % Number of inputs

PparamHC.nSystems=nSystems; % Number of tasks
PparamHC.ProblemID='HC'; % Label of task group

% Reference (final) State
PparamHC.xG = zeros(4,PparamHC.nSystems);

% Initial State
PparamHC.my0 = rand(4,PparamHC.nSystems);