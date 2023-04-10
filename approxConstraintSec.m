function c = approxConstraintSec(z,r,ei,g,p0,k)

p = [z(k),ei(k)];
z0 = p0(1);
ei0 = p0(2);

gradh = [exp(z0)*ln(exp(z0)+g*exp(ei0))+exp(z0)^2/(exp(z0)+g*exp(ei0)),g*exp(ei0)*exp(z0)/(exp(z0)+g*exp(ei0))];
taylor = exp(z0)*ln(exp(z0)+g*exp(ei0)) - transpose(gradh)*(p-p0);

c = exp(z(k))*z(k) + r(k)*log(2) - taylor;
end

