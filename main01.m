%% Creating Systems and calculating learning rates
close all
clear all
%--------------------------------------------------------------------------
% Creating Tasks and determining learning rate
[Tasks]=createSys();
[Policies]=constructPolicies(Tasks);
rates=[1e-2,3e-2,1e-1,3e-1,1,3];
[LearningRates,Policies]=determineLearningRates(Tasks,Policies,rates);

%--------------------------------------------------------------------------

%% Learning the PGInterGroupingELLA 
%--------------------------------------------------------------------------

Observe_flag = 0;
counter = 1;
TrajLength = 50;
NumRollouts = 100;
ObservedTasks = zeros(size(Tasks,2),1);
limitOne = 1;
limitTwo = size(Tasks,2);

[model] = initPGInterELLA(Tasks,8,1,exp(-5),exp(-5),exp(-5),0.001,0.00001);
[modelPGELLA] = initPGELLA(Tasks,1,exp(-5),exp(-5),0.001);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ~Observe_flag % Once All Tasks are observed this will be set to one 
       
    if all(ObservedTasks) % All tasks have been observed 
        Observe_flag = 1; % Set flag to one 
        disp(['All Tasks observed @: ',num2str(counter)]);
    end
    
    [taskId] = randi([limitOne limitTwo],1);      % get a random task
          
    if ObservedTasks(taskId) == 0 % This means it is the first time taskId is observed
        ObservedTasks(taskId) = 1; % Set it's index to 1
        model(1).T = model(1).T + 1;
    end

%--------------------------------------------------------------------------
% Policy Gradients on taskId
%--------------------------------------------------------------------------
    %for i=1:3
    [data]=obtainData(Policies(taskId).policy,TrajLength...
        ,NumRollouts,Tasks(taskId).param);
    % Compute Derivative of Pay-off function 
    
    if strcmp(Tasks(taskId).param.baselearner,'REINFORCE')
        dJdTheta = episodicREINFORCE(Policies(taskId).policy,data...
        ,Tasks(taskId).param);
    else
        dJdTheta = episodicNaturalActorCritic(Policies(taskId).policy,data...
        ,Tasks(taskId).param);
    end
    
    % Update Policy Parameters
    Policies(taskId).policy.theta.k=Policies(taskId).policy.theta.k ...
        +1./10*LearningRates(taskId)*dJdTheta;

%--------------------------------------------------------------------------                
%--------------------------------------------------------------------------                
    % Compute Hessian 
    [data]=obtainData(Policies(taskId).policy,5,NumRollouts,Tasks(taskId).param); % Get data using new policy for D
    switch Tasks(taskId).param.ProblemID
        case 'CP'
            D=computeHessiaCP(data,Policies(taskId).policy.theta.sigma);
        case 'SM'
            D=computeHessiaSM(data,Policies(taskId).policy.theta.sigma);
        case 'DM'
            D=computeHessiaDM(data,Policies(taskId).policy.theta.sigma);
        case 'BK'
            D=computeHessiaBK(data,Policies(taskId).policy.theta.sigma);
        case 'HC'
            D=computeHessiaHC(data,Policies(taskId).policy.theta.sigma);
        case 'DCP'
            D=computeHessiaDCP(data,Policies(taskId).policy.theta.sigma);
    end
    HessianArray(taskId).D=D;
    ParameterArray(taskId).alpha=Policies(taskId).policy.theta.k;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
    % Perform PGInterELLAGroupUpdate
    [model,allowedTasks]=updatePGinterGroupELLA(model,taskId,ObservedTasks,HessianArray,ParameterArray,Tasks); % Perform PGELLA for that Group 
%--------------------------------------------------------------------------
    % Perform PGInterELLAGroupUpdate
    [modelPGELLA]=updatePGELLA(modelPGELLA,taskId,ObservedTasks,HessianArray,ParameterArray,Tasks); % Perform PGELLA for that Group 
%--------------------------------------------------------------------------

     counter=counter+1;  
     disp(['Iterating @: ',num2str(counter)])
end

%% Testing Phase
%--------------------------------------------------------------------------
% Creating PGInterGroup ELLA Policies 
clear data 
clear dataInerELLA
clear dataPGELLA
clear PolicyInterELLAGroup
clear PolicyPGELLAGroup
clear PGPol
clear Avg_rELLA
clear Avg_rPGELLA
clear Avg_rPG
clear Sum_rELLA
clear Sum_rPGELLA
clear Sum_rPG
% Creating Normal PG policy 
[PGPol]=constructPolicies(Tasks);

for i=1:size(Tasks,2) % loop over all tasks
    % Take the task and determine to which group it belongs 
    G_Task=Tasks(i).param.Group; 

    % This is for PGinterELLA
    Psi=model(G_Task).Proj.Psi;
    theta_Task=Psi*model(1).L*model(1).S(:,i);
    policy.theta.k=theta_Task;
    policy.theta.sigma=PGPol(i).policy.theta.sigma;
    policy.type=3; 
    policy.case='PG';
    PolicyInterELLAGroup(i).policy=policy;
    % This is for PG-ELLA
    theta_PG_ELLA = modelPGELLA(G_Task).L*modelPGELLA(1).S(:,i);
    policyPGELLA.theta.k=theta_PG_ELLA;
    policyPGELLA.theta.sigma=PGPol(i).policy.theta.sigma;
    policyPGELLA.type=3; 
    policyPGELLA.case='PG';
    PolicyPGELLAGroup(i).policy=policyPGELLA;
    
end

%% Test PG-Inter-ELLA
%--------------------------------------------------------------------------
nIter=200;%1500

for k=1:size(Tasks,2) % Test over all tasks 
    
   for m=1:nIter % Loop over Iterations
%--------------------------------------------------------------------------
% PG
%--------------------------------------------------------------------------
        [data]=obtainData(PGPol(k).policy,TrajLength,NumRollouts,Tasks(k).param);
        % Compute Derivative of Pay-off function 

        if strcmp(Tasks(k).param.baselearner,'REINFORCE')
            dJdTheta = episodicREINFORCE(PGPol(k).policy,data,Tasks(k).param);
        else
            dJdTheta = episodicNaturalActorCritic(PGPol(k).policy,data,Tasks(k).param);
        end
        
        % Update Policy Parameters
        PGPol(k).policy.theta.k=PGPol(k).policy.theta.k ...
                                            +1*LearningRates(k)*dJdTheta;
                                        

                                        
%--------------------------------------------------------------------------
% PG-ELLA
%--------------------------------------------------------------------------
        [dataPGELLA]=obtainData(PolicyPGELLAGroup(k).policy,TrajLength,NumRollouts,Tasks(k).param);
        % Compute Derivative of Pay-off function         
        if strcmp(Tasks(k).param.baselearner,'REINFORCE')
            dJdThetaPGELLA = episodicREINFORCE(PolicyPGELLAGroup(k).policy,dataPGELLA,Tasks(k).param);
        else
            dJdThetaPGELLA = episodicNaturalActorCritic(PolicyPGELLAGroup(k).policy,dataPGELLA,Tasks(k).param);
        end
        % Update Policy Parameters
    
        PolicyPGELLAGroup(k).policy.theta.k=PolicyPGELLAGroup(k).policy.theta.k ...
                                            +1*LearningRates(k)*dJdThetaPGELLA;  
%--------------------------------------------------------------------------
% GroupInterELLA 
%--------------------------------------------------------------------------
        [dataInterELLA]=obtainData(PolicyInterELLAGroup(k).policy,TrajLength,NumRollouts,Tasks(k).param);
        % Compute Derivative of Pay-off function         
        if strcmp(Tasks(k).param.baselearner,'REINFORCE')
            dJdThetaInterELLA = episodicREINFORCE(PolicyInterELLAGroup(k).policy,dataInterELLA,Tasks(k).param);
        else
            dJdThetaInterELLA = episodicNaturalActorCritic(PolicyInterELLAGroup(k).policy,dataInterELLA,Tasks(k).param);
        end
        % Update Policy Parameters
 
        PolicyInterELLAGroup(k).policy.theta.k=PolicyInterELLAGroup(k).policy.theta.k ...
                                             +1*LearningRates(k)*dJdThetaInterELLA; 

%--------------------------------------------------------------------------
% Computing Average in one System per iteration
%--------------------------------------------------------------------------
            for z=1:size(data,2)
               Sum_rPG(z,:)=sum(data(z).r);
            end
            for z=1:size(dataPGELLA,2)
               Sum_rPGELLA(z,:)=sum(dataPGELLA(z).r);
            end
            for z=1:size(dataInterELLA,2)
                Sum_rELLA(z,:)=sum(dataInterELLA(z).r);
            end
                
              Avg_rELLA(m,k)=mean(Sum_rELLA);
              Avg_rPGELLA(m,k)=mean(Sum_rPGELLA);
              Avg_rPG(m,k)=mean(Sum_rPG);
                % Just for fun
                figure(k)
                plot(m,mean(Sum_rELLA),'r*')
                hold on 
                plot(m,mean(Sum_rPGELLA),'g*')                
                plot(m,mean(Sum_rPG),'b*')
                drawnow
%--------------------------------------------------------------------------
   end
   %end
end

%% Plotting Phase

clear Toplot_rELLA
clear Toplot_rPGELLA
clear Toplot_rPG

 for i=1:size(Avg_rELLA,1) % Loop over iterations
     Toplot_rELLA(i,:)=mean(Avg_rELLA(i,:)); % Average over each column
 end
 for i=1:size(Avg_rPGELLA,1) % Loop over iterations
     Toplot_rPGELLA(i,:)=mean(Avg_rPGELLA(i,:)); % Average over each column
 end
 for i=1:size(Avg_rPG,1)
    Toplot_rPG(i,:)=mean(Avg_rPG(i,:));
 end

figure
[Y20]=fastsmooth(Toplot_rPG,10,1,1);
plot(Y20,'b--','Linewidth',2)
hold on 

[Y1]=fastsmooth(Toplot_rELLA,10,1,1);
plot(Y1,'-.r','Linewidth',2)
hold on 

[Y1]=fastsmooth(Toplot_rPGELLA,10,1,1);
plot(Y1,'-.g','Linewidth',2)
hold on

grid on 

legend('PG','PGInterELLA','PG-ELLA')