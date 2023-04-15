function c = approxConstraint(x,x0,N)
%x = [z,r] z,r:vectors of times(z) and rates (r) for k = 1,...8
% c is given as a DC (difference of convex) function: c = g - h  and
% the concave part is Taylor-approximated around p0 = [z0,ei0,ej0]:
% c = g - h(p0) + gradh(p0).'*(p - p0) 
% 

z0 = x0(1:8);
r0 = x0(9:16);

gradk = @(k,z,r)exp(z(k)+r(k))/sum(exp(z+r));
gradh = [arrayfun(@(k)gradk(k,z0,r0),1:8),arrayfun(@(k)gradk(k,z0,r0),1:8)];


taylor = log(sum(exp(z0+r0))) + dot(gradh,(x-x0));
c = log(N) - taylor;

end