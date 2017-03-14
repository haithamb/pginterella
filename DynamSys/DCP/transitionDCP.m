function  [xn]=transitionDM(x,u,param)

l11 = (param.J1+param.m1*param.l1^2)/(param.m1*param.l1);
l21 = (param.J2+param.m2*param.l2^2)/(param.m2*param.l2);
Delta = param.Ma + param.J1/(param.l1*l11) + param.J2/(param.l2*l21);
        
% System matrices
A = [0 1 0 0 0 0;
0 -param.mu/Delta -param.m1*param.l1*param.g/(l11*Delta) 0 -param.m2*param.l2*param.g/(l21*Delta) 0;
0 0 0 1 0 0;
0 -param.mu/(l11*Delta) param.g/l11*(1+param.m1*param.l1/(l11*Delta)) 0 param.m2*param.l2*param.g/(l11*l21*Delta)     0;
0 0 0 0 0 1;
0 -param.mu/(l21*Delta) param.m1*param.l1*param.g/(l11*l21*Delta) 0 param.g/l21*(1+param.m2*param.l2/(l21*Delta)) 0];

B = [0 1/Delta 0 -1/(l11*Delta) 0 -1/(l21*Delta)]';
 
 xdot=A*x+B*u; 
 xn=x+param.dt*xdot;
%  
%  if xn(1)  > 10 
%      xn(1) =10; 
%  end
%  
%  if xn(1) < -10 
%      xn =-10; 
%  end
%  
%  if xn(2) > 20 
%      xn(2) = 20; 
%  end 
%  if xn(2) < -20 
%      xn(2) =-20; 
%  end
 