function [model]=initPGELLA(Tasks,k,mu_one,mu_two,learningRate)

model.T=0;
model.S=zeros(k,size(Tasks,2));
model.mu_one=mu_one;
model.mu_two=mu_two; 
model.learningRate=learningRate; 

% Determine the number of Groups
for i=1:size(Tasks,2) % To initialize Psi with correct dimensions 
    GroupsArray(i)=Tasks(i).param.Group;
end

[Value,Idx]=max(GroupsArray);

for l=1:Value
    for z=1:size(Tasks,2)
        if Tasks(z).param.Group==l
            model(l).L=rand(Tasks(z).param.N*Tasks(z).param.M,k);
            break % Observing only one task in Group k is enough to init Psi 
        end
    end
end