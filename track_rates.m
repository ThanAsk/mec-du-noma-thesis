
[gi,gj] = set_gains('constant');
pmax = 20;
%[c1,c2] = ndgrid(1:-0.1:0);
Ri1s = zeros(11,11);
Rj1s = zeros(11,11);
c1 = 1:-0.1:0;
c2 = 1:-0.1:0;

for i = 1:10
    for j = 1:10

        pi = [c1(i)*ones(1,4)*pmax,c2(j)*ones(1,4)*pmax];
        pj = [c2(j)*ones(1,4)*pmax,c1(i)*ones(1,4)*pmax];

        [Ri,Rj] = compute_rates(gi,gj,pi,pj);
        Ri1s(i,j)= Ri(2);
        Rj1s(i,j) = Rj(2);
     
        
    end
end
 mesh(1:-0.1:0,1:-0.1:0,Ri1s);
 [m,idx] = max(Ri1s,[],'all');
 [row,col] = ind2sub([11,11],idx);
 c1_max = c1(row);
 c2_max = c2(col);
 hold on 
  %mesh(1:-0.1:0,1:-0.1:0,Rj1s);
        