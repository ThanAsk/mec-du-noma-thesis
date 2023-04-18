%syms zk aj  c
%solve (2^zk*(1+ai/(zk+aj)) == 2^c)
%s = solve(zk*log(1+ai/(zk+aj))== c);
%solve(zk*log2(1+aj/zk) == c,zk)

syms x b A
solve((1+b*x)*exp(x) == A,x)