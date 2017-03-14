function [PGPol]=constructPolicies(Tasks,polType)

for i=1:size(Tasks,2)
    switch Tasks(i).param.ProblemID
        case 'CP'
            [policy]=initCPpolicy(Tasks(i).param,polType);
        case 'SM'
            [policy]=initSMpolicy(Tasks(i).param,polType);
        case 'DM'
            [policy]=initDMpolicy(Tasks(i).param,polType);
        case 'BK'
            [policy]=initBKpolicy(Tasks(i).param,polType);
        case 'HC'
            [policy]=initHCpolicy(Tasks(i).param,polType);
        case 'DCP'
            [policy]=initDCPpolicy(Tasks(i).param,polType);
    end
         PGPol(i).policy=policy;
end