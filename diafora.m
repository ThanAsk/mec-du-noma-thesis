
% x = 1:100;
% y = 1:100;
% [xx,yy] = meshgrid(x,y);
% %z = xx.*log(1+yy);
% %z =xx.*exp(0.1*yy);
% %z = log(exp(log(2)*exp(xx))-1) + log(exp(-yy)+exp(-yy+1)); 
% z = xx.*log((1 + 2*yy)./(1+50*yy));
% surf(x,y,z)

g = 1;
pj_a = 10;
a = g/(1+g*pj_a);

pi_a = 1:30;
pi_b = 1:30;

[pi_a,pi_b] = meshgrid(pi_a,pi_b);

l1 = (1+pi_b./pi_a)./(log(1+g*pi_b)-pi_b./pi_a);
l3 = 1./pi_a - log(1+g*pi_a)./pi_a;
%surf(pi_a,pi_b,l3)

z = zeros(1,900);
e = zeros(1,900);
for k = 1:900
z(k) = a*(l1(k)/l3(k))*lambertw(-1,-(exp((-1./l1(k) + 1)*log(2))*log(2)))./log(2);
e(k) = ((log(2)+lambertw(-1,-(exp((-1./l1(k) + 1)*log(2))*log(2))))./log(2))*(l1(k)/l3(k));
end

plot(z,'o')
plot(e,'o')
z1 = z(imag(z)==0);



