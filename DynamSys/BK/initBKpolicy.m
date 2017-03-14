function policy=initBKpolicy(param)

policyType=param.polType;

if strcmpi(policyType,'Gauss')
   policy=initGaussPolicy(param);
else
    error('Undefined Policy Type')
end
