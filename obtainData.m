function data = obtainData(policy, L, H,param)

% Based on Jan Peters; codes. 
% Perform H episodes
for trials=1:H
    % Save associated policy
    data(trials).policy = policy;
      
    % Draw the first state
    data(trials).x(:,1) = drawStartState(param);

    % Perform a trial of length L
    for steps=1:L 
        % Draw an action from the policy
        data(trials).u(:,steps)   = drawAction(policy, data(trials).x(:,steps),param);
        % Obtain the reward from the 
        data(trials).r(steps)   = rewardFnc(data(trials).x(:,steps), data(trials).u(:,steps),param);
        % Draw next state from environment      
        data(trials).x(:,steps+1) = drawNextState(data(trials).x(:,steps), data(trials).u(:,steps),param);
    end
end