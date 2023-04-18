function c = approxConstraint_n(x,x0)
%x = [z,r] z,r:vectors of times(z) and rates (r) for k = 1,...8
% c is given as a DC (difference of convex) function: c = g - h  and
% the concave part is Taylor-approximated around p0 = [z0,ei0,ej0]:
% c = g - h(p0) + gradh(p0).'*(p - p0) 
% 

z = x(1:8);
r = x(9:16);
n = x(17:24);

n0 = x0;


taylor = - log(n0)-(1/n0)*(n-n0);
c = - taylor - (z+r);

end