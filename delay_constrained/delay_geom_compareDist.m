function [] = delay_geom_compareDist(B,N,weights,Dmin,Dmax)

gains = {'constant','distant','close'};

for idx = 1:length(gains)    
[gi,gj] = set_gains(gains{idx});

%Weight vector
w = weights;

%Set range of  maximum acceptable delays (in seconds)
Drange = int8(10*(Dmax-Dmin)+1);

opt_energies = zeros(1,Drange);

%energy of each time sharing phase (8 phases) , for users {i,j}
opt_ei = zeros(Drange,8);
opt_ej = zeros(Drange,8);

for Tmax = Dmin:0.1:Dmax
 
[min_energy,ei_min,ej_min] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w);

T_idx = int8(10*(Tmax-Dmin)+1);
opt_energies(T_idx) = min_energy;
opt_ei(T_idx,:) = ei_min';
opt_ej(T_idx,:) = ej_min';

end

hold on;
%Total energy plot
fig2 = plot(Dmin:0.1:Dmax,opt_energies,'--.','DisplayName',gains{idx});
xlabel('Maximum acceptable delay(s)')
ylabel('Weighted Sum of Energies')
legend
end

path='C:\Users\askht\Desktop\autofigs2';
saveas(fig2,fullfile(path,['delay_geom' append('w',num2str(w(1)),num2str(w(2)),'D',num2str(Dmin),num2str(Dmax)) '.jpeg']));
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

