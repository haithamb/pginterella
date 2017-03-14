function [Hessian]=computeHessiaCP(data,sigma)


nRollouts=size(data,2); 
Hes=zeros(4);

for i=1:nRollouts
    
    roll=data(i).x(1,:);
    rollsum = sum(roll);
    Reward=data(i).r; 
    rollSquare=sum(roll.^2);
    rolldot=data(i).x(2,:);
    rolldotsum=sum(rolldot);
    rolldotSquare=sum(rolldot.^2);
    RewardDum=sum(Reward); 
%     Matrix=([rollSquare/sigma(1) 0 rollsum*rolldotsum/sigma(1) 0; 
%             0 rollSquare/sigma(2) 0 rollsum*rolldotsum/sigma(2);
%             rollsum*rolldotsum/sigma(1) 0 rolldotSquare/sigma(1) 0;
%             0 rollsum*rolldotsum/sigma(2) 0 rolldotSquare/sigma(2)]*RewardDum);
       
%             Matrix=([rollSquare/sigma(1) 0 0 0; 
%             0 rollSquare/sigma(2) 0 0;
%             0 0 rolldotSquare/sigma(1) 0;
%             0 0 0 rolldotSquare/sigma(2)]*RewardDum);
        
            Matrix=([rollSquare 0 0 0; 
            0 rollSquare 0 0;
            0 0 rolldotSquare 0;
            0 0 0 rolldotSquare]*RewardDum);
        
    Hes=Hes+Matrix; 
end

Hessian=-Hes*1./nRollouts;