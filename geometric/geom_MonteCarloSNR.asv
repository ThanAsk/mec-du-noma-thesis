function [] = geom_MonteCarloSNR(N,Kmin,Kmax,p_db,rounds)
% N = N/B (bits/bandwidth) 
%SNR fixed , vary K

%Set SNR

pmax = 10^(p_db/10);

%Set K range
Krange = int8(10*(Kmax-Kmin) + 1);

sum_delays = zeros(1,Krange);
iter = 0;
while iter < rounds

[gi,gj] = set_gains('random');
current_delays = zeros(1,Krange);

for K = Kmin:0.1:Kmax
    [min_delay,~] = geometricOpt3(K,pmax,N,gi,gj);
    
    K_idx = int8(10*(K-Kmin)+1);
    current_delays(K_idx) = min_delay;
    
end
sum_delays = sum_delays + current_delays;
iter = iter + 1;
end
sum_delays = (1/rounds)*sum_delays;

%Delay plot
hold on;
fig = plot(Kmin:0.1:Kmax,sum_delays,'-*','DisplayName','random'); %,'MarkerIndices',1:2:length(sum_delays));
title(['SNR = ',num2str(p_db),'dB'])
xlabel('K(s)')
ylabel('Sum Delay')
legend


path='C:\Users\askht\Desktop\autofigs4';
saveas(fig,fullfile(path,['geomMonteCarloSNR' append(num2str(p_db),'K',num2str(Kmin),num2str(Kmax)) '.jpeg']));
hold off;
figure;
end
        


