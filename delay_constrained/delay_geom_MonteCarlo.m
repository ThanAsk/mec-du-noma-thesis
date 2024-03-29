function [] = delay_geom_MonteCarlo(B,N,weights,Dmin,Dmax,rounds)

gains = 'random';


%Weight vector
w = weights;

%Set range of  maximum acceptable delays (in seconds)
Drange = int8(10*(Dmax-Dmin)+1);

sum_energies = zeros(1,Drange);
iter = 0;

while iter < rounds
[gi,gj] = set_gains(gains);
current_energies = zeros(1,Drange);
for Tmax = Dmin:0.1:Dmax
 
[min_energy,~,~] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w);

T_idx = int8(10*(Tmax-Dmin)+1);
current_energies(T_idx) = min_energy;
end
sum_energies = sum_energies + current_energies;
iter = iter + 1;
end
sum_energies = (1/rounds)*sum_energies;
% cl=length(current_energies);
% cs = length(sum_energies);
hold on;
%Total energy plot
fig2 = plot(Dmin:0.1:Dmax,sum_energies,'-*','DisplayName',gains);
xlabel('Maximum acceptable delay(s)')
ylabel('Weighted Sum of Energies')
legend


path='C:\Users\askht\Desktop\autofigs4';
saveas(fig2,fullfile(path,['delay_geom_MonteCarlo' append('w',num2str(w(1)),num2str(w(2)),'D',num2str(Dmin),num2str(Dmax)) '.jpeg']));
hold off;
figure;
end





