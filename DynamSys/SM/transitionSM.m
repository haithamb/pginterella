function xn=transitionSM(x,u,param)

A=[0 1; -param.k/param.Mass -param.d/param.Mass];
b=[0;1/param.Mass];
xd=A*x+b*u; 
xn=x+param.dt*xd;

% fixing the limits 

if xn(1)>20
    xn(1)=20;
end
if xn(1) < -20 
    xn(1) =-20; 
end
%if xn(2) > 100
%    xn(2) =100;
%end
%if xn(2) < -100 
%    xn(2)= -100; 
%end