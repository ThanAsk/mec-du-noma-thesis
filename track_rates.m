
[gi,gj] = set_gains('sym_random');
pmax = 20;
%[c1,c2] = ndgrid(1:-0.1:0);
Ris = zeros(11,11,8); 
Rjs = zeros(11,11,8);
c1 = 1:-0.1:0;
c2 = 1:-0.1:0;

for i = 1:10
    for j = 1:10

        pi = [c1(i)*ones(1,4)*pmax,c2(j)*ones(1,4)*pmax];
        pj = [c2(j)*ones(1,4)*pmax,c1(i)*ones(1,4)*pmax];

        [Ri,Rj] = compute_rates(gi,gj,pi,pj);
       for phase = 1:8
        Ris(i,j,phase)= Ri(phase);
        Rjs(i,j,phase) = Rj(phase);
       end
     
        
    end
end

    

tiledlayout(2,8)

for phase = 1:8
    nexttile
    mesh(1:-0.1:0,1:-0.1:0,Ris(:,:,phase));
    title(['Ri',num2str(phase),''])

    nexttile(8+phase)
    mesh(1:-0.1:0,1:-0.1:0,Rjs(:,:,phase));
    title(['Rj',num2str(phase),''])
    %  [m,idx] = max(Ri1s,[],'all');
    %  [row,col] = ind2sub([11,11],idx);
    %  c1_max = c1(row);
    %  c2_max = c2(col);

end


  %mesh(1:-0.1:0,1:-0.1:0,Rj1s);
        