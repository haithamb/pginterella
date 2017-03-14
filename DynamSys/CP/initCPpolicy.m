function policy=initCPpolicy(param,polType)

policyType=param.polType; 

if strcmpi(policyType,'Gauss')
   policy=initGaussPolicy(param);
elseif strcmpi(polType,'LQR')
   
else
    error('Undefined Policy Type')
end
