function [] = geom_MonteCarloK(N,K,SNRmin,SNRmax,rounds)

SNRrange = SNRmax-SNRmin + 1;
sum_delays = zeros(1,SNRrange);
iter = 0;
while iter < rounds

[gi,gj] = set_gains('random');
current_delays = zeros(1,SNRrange);

for pdb = SNRmin:SNRmax
    pmax = 10^(pdb/10);  
    [min_delay,~] = geometricOpt3(K,pmax,N,gi,gj);

    current_delays(pdb-SNRmin+1) = min_delay;
    
end
sum_delays = sum_delays + current_delays;
iter = iter + 1;
end
sum_delays = (1/rounds)*sum_delays;
        %Delay plot
        hold on;
        fig = plot(SNRmin:SNRmax,sum_delays,'-*','MarkerIndices',1:2:length(sum_delays),'DisplayName','random');
        title(['K = ',num2str(K),'s'])
        xlabel('SNR(dB)')
        ylabel('Sum delay(s)')
        legend
       
         path ='C:\Users\askht\Desktop\autofigs3';
        saveas(fig,fullfile(path,['geomMonteCarloK' append(num2str(K),'SNR',num2str(SNRmin),num2str(SNRmax)) '.jpeg']));
        hold off;
        figure;
               
end

