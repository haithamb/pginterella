function rew = rewardFnc(x, u,param)

switch param.ProblemID 
    case 'SM'
        rew=-sqrt(x'*x)-sqrt(u'*u);
    case 'CP'
        rew=-sqrt(x'*x)-sqrt(u'*u);
    case 'BK'
        rew=-sqrt(x'*x)-sqrt(u'*u);
    case 'HC'
        Q = [0 1 0 0;0 0 0 57.3]'*[0 1 0 0;0 0 0 57.3];
        rew=-sqrt(x'*x)-sqrt(u'*u);%Q
    case 'DM'
        rew=-sqrt(x'*x)-sqrt(u'*u);
    case 'DCP'
        rew=-sqrt(x'*x)-sqrt(u'*u);
end