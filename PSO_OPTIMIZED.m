clc;
clear;
close all;

%%problem definition

CostFunction = @(x) Sphere(x); %cost function

nVar = 5;           %Number of Unknown (Decision) variable

VarSize=[1 nVar];   %Matrix Size of Decision variables

VarMin = -5;       %Lower bound of decision variables
VarMax = 5;        %upper bound of decision variables



%%parameters of pso

MaxIt = 500;        %maximum number of iterations
nPop = 50;          %Population size(swarm size)
wdamp=0.99;         %damping ratio of inertia weight
w = 0.9;              %inertia coefficient
c1 = 2;             %personal acceleration coefficent
c2 = 2;             %social acceleration coefficient
alpha=0.9;          %HYPERPARAMETER FOR VELOCITY TERM


%%Initialization
%particlr template
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

particle = repmat(empty_particle, nPop, 1);

%Initialize Global Best
GlobalBest.Cost = inf;      %it is infinity because we need to minimize



%initialize Population Members
for i=1:nPop
    
    %generate random solution
    particle(i).Position = unifrnd(VarMin , VarMax, VarSize);
    
    %Initialize velocity
    particle(i).Velocity = zeros(VarSize);
    
    
    %Evaluation
    particle(i).Cost=CostFunction(particle(i).Position);    
    
    %Update the personal best
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    
    %Update Global Best
    if particle(i).Best.Cost < GlobalBest.Cost
        GlobalBest = particle(i).Best;
    end
    
end

BestCosts = zeros(MaxIt,1);


%%Main Loop of PSO

for it=1:MaxIt
    
    for i=1:nPop
        
        %update velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            + c1*rand(VarSize).*(particle(i).Best.Position - 2.*particle(i).Position).*exp(-i).*i...
            + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);
      
        %update position
        particle(i).Position = particle(i).Position + particle(i).Velocity.*(i/alpha);
        
        %Evaluation
        particle(i).Cost = CostFunction(particle(i).Position);
      
        %update Personal Best
        if particle(i).Cost < particle(i).Best.Cost
            
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;
            
            %update Global best
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            end
        end
    end
    
    %store the best cost value
    BestCosts(it) = GlobalBest.Cost;
    
    %display iteration information
    disp(['Iteration' num2str(it) ':Best Cost  =' num2str(BestCosts(it))]);

    w=w*wdamp;

end

      
%%Results

%figure;
%plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts,'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');



