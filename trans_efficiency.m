function eff = trans_efficiency()
kva= input("ENTER THE KVA OF TRANSFORMER: ");
fprintf("\bKVA\n");
Pc=input("ENTER THE COPPER LOSS : ");
fprintf("\bW\n");
Pi=input("ENTER THE IRON LOSS : ");
fprintf("\bW\n");
P_factor=input("ENTER THE POWER FACTOR : ");
a=kva*10^3*P_factor;
load=0:0.001:1.5;

r=menu("What is the load that TRANSFORMER is operated on",...
"HALF LOAD" , "FULL LOAD");

switch r
    case 1
        efficiency= (0.5*a)/(0.5*kva*10^3*P_factor + 0.25*Pc + Pi);
    
    case 2
        efficiency= (a)/(kva*10^3*P_factor + Pc + Pi);
end
fprintf("THE EFFICIENCY OF TRANSFORMER IS %f\n",efficiency);
fprintf("-------------------------------------------------------------\nTHE TRANSFORMER EFFICIENCY CURVE FOR VARIOUS LOADS\n");
efficiency = (load.*(a)./(kva*10^3*P_factor + load.^2*Pc + Pi)).*100;
figure;
plot(load,efficiency,'r');
title("EFFICIENCY CURVE");
ylabel("Efficiency");
xlabel("Load");
end
        
