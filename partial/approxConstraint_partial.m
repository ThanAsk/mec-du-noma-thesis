function c = approxConstraint_partial(x,x0,B,N)
%x = [z,r] z,r:vectors of times(z) and rates (r) for k = 1,...8
% c is given as a DC (difference of convex) function: c = g - h  and
% the concave part is Taylor-approximated around p0 = [z0,ei0,ej0]:
% c = g - h(p0) + gradh(p0).'*(p - p0) 
% 

z0 = x0(1:8);
r0 = x0(9:16);
L0 = x0(17);

gradk = @(k,z,r,L)exp(z(k)+r(k))/(sum(exp(z+r))+(1/B)*exp(L));
gradl = (1/B)*exp(L)/(sum(exp(z+r)+(1/B)*exp(L)));
gradh = [arrayfun(@(k)gradk(k,z0,r0,L0),1:8),arrayfun(@(k)gradk(k,z0,r0,L0),1:8),gradl];


taylor = log(sum(exp(z0+r0))+(1/B)*exp(L0)) + dot(gradh,(x-x0));
c = log(N/B) - taylor;

end