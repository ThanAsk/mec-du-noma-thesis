function [] = delay_geom_compare_lin_geom(B,N,weights,Dmin,Dmax)
   
[gi,gj] = set_gains('distant');

%Weight vector
w = weights;
marker = {'o','square','diamond'};
i = 1;

%Set range of  maximum acceptable delays (in seconds)
Drange = int8(10*(Dmax-Dmin)+1);

for pdb = [10 20 30]
lin_energies = zeros(1,Drange);
%geom_energies = zeros(1,Drange);
pmax = 10^(pdb/10);

for Tmax = Dmin:0.1:Dmax
 
[lin_energy,~,~,~] = optimize_energy(Tmax,pmax,B,N,gi,gj,w);    
%[geom_energy,~,~] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w);

T_idx = int8(10*(Tmax-Dmin)+1);
lin_energies(T_idx) = lin_energy;
%geom_energies(T_idx) = geom_energy;


end

hold on;
label = strcat('SNR = ',num2str(pdb));

plot( Dmin:0.1:Dmax,lin_energies,"LineStyle","-","Marker",marker{i},"Color","r","DisplayName",label);
%plot( Dmin:0.1:Dmax,geom_energies,"LineStyle","--","Marker",marker{i},"Color","b","DisplayName",label);

xlabel('Maximum acceptable delay(s)')
ylabel('Weighted Sum of Energies')
legend

i = i + 1;
end



end

