function w = episodicNaturalActorCritic(policy, data,param)

gamma = param.gamma;
N = param.N;
M = param.M;

% OBTAIN EXPECTED RETURN
J = 0;
if(gamma == 1)
    for Trials = 1 : max(size(data))   
        J = J + sum(data(Trials).r)/max(size(data(Trials).r));
    end   
    J = J / max(size(data));
end
    
% OBTAIN GRADIENTS
i=1;  
for Trials = 1 : max(size(data))   
    Mat(i,:) = [zeros(size(DlogPiDThetaNAC(policy, data(Trials).x(:,1),data(Trials).u(:,1),param)')) 1];
    Vec(i,1) = 0;       
    for Steps = 1 : max(size(data(Trials).u))
        x = data(Trials).x(:,Steps); u = data(Trials).u(:,Steps); 
        Mat(i,:) = Mat(i,:) + gamma^(Steps-1)*[DlogPiDThetaNAC(policy, x,u,param)' 0];
        Vec(i,1) = Vec(i,1) + gamma^(Steps-1)*(data(Trials).r(Steps)-J);
    end
    i = i+1;  
end

% cond(Mat);
Nrm = diag([1./std(Mat(:,1:N*M),0,1),1]);
% Nrm = diag([1./std(Mat(:,1:(N+1)),0,1),1]);
w = Nrm*inv(Nrm*Mat'*Mat*Nrm)*Nrm*Mat'*Vec;
w = w(1:(max(size(w)-1)));