function [Hessian]=computeHessiaCP(data,sigma)


nRollouts=size(data,2); 
Hes=zeros(6);

for i=1:nRollouts
    
    phi1=sum(data(i).x(1,:)); 
    phi2=sum(data(i).x(2,:)); 
    phi3=sum(data(i).x(3,:)); 
    phi4=sum(data(i).x(4,:)); 
    phi5=sum(data(i).x(5,:)); 
    phi6=sum(data(i).x(6,:)); 
    
    phi1Square=phi1.^2; 
    phi2Square=phi2.^2;
    phi3Square=phi3.^2;
    phi4Square=phi4.^2;
    phi5Square=phi5.^2;
    phi6Square=phi6.^2;
    
    Reward=data(i).r; 
    RewardDum=sum(Reward); 
%     Matrix=([phi1Square/sigma(1) 0 phi1*phi2/sigma(1) 0 phi1*phi3/sigma(1) 0 phi1*phi4/sigma(1) 0;
%         0 phi1Square/sigma(2) 0 phi1*phi2/sigma(2) 0 phi1*phi3/sigma(2) 0 phi1*phi4/sigma(2);
%         phi1*phi2/sigma(1) 0 phi2Square/sigma(1) 0 phi2*phi3/sigma(1) 0 phi2*phi4/sigma(1) 0;
%         0 phi1*phi2/sigma(2) 0 phi2Square/sigma(2) 0 phi2*phi3/sigma(2) 0 phi2*phi4/sigma(2);
%         phi1*phi3/sigma(1) 0 phi2*phi3/sigma(1) 0 phi3Square/sigma(1) 0 phi3*phi4/sigma(1) 0;
%         0 phi1*phi3/sigma(2) 0 phi2*phi3/sigma(2) 0 phi3Square/sigma(2) 0 phi3*phi4/sigma(2);
%         phi1*phi4/sigma(1) 0 phi2*phi4/sigma(1) 0 phi3*phi4/sigma(1) 0 phi4Square/sigma(1) 0;
%         0 phi1*phi4/sigma(2) 0 phi2*phi4/sigma(2) 0 phi3*phi4/sigma(2) 0 phi4Square/sigma(2)]*RewardDum);

%         Matrix=([phi1Square/sigma(1) 0 0 0 0 0;
%         0 phi2Square/sigma(1) 0 0 0 0 ;
%         0 0 phi3Square/sigma(1) 0 0 0;
%         0 0 0 phi4Square/sigma(1) 0 0;
%         0 0 0 0 phi5Square/sigma(1) 0;
%         0 0 0 0 0 phi6Square/sigma(1)]*RewardDum);     
    
        Matrix=([phi1Square 0 0 0 0 0;
        0 phi2Square 0 0 0 0 ;
        0 0 phi3Square 0 0 0;
        0 0 0 phi4Square 0 0;
        0 0 0 0 phi5Square 0;
        0 0 0 0 0 phi6Square]*RewardDum);     

    
    Hes=Hes+Matrix; 
end

Hessian=-Hes*1./nRollouts;