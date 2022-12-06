  %rates for each phase
            Ri = zeros(1,8);
            Rj = zeros(1,8);

            %user i decoded first
            %{(i,a),(j,a)}
            Ri(1) = log2(1 + (gi(1)*c1*pmax)/(1+gj(1)*c2*pmax));
            Rj(1) = log2(1 + gj(1)*c2*pmax);

            %{(i,a),(j,b)}
            Ri(2) = log2(1 + (gi(1)*c1*pmax)/(1+gj(1)*c2*pmax));
            Rj(2) = log2(1 + gj(2)*c2*pmax);

            %{(i,b),(j,a)}
            Ri(3) = log2(1 + (gi(2)*c1*pmax)/(1+gj(2)*c2*pmax));
            Rj(3) = log2(1 + gj(1)*c2*pmax);

            %{(i,b),(j,b)}
            Ri(4) = log2(1 + (gi(2)*c1*pmax)/(1+gj(2)*c2*pmax));
            Rj(4) = log2(1 + gj(2)*c2*pmax);


            %User j decoded first
            %{(j,a),(i,a)}
            Rj(5) = log2(1 + (gj(1)*c1*pmax)/(1+gi(1)*c2*pmax));
            Ri(5) = log2(1 + gi(1)*c2*pmax);

            %{(j,a),(i,b)}
            Rj(6) = log2(1 + (gj(1)*c1*pmax)/(1+gi(1)*c2*pmax));
            Ri(6) = log2(1 + gi(2)*c2*pmax);

            %{(j,b),(i,a)}
            Rj(7) = log2(1 + (gj(2)*c1*pmax)/(1+gi(2)*c2*pmax));
            Ri(7) = log2(1 + gi(1)*c2*pmax);

            %{(j,b),(i,b)}
            Rj(8) = log2(1 + (gj(2)*c1*pmax)/(1+gi(2)*c2*pmax));
            Ri(8) = log2(1 + gi(2)*c2*pmax);


% c: oles oi times tis linprog gia c1,c2 se [0,1]
  %percent of pmax
    c_1 = 1:-0.1:0;
    c_2 = 1:-0.1:0;


 c = zeros(10,10);
    for i = 1:10
        for j = 1:10

            c1 = c_1(i);
            c2 = c_2(j);
            pi = [c1*pmax*ones(1,4),c2*pmax*ones(1,4)];
            pj = [c2*pmax*ones(1,4),c1*pmax*ones(1,4)];


            [Ri,Rj] = compute_rates(gi,gj,pi,pj);

            %linear optimization
            %z = [zk,c1,c2];
            %objective function
            s = ones(1,8); % sum

            %inequality constraints
            C_1 = B*Ri;
            C_2 = B*Rj;
            C_3 = [c1*ones(1,4),c2*ones(1,4)];
            C_4 = [c2*ones(1,4),c1*ones(1,4)];
            C = [-C_1;-C_2;C_3;C_4] ;


            b = [-N -N K K];

            %lb = 0.15*ones(1,8);
            lb = zeros(1,8);
            ub = Inf*ones(1,8);

            %solution
            [z,delay]= linprog(s,C,b,[],[],lb,ub);
            
            c(i,j) = sum(z);
        end
    end

    %mesh(1:-0.1:0,1:-0.1:0,c)
