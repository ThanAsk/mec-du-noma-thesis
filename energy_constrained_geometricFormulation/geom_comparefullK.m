function [] = geom_comparefullK(N,SNRmin,SNRmax)
   
[gi,gj] = set_gains('distant');

for K = [0.5 5 12]
SNRrange = SNRmax-SNRmin + 1;
opt_delays = zeros(1,SNRrange);

%opt_z = zeros(SNRrange,8);

for pdb = SNRmin:SNRmax
    pmax = 10^(pdb/10);  
    [min_delay,~] = geometricOpt3(K,pmax,N,gi,gj);

    opt_delays(pdb-SNRmin+1) = min_delay;
   % opt_z(pdb-SNRmin+1,:) = z_min';
    
end
        %Delay plot
        hold on;
        label = strcat('K = ',num2str(K));
        fig = plot(SNRmin:SNRmax,opt_delays,'-*','MarkerIndices',1:2:length(opt_delays),'DisplayName',label);
        %title(['K = ',num2str(K),'s'])
        xlabel('SNR(dB)')
        ylabel('Sum delay(s)')
        legend
end       
        path='C:\Users\askht\Desktop\autofigs4';
        saveas(fig,fullfile(path,['geom_comparefull' append('SNR',num2str(SNRmin),num2str(SNRmax)) '.jpeg']));
        hold off;
        figure;
 
end

