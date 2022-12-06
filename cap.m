function Rate = cap(p1,p2)
%Capacity calculation with interference 
% no interference : set p2 = 0 

Rate = log2(1+ p1/(1+p2));
end

