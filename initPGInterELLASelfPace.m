function [model]=initPGInterELLASelfPace(Tasks,d,k ...
                                         ,mu_one,mu_two,mu_three ...
                                     ,learningRate,learningRatePsi ...
                                 ,learningRateWeights,learningRateL21)
model.T_Total=size(Tasks,2);
model.L=rand(d,k);
model.S=rand(k,size(Tasks,2));
%model.w = rand(size(Tasks,2),1); % Weights
model.mu_one=mu_one;
model.mu_two=mu_two; 
model.mu_three=mu_three;
model.learningRate=learningRate; 
model.learningRatePsi=learningRatePsi;
model.learningRateWeights =learningRateWeights;
model.learningRateWeightsL21 =learningRateL21;
%for i=1:size(Tasks,2) % To initialize Psi with correct dimensions 
%    model(i).Psi=rand(Tasks(i).param.N,d);
%    model(i).s=rand(k,1);
%end
% Determine the number of Groups
%GroupsArray=[];
for i=1:size(Tasks,2) % To initialize Psi with correct dimensions 
    GroupsArray(i)=Tasks(i).param.Group;
end

unique_Groups = unique(GroupsArray); 

%counter is the number of tasks in each group;

for l=1:size(unique_Groups,2) 
    counter(l,:) = size(find(GroupsArray == unique_Groups(l)),2);
end
model.TasksPerGroup =counter; 
for f=1:size(unique_Groups,2)
    model(f).w = rand(counter(f,:),1);
end

[Value]=max(GroupsArray);

model(1).TotalGroups= Value; 
for k=1:Value
    for z=1:size(Tasks,2)
        if Tasks(z).param.Group==k
            model(k).Proj.Psi=rand(Tasks(z).param.N*Tasks(z).param.M,d); % Init Psi_{g} Original index Tasks(z).param.N
            model(k).Proj.Group=k;
            break % Observing only one task in Group k is enough to init Psi 
        end
    end
end
