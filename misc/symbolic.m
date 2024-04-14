%syms zk aj  c
%solve (2^zk*(1+ai/(zk+aj)) == 2^c)
%s = solve(zk*log(1+ai/(zk+aj))== c);
%solve(zk*log2(1+aj/zk) == c,zk)

%syms x b A
%solve((1+b*x)*exp(x) == A,x)

%[z,val] = fsolve(@(x)x*log(1+20/(20+x))-0.5,1) 
clear
syms A [4 4]
syms yi yj [4 1] 
A(:,1) = log(1+yi);
A(:,2) = log(1+yj);
syms gi gj  gii gjj [4 1]
A(:,3) = yi./gi +(gj./(gi.*gjj)).*yi.*yj;
A(:,4) = yj./gjj;
l = linsolve(A,ones(4,1));
%diff(l(1),yi1)
jacobian(l,yi)