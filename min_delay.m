 function d = min_delay(c,pmax,K,B,N,gi,gj)
         
         c1 = c(1);
         c2 = c(2);
         pi = [c1*pmax*ones(1,4),c2*pmax*ones(1,4)];
         pj = [c2*pmax*ones(1,4),c1*pmax*ones(1,4)];


         [Ri,Rj] = compute_rates(gi,gj,pi,pj);

         %linear optimization
        
         %objective function
         s = ones(1,8); % sum

         %inequality constraints
         C_1 = B*Ri;
         C_2 = B*Rj;
         C_3 = [c1*ones(1,4)*pmax,c2*ones(1,4)*pmax];
         C_4 = [c2*ones(1,4)*pmax,c1*ones(1,4)*pmax];
         C = [-C_1;-C_2;C_3;C_4] ;


         b = [-N -N K*pmax K*pmax];

         %lb = 0.15*ones(1,8);
         lb = zeros(1,8);
         ub = Inf*ones(1,8);

         %solution
         
         [~,d]= linprog(s,C,b,[],[],lb,ub);
          
            
    end
