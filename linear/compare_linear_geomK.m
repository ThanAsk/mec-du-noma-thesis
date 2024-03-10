function [] = compare_linear_geomK(B,N,SNRmin,SNRmax)

[gi,gj] = set_gains('distant');
  
      
SNRrange = SNRmax-SNRmin + 1;
N_B = (N/B);

marker = {'o','square','diamond'};
i = 1;

for K = [0.1 0.5 2]
lin_delays = zeros(1,SNRrange);
geom_delays = zeros(1,SNRrange);


for pdb = SNRmin:SNRmax
    
    pmax = 10^(pdb/10);
    [lin_delay,~,~,~] = optimize_times(pmax,K,B,N,gi,gj);
    [geom_delay,~] = geometricOpt3(K,pmax,N_B,gi,gj);

    lin_delays(pdb-SNRmin+1) = lin_delay;
    geom_delays(pdb-SNRmin+1) = geom_delay;


end

hold on;
label = strcat('K = ',num2str(K));
% Line_lin ={'--','Color','red'};
% Line_geom ={'-*','Color','blue'};
%"LineStyle","-","Marker","o","Color","r"
%"LineStyle","-","Marker","*","Color","b"


plot(SNRmin:SNRmax,lin_delays,"LineStyle","-","Marker",marker{i},"Color","r","DisplayName",label);
plot(SNRmin:SNRmax,geom_delays,"LineStyle","--","Marker",marker{i},"Color","b","DisplayName",label);
%fig = plot(ax,SNRmin:SNRmax,geom_delays,:,'MarkerIndices',1:2:length(geom_delays),'Color','blue','DisplayName',label);

xlabel('SNR(dB)')
ylabel('Sum delay(s)')
legend
%axis([SNRmin SNRmax min(opt_delays) Inf])
i = i + 1;
end
% path='C:\Users\askht\Desktop\autofigs4';
%         saveas(fig,fullfile(path,['compare_lin_geom' append(num2str(SNRmin),num2str(SNRmax)) '.jpeg']));
%         saveas(fig,fullfile(path,['compare_lin_geom' append(num2str(SNRmin),num2str(SNRmax)) '.eps']));
%         hold off;
%         figure;

end




