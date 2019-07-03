% Particle Swarm Optimization
function Convg_curve=BPSO(N,Max_iteration,lb,ub,dim,fobj)
% Define the PSO's paramters 
noP = N;
maxIter =Max_iteration;
wMax = 0.9;
wMin = 0.4;
c1 = 2;
c2 = 2;
vMax = (ub - lb) .* 0.2; 
vMin  = -vMax;
PBEST=zeros(noP,dim);
GBEST=zeros(1,dim);
Convg_curve=zeros(1,maxIter);


% The PSO algorithm 

% Initialize the particles 
for k = 1 : noP
    Swarm.Particles(k).X = round((ub-lb) .* rand(1,dim) + lb); 
    Swarm.Particles(k).V = zeros(1, dim); 
    Swarm.Particles(k).PBEST.X = zeros(1,dim); 
    Swarm.Particles(k).PBEST.O = inf; 
    
    Swarm.GBEST.X = zeros(1,dim);
    Swarm.GBEST.O = inf;
end


% Main loop
for t = 1 : maxIter
    
    % Calcualte the objective value
    for k = 1 : noP
        currentX = Swarm.Particles(k).X;
        Swarm.Particles(k).O = fobj(currentX);
        
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O 
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vectors 
    w = wMax - t .* ((wMax - wMin) / maxIter);
    
    for k = 1 : noP
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V + c1 .* rand(1,dim) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
                                                                                     + c2 .* rand(1,dim) .* (Swarm.GBEST.X - Swarm.Particles(k).X);
                                                                                 
        
        % Check velocities 
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        
        %Sigmoid Transfer Function
        s=1 ./ (1+exp(-Swarm.Particles(k).V));
        
        %Update the position of the particle
        for d=1: dim          
            r=rand();
            if r<s(d)
                Swarm.Particles(k).X(d)=1;
            else
                Swarm.Particles(k).X(d)=0;
            end
        end
        
        
    end
    
    %outmsg = ['Iteration# ', num2str(t) , ' Swarm.GBEST.O = ' , num2str(-1.*Swarm.GBEST.O)];
    %disp(outmsg);
    
    Convg_curve(t) = Swarm.GBEST.O;
end
 
%semilogy(cgCurve);
%xlabel('Iteration#')
%ylabel('ClassificationAccuracy')
