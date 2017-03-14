function xn = drawNextState(x,u,param);
% Based on Jan Peters' code. 

switch param.ProblemID
    case 'SM'
        xn=transitionSM(x,u,param);
    case 'CP'
        xn=transitionCP(x,u,param);
    case 'BK'
        xn=transitionBK(x,u,param);                
    case 'HC'
        xn=transitionHC(x,u,param);
    case 'DM'
        xn=transitionDM(x,u,param);
    case 'DCP'
        xn=transitionDCP(x,u,param);                
end
