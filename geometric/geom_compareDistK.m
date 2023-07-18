function [] = geom_compareDistK(N,K,SNRmin,SNRmax)

 gains = {'constant','distant','close'};

for idx = 1:length(gains)    
[gi,gj] = set_gains(gains{idx});

SNRrange = SNRmax-SNRmin + 1;
opt_delays = zeros(1,SNRrange);
opt_z = zeros(SNRrange,8);

for pdb = SNRmin:SNRmax
    pmax = 10^(pdb/10);  
    [min_delay,z_min] = geometricOpt3(K,pmax,N,gi,gj);

    opt_delays(pdb-SNRmin+1) = min_delay;
    opt_z(pdb-SNRmin+1,:) = z_min';
    
end
        %Delay plot
        hold on;
        fig = plot(SNRmin:SNRmax,opt_delays,'--.','MarkerIndices',1:2:length(opt_delays),'DisplayName',gains{idx});
        title(['K = ',num2str(K),'s'])
        xlabel('SNR(dB)')
        ylabel('Sum delay(s)')
        legend
end       
        path='C:\Users\askht\Desktop\autofigs2';
        saveas(fig,fullfile(path,['geomcompK' append(num2str(K),'SNR',num2str(SNRmin),num2str(SNRmax)) '.jpeg']));
        hold off;
        figure;

%         %Delay + phases plot 
%         t = tiledlayout(2,1);
%         nexttile;
%         plot(SNRmin:SNRmax,opt_delays,'--.','MarkerIndices',1:2:length(opt_delays));
%         title(['K = ',num2str(K),'s'])
%         xlabel('SNR(dB)')
%         ylabel('sum delay(s)')
%         %axis([SNRmin SNRmax 0.1 1.1])
%         nexttile;     
%         bar(1:size(opt_z,2),opt_z');
%         title('Time Sharing Schedule')
%         xlabel('phase')
%         ylabel('Time')
%         
%        
%        
%         saveas(t,fullfile(path,['fullgeomK' append(num2str(K),'SNR',num2str(SNRmin),num2str(SNRmax),gains) '.jpeg']));
% C:\Users\askht\Desktop\autofigs       
end

