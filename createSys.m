function [Tasks]=createSys()

% Defining the number of tasks
nSMTasks = 3000;
nDMTasks = 1000;
nCPTasks = 1000;
%nBKTasks = 3;
nHCTasks = 0;
%nDCPTasks = 3;

ind0 = 1;
group0 = 1;
Tasks = struct();
% Parameters for Simple Mass system
[Pparam.SM]=initSMTasks(nSMTasks);
[Tasks,indf,groupf] = genSMTask(Pparam,Tasks,ind0,group0);

% Parameters for Double Mass system
[Pparam.DM]=initDMTasks(nDMTasks);
[Tasks,indf,groupf] = genDMTask(Pparam,Tasks,indf,groupf);

% Parameters for Cart-Pole system
[Pparam.CP]=initCPTasks(nCPTasks);
[Tasks,indf,groupf] = genCPTask(Pparam,Tasks,indf,groupf);

% Parameters for Bicycle System
%[Pparam.BK]=initBKTasks(nBKTasks);
%[Tasks,indf,groupf] = genBKTask(Pparam,Tasks,indf,groupf);

% Parameters for Helicopter System
[Pparam.HC]=initHCTasks(nHCTasks);
[Tasks,indf,groupf] = genHCTask(Pparam,Tasks,indf,groupf);

% Parameters for Double Inverted Pendulum
%[Pparam.DCP]=initDCPTasks(nDCPTasks);
%[Tasks] = genDCPTask(Pparam,Tasks,indf,groupf);
