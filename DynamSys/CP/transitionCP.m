function xn=transitionCP(x,u,param)
commonD=param.I*(param.mc+param.mp)+param.mc*param.mp*param.l^2;


A=[0 1 0 0;
   0 -((param.I+param.mp*param.l^2)*param.d)./commonD param.mp^2*param.g*param.l^2 0;
    0 0 0 1;
    0 -(param.mp*param.l*param.d)./commonD  (param.mp*param.g*param.l*(param.mc+param.mp))./commonD 0];



b=[0;(param.I+param.mp*param.l^2)./commonD;0;(param.mp*param.l)./commonD];
xnDum=A*x+b*u;
xn=x+param.dt*xnDum;
if xn(1)>5 
    xn(1)=5; 
end 
if xn(1) < -5 
    xn(1) = -5; 
end 
%if xn(2) > 20 
%    xn(2) = 20; 
%end 
%if xn(2) < -20 
%    xn(2) =-20;
%end

xn(3)=wrapToPi(xn(3)); % Check Angle ... 

%if xn(4) > 20 
    %xn(4) =20; 
%end
%if xn(4) < -20 
%    xn(4) = -20; 
%end