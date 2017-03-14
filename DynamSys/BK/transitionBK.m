function xn=transitionBK(x,u,param)
%--------------------------------------------------------------------------

D = param.m*param.a*param.h;
J = param.m*param.h^2;
V = 20;

k1 = param.b^2/(param.m*param.a*param.c*sin(param.lambda)*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda)));
k2 = param.b*param.g/(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda));

A = [0 1;
    -param.m*param.g^2*(param.b*param.h*cos(param.lambda)-param.a*param.c*sin(param.lambda))/(J*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda))) -D*V*param.g/(J*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda)))];

B = [0 0;
    param.b*(V^2*param.h-param.a*param.c*param.g)/(J*param.a*param.c*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda))) D*V*param.b/(J*param.a*param.c*param.m*(V^2*sin(param.lambda)-param.b*param.g*cos(param.lambda)))];

xdot=A*x+B*u; 
%--------------------------------------------------------------------------
xnD=x+param.dt*xdot;
%--------------------------------------------------------------------------
% Fixing Limits 
xnD(1)=wrapToPi(xnD(1));
% xnD(2)=wrapToPi(xnD(2));
xn=xnD;
%--------------------------------------------------------------------------