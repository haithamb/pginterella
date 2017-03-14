function [model]=initPGInterELLA(Tasks,d,k ...
                                         ,mu_one,mu_two,mu_three ...
                                     ,learningRate,learningRatePsi)
model.T=0;
model.L=rand(d,k);
model.S=zeros(k,size(Tasks,2));
model.mu_one=mu_one;
model.mu_two=mu_two; 
model.mu_three=mu_three;
model.learningRate=learningRate; 
model.learningRatePsi=learningRatePsi;

%for i=1:size(Tasks,2) % To initialize Psi with correct dimensions 
%    model(i).Psi=rand(Tasks(i).param.N,d);
%    model(i).s=rand(k,1);
%end
% Determine the number of Groups
%GroupsArray=[];
for i=1:size(Tasks,2) % To initialize Psi with correct dimensions 
    GroupsArray(i)=Tasks(i).param.Group;
end

[Value]=max(GroupsArray);

for k=1:Value
    for z=1:size(Tasks,2)
        if Tasks(z).param.Group==k
            model(k).Proj.Psi=rand(Tasks(z).param.N*Tasks(z).param.M,d); % Init Psi_{g} Original index Tasks(z).param.N
            model(k).Proj.Group=k;
            break % Observing only one task in Group k is enough to init Psi 
        end
    end
end
