clear
graph = 0.1;
[gi,gj] = set_gains('sym_random');


%for K = 8:20
%for pmax = 4:10

c1 = 1:-0.1:0;
c2 = 1:-0.1:0;

pmax = 20;
K = 0.3;
B = 1;
N = 0.5;


%[c1,c2] = ndgrid(1:-0.1:0);


c = combvec(c1,c2);
c = mat2cell(c',1*ones(1,121),2);
c = reshape(c,[11, 11]);
D = cellfun(@(x)min_delay(x,pmax,K,B,N,gi,gj),c,'UniformOutput',false);

%Remove empty values 
isEm = cellfun(@isempty, D) ;
D(isEm) = {NaN};

%create matrix
D = cell2mat(D);

%plot
[C1,C2] = meshgrid(1:-0.1:0);

% mesh(C1,C2,D,'EdgeColor',graph*ones(1,3));
% hold on 
scatter3(C1,C2,D,'MarkerEdgeColor',[1,0,0])
hold on
%colorbar
%surf(c1,c2,D);

%graph = graph + 0.1;
%end

