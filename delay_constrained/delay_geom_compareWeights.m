function [] = delay_geom_compareWeights(B,N,Dmin,Dmax)

  
[gi,gj] = set_gains('distant');
w = {[0.5 0.5],[0.1 0.9],[0.4 0.7]};

for idx = 1:length(w) 

Drange = int8(10*(Dmax-Dmin)+1);

opt_energies = zeros(1,Drange);

for Tmax = Dmin:0.1:Dmax
 
[min_energy,~,~] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w{idx});

T_idx = int8(10*(Tmax-Dmin)+1);
opt_energies(T_idx) = min_energy;

end

hold on;
label = strcat('w',num2str(w{1}(1)),num2str(w{1}(2)));
fig2 = plot(Dmin:0.1:Dmax,opt_energies,'-*','DisplayName',label);
xlabel('Maximum acceptable delay(s)')
ylabel('Weighted Sum of Energies')
legend
end

path='C:\Users\askht\Desktop\autofigs4';
saveas(fig2,fullfile(path,['delay_geomcompareWeights' append('D',num2str(Dmin),num2str(Dmax)) '.jpeg']));
hold off;
figure;

% %Energy + phases plot
% t = tiledlayout(3,1);
% 
% nexttile;
% plot(Dmin:0.1:Dmax,opt_energies,'--.')
% xlabel('Maximum acceptable delay')
% ylabel('Weighted Sum of Energies')
% %axis([Din Dmax 0.1 1.1])
% 
% nexttile      
% bar(1:size(opt_ei,2),opt_ei');
% % set(h, {'DisplayName'}, {mat2str(Dmin:0.1:Dmax)})
% % legend()
% title('Energy of UEi per phase')
% xlabel('phase')
% ylabel('Energy')  
% 
% nexttile      
% bar(1:size(opt_ej,2),opt_ej')
% title('Energy of UEj per phase')
% xlabel('phase')
% ylabel('Energy')
% 
% 
% saveas(t,fullfile(path,['fulldelay_geom' append('w',num2str(w(1)),num2str(w(2)),'D',num2str(Dmin),num2str(Dmax),gains) '.jpeg']));



end

