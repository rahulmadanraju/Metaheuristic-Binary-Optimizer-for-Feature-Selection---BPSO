clear all 
clc
close all

SearchAgents_no=20; % Number of search agents

Function_name='ClassificationFunction1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

Max_iteration=100; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=ClassificationFunction(Function_name);

for i= 1:100 %Computational time for ececution
     t=zeros(1,4);
	tic
	BPSO_cg_curve=BPSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); % run PSO to compare to results
	toc
end

figure(1)

	semilogy(BPSO_cg_curve,'MarkerFaceColor',[0, 0.4470, 0.7410],'Linewidth',1)

	title('Objective space')
	xlabel('Iteration');
	ylabel('Best score obtained so far');

	axis tight
	grid on
	box on
	legend('BPSO')
