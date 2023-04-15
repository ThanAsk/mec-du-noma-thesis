function c = approxConstraintSec(z,r,ei,g,p0,k)

p = [z(k),ei(k)];
if k > 4
z0 = p0(k);
ei0 = p0(k+8);
else 
z0 = p0(k);
ei0 = p0(k+16);
end
p0 = [z0,ei0];
g = g(k);



gradh = [exp(z0)*log(exp(z0)+g*exp(ei0))+exp(z0)^2/(exp(z0)+g*exp(ei0)),g*exp(ei0)*exp(z0)/(exp(z0)+g*exp(ei0))];
taylor = exp(z0)*log(exp(z0)+g*exp(ei0)) + dot(gradh,(p-p0));

c = exp(z(k))*z(k) + r(k)*log(2) - taylor;
end

