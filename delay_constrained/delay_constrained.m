tic
clear; 

B = 10^6; % Hz 
N = 0.5*(10^6) ; %bit

%[gi,gj] = set_gains('close_constant');
[gi,gj] = set_gains('constant');

%Weight vector
w = [0.5,0.5];

%Set range of  maximum acceptable delays (in seconds)
Dmin = 0.2;
Dmax = 1;
Drange = 10*(Dmax-Dmin);

opt_energies = zeros(1,Drange);

%energy of each time sharing phase (8 phases) , for users {i,j}
opt_ei = zeros(Drange,8);
opt_ej = zeros(Drange,8);

r = 0;
for Tmax = Dmin:0.1:Dmax
 

[min_energy,ei_min,ej_min,Ax,Af] = delay_cons_geomOpt(Tmax,N,B,gi,gj,w);
T_idx = int8(10*(Tmax-Dmin)+1);
opt_energies(T_idx) = min_energy;
opt_ei(T_idx,:) = ei_min';
opt_ej(T_idx,:) = ej_min';

%  waitbar(Tmax/Dmax)

%Debugging
Ax
Af
r = r + 1
end

tiledlayout(3,1)
nexttile;
plot(Dmin:0.1:Dmax,opt_energies,'--.')
%title(['w = ',num2str(K),'s'])
xlabel('Maximum acceptable delay')
ylabel('Weighted Sum of Energies')
%axis([Din Dmax 0.1 1.1])
nexttile      
h = bar(1:size(opt_ei,2),opt_ei');
% set(h, {'DisplayName'}, {mat2str(Dmin:0.1:Dmax)})
% legend()
title('Energy of UEi per phase')
xlabel('phase')
ylabel('Energy')  

nexttile      
bar(1:size(opt_ej,2),opt_ej')
title('Energy of UEj per phase')
xlabel('phase')
ylabel('Energy')
             
toc