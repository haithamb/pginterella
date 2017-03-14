function [learningRates,Policies] = determineLearningRates(Params,Policies,rates)

nSystems = size(Params,2); 
trajlength = 50;
rollouts = 100;
numIterations = 200;
display('Determining Good Learning Rates : ')
for i = 1:nSystems % Loop over systems to learn using each learning rate and determine which is best
    disp(['@ System: ', num2str(i),' ',Params(i).param.ProblemID]);
    policy = Policies(i).policy; % Resetting policy IMP 
    for l = 1:length(rates) % Loop Over All rates
        disp(['... @ Learning Rate: ', num2str(rates(l))]);    
        for k = 1:numIterations % Loop for learning 
            disp(['______@ Iteration: ', num2str(k)]);    
            [data] = obtainData(policy, trajlength,rollouts,Params(i).param);
            if strcmp(Params(i).param.baselearner,'REINFORCE')
                dJdtheta = episodicREINFORCE(policy,data,Params(i).param);
            else
                dJdtheta = episodicNaturalActorCritic(policy,data,Params(i).param);
            end
            policy.theta.k = policy.theta.k+rates(l)*dJdtheta;
            for z = 1:size(data,2) % Loop over rollouts 
                r(z) = sum(data(z).r);
            end
            if isnan(r)
                display(['System has NAN:', num2str(i)])
                display(['..@ learning rate: ', num2str(l)])
                display('breaking this iteration ...')
                break
            end
            reward_perRatesperIteration(k,l) = mean(r);
        end
        temp = mean(reward_perRatesperIteration);
        [value,index] = max(temp);
        learningRates(i) = rates(index);
                        
                                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Commencing with learning to demonstrate that chosen learning rate works
        clc;
        clear r
        R = rand;
        G = rand;
        B = rand;
        policy = Policies(i).policy; % Resetting policy IMP  
        for k = 1:numIterations % 150 Loop for learning 
            disp(['@ Iteration: ', num2str(k)]);    
            [data] = obtainData(policy, trajlength,rollouts,Params(i).param);
            if strcmp(Params(i).param.baselearner,'REINFORCE')
                dJdtheta = episodicREINFORCE(policy,data,Params(i).param);
            else
                dJdtheta = episodicNaturalActorCritic(policy,data,Params(i).param);
            end
            policy.theta.k = policy.theta.k+learningRates(i)*dJdtheta;
            for z = 1:size(data,2) % Loop over rollouts 
                r(z,:) = sum(data(z).r);
            end
            figure(i)
            plot(k,mean(r),'*','Color',[R,G,B])
            hold on 
            drawnow;            
        end            
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    end
    Policies(i).policy = policy; % Calculating theta*
end