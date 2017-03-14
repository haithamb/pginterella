function  [xn]=transitionDM(x,u,param)

A=[0 0 1 0;
    0 0 0 1;
     -(param.k1+param.k2)./(param.MassOne) (param.k2./param.MassOne) -(param.d1+param.d2)./param.MassOne param.d2./param.MassOne;
      param.k2./param.MassTwo -param.k2./param.MassTwo param.d2./param.MassTwo -param.d2./param.MassTwo];
 b=[0;0;0;1./(param.MassTwo)]; 
 
 xdot=A*x+b*u; 
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
%  