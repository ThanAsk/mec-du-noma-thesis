function c = approxConstraintFirst(z,r,ei,ej,gi,gj,p0,k)
%Constraint for phase k , on z,r,ei,ej 
%First : user i is decode first  
% gi gj are gains for phase k of user i,j (scalars)
% c is given as a DC (difference of convex) function: c = g - h  and
% the concave part is Taylor-approximated around p0 = [z0,ei0,ej0]:
% c = g - h(p0) + gradh(p0).'*(p - p0) 
% 

p = [z(k),ei(k),ej(k)];
z0 = p0(k);
ei0 =p0(k+8);
ej0 = p0(k+16);
p0 = [z0,ei0,ej0];
gi = gi(k);
gj = gj(k);


gradh = zeros(1,3);
gradh(1) = exp(z0)*log(exp(z0)+gi*exp(ei0)+gj*exp(ej0))+exp(z0)^2/(exp(z0)+gi*exp(ei0)+gj*exp(ej0));
gradh(2) = gi*exp(z0+ei0)/(exp(z0)+gi*exp(ei0)+gj*exp(ej0));
gradh(3) = gj*exp(z0+ej0)/(exp(z0)+gi*exp(ei0)+gj*exp(ej0));

taylor = exp(z0)*log(exp(z0)+gi*exp(ei0)+gj*exp(ej0)) + dot(gradh,(p-p0));
c = exp(z(k))*log(exp(z(k))+gj*exp(ej(k)))+r(k)*log(2) - taylor;

end

