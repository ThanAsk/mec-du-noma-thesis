
x = 1:100;
y = 1:100;
[xx,yy] = meshgrid(x,y);
%z = xx.*log(1+yy);
%z =xx.*exp(0.1*yy);
%z = log(exp(log(2)*exp(xx))-1) + log(exp(-yy)+exp(-yy+1)); 
z = xx.*log((1 + 2*yy)./(1+50*yy));
surf(x,y,z)


