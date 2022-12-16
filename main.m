clear all;
clc; 

% The simulation of M/M/m/N queueing system (QS)
%using units of minutes
%% Global parameters
%set for M/M/2/3
m = 2;
N = 3;
num_events = m+1;
if m > N
   m = N; %only N servers are active  
end


mean_service_time = 12;
mu = 1/mean_service_time;
limit_customers = 100000;      % Maximum number of messages that arrive to the system (whether admitted or blocked) which induce termination of the simulation run
Q_LIMIT = N-m;  % The simulation program is terminated if the number of stored (in queue) messages exceeds this level
Q_HEAD = 0;   % index for the first element in the queue
Q_TAIL = 0;   % index for the last element in the queue


lambda = 9/60;
rho = lambda/(2*mu);
mean_interarrival = 1/lambda; % Average interarrival time between message arrivals [sec];


%% Initialize the system's parameters
initialize;

%% Main
while total_of_customers-1 < limit_customers    % checks that the max number of served messages is below the specified limit and calls the timing( ) routine.
    % Also include termination conditions that involve maximum simulation run time, queue-size limits.
    % timing: Determines the next event type and updates the current simulation time
    timing;
    
    % update_time_avg_stats
    update_time_avg_stats;
    if next_event_type == 1
        arrive();
    else
        depart();
    end
    %total_of_customers
end
% report
report;
%computing analytic results for M/M/2/3
f = lambda/mu;
a_0 = 1;
a_1 = f^1/factorial(1);
a_2 = f^2/(factorial(2)*2^(2-2));
a_3 = f^3/(factorial(2)*2^(3-2));
P_0 = 1/(a_0+a_1+a_2+a_3);
P_1 = a_1*P_0;
P_2 = a_2*P_0;
P_3 = a_3*P_0;
lambda_D = lambda*(1-P_3);
E_X = P_1 + 2*P_2 + 3*P_3;
E_D = E_X/lambda_D;
E_W = E_D - 1/mu;
E_Q = lambda_D*E_W;

%display analytic results
display(['analytic E[X] = ' num2str(E_X)]);
display(['analytic E[Q] = ' num2str(E_Q)]);
display(['analytic E[D] = ' num2str(E_D)]);
display(['analytic E[W] = ' num2str(E_W)]);
display(['analytic P_B = ' num2str(P_3)]);