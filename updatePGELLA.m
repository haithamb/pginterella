function [ELLAmodel]=updateELLA(ELLAmodel,taskId,ObservedTasks,HessianArray,ParameterArray,Tasks)
% taskId
% HessianArray 
Tasks(taskId).param.ProblemID
 %pause
%--------------------------------------------------------------------------
% Update L -- Tasks(taskId).param.Group --> Know which Group .. 
%--------------------------------------------------------------------------

[AllTasks]=find(ObservedTasks);
% from the observed tasks, determine which groups we have .. 
for l=1:length(AllTasks)
    GroupsPresentD(l,:)=Tasks(AllTasks(l)).param.Group; 
end
GroupsPresent=unique(GroupsPresentD); % This groups [2 2 3 3 4] --> [2 3 4];
for z=1:length(GroupsPresent) % sum over the goals ... 
    % determine from observed tasks which ones are allowed 
    [allowedTaskIndexD]=getAllowedTasks(GroupsPresent(z,:),ObservedTasks,Tasks);
    allowedTaskIndexG{z}=allowedTaskIndexD(find(allowedTaskIndexD)); 
end
% Having determined the allowed tasks, compute the derivative 

sumAllOne=0;

TasksforGroupz=allowedTaskIndexG{find(GroupsPresent==Tasks(taskId).param.Group)};

sum=zeros(size(ELLAmodel(Tasks(taskId).param.Group).L));

Tg=length(TasksforGroupz);
% Tg=size(allowedTaskIndexG{find(GroupsPresent==Tasks(taskId).param.Group)},1);
for i=1:Tg
    sum=sum-2*HessianArray(TasksforGroupz(i)).D*ParameterArray(TasksforGroupz(i)).alpha*ELLAmodel(1).S(:,i)' ...
            +2*HessianArray(TasksforGroupz(i)).D*ELLAmodel(Tasks(taskId).param.Group).L*ELLAmodel(1).S(:,i)*ELLAmodel(1).S(:,i)' ...
            +2*ELLAmodel(1).mu_two*ELLAmodel(Tasks(taskId).param.Group).L; 
end

ELLAmodel(Tasks(taskId).param.Group).L=(ELLAmodel(Tasks(taskId).param.Group).L-ELLAmodel(1).learningRate*1./Tg*sum);

%--------------------------------------------------------------------------
% Update s_{taskId} using LASSO
%--------------------------------------------------------------------------
% Determine which group taskId belongs to 
Dsqrt = HessianArray(taskId).D^.5;
%Dsqrt = sqrtm(HessianArray(idxTask).D);
target = Dsqrt*ParameterArray(taskId).alpha;
dictTransformed = Dsqrt*ELLAmodel(Tasks(taskId).param.Group).L;

s = full(mexLasso(target,dictTransformed,struct('lambda',ELLAmodel(1).mu_one/2)));
ELLAmodel(1).S(:,taskId)=s; 
