function [] = compare_partial_geomK(params,SNRmin,SNRmax)
tic

[gi,gj] = set_gains('distant');
%[gi,gj] = set_gains('random');
%[gi,gj] = set_gains('close');
  
      
SNRrange = SNRmax-SNRmin + 1;
N_B = params(2)/params(1);

marker = {'o','square','diamond'};
i = 1;

for K = [5 1 12]
partial_delays = zeros(1,SNRrange);
geom_delays = zeros(1,SNRrange);


for pdb = SNRmin:SNRmax
    
    pmax = 10^(pdb/10);
    [partial_delay,~,~,~] = partialOpt(K,pmax,gi,gj,params);
    [geom_delay,~] = geometricOpt3(K,pmax,N_B,gi,gj);

    partial_delays(pdb-SNRmin+1) = partial_delay;
    geom_delays(pdb-SNRmin+1) = geom_delay;


end

hold on;
label = strcat('K = ',num2str(K));
% Line_lin ={'--','Color','red'};
% Line_geom ={'-*','Color','blue'};
%"LineStyle","-","Marker","o","Color","r"
%"LineStyle","-","Marker","*","Color","b"


plot(SNRmin:SNRmax,partial_delays,"LineStyle","-","Marker",marker{i},"Color","r","DisplayName",label);
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
toc
end

