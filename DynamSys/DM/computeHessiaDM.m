function [Hessian]=computeHessiaCP(data,sigma)


nRollouts=size(data,2); 
Hes=zeros(4,4);

for i=1:nRollouts
    
    Pos=data(i).x(1,:); 
    Reward=data(i).r; 
    PosSquare=sum(Pos.^2);
    Vel=data(i).x(2,:); 
    VelSquare=sum(Vel.^2);
    PosVel=sum(Pos.*Vel);
    theta=data(i).x(3,:); 
    thetaSquare=sum(theta.^2);
    thetadot=data(i).x(4,:); 
    thetadotSquare=sum(thetadot.^2);
    RewardDum=sum(Reward); 
    %Matrix=1./sigma^2*([PosSquare PosVel; PosVel VelSquare]*RewardDum);
    Matrix=(1./1*[PosSquare 0 0 0; 0 VelSquare 0 0; 0 0 thetaSquare 0; 0 0 0 thetadotSquare]*RewardDum);
    %Matrix=([PosSquare 0 0 0; 0 VelSquare 0 0; 0 0 thetaSquare 0; 0 0 0 thetadotSquare]*RewardDum);
    
    Hes=Hes+Matrix; 
end

Hessian=-Hes*1./nRollouts;