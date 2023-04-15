
x = 1:100;
y = 1:100;
[xx,yy] = meshgrid(x,y);
%z = xx.*log(1+yy);
z =xx.*exp(0.1*yy);
surf(x,y,z)


