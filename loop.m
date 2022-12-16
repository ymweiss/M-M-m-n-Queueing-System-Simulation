clear all;
clc;

rho = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
mu = 4;
limit_customers = 100000;
Q_LIMIT = 1e30;
time_next_event(1:2) = 0;   % Events = {arrivals, departures}
num_events = 2;             % arrival and departure events for a G/G/1 QS
mean_service_time = 1/mu;
lambda = [];
simu_X = [];
simu_Q = [];
simu_D = [];
simu_W = [];
anal_X = [];
anal_Q = [];
anal_D = [];
anal_W = [];
%initialize the array of lambdas
for index = rho
    lambda = [lambda, index*mu];
end

%analytic results
for index = rho
   anal_X = [anal_X, index/(1-index)];
   anal_Q = [anal_Q, index.*index/(1-index)];
   anal_D = [anal_D, 1/(mu*(1-index))];
   anal_W = [anal_W, index/(mu*(1-index))];
end

%simulation
for index = lambda
   mean_interarrival = 1/index;
   initialize;
   %% Main
    while total_of_customers-1 < limit_customers    % checks that the max number of served messages is below the specified limit and calls the timing( ) routine.
    % Also include termination conditions that involve maximum simulation run time, queue-size limits.
    % timing: Determines the next event type and updates the current simulation time
        timing;
        % update_time_avg_stats
        update_time_avg_stats;
        switch next_event_type
            case 1
                arrive();            
            case 2
                depart();
        end
        %total_of_customers
    end
    simu_X = [simu_X, (area_num_in_q /sim_time)];
    simu_Q = [simu_Q, (area_num_in_q /sim_time)];
    simu_D = [simu_D, (total_of_delays/num_delay_custs)];
    simu_W = [simu_W, (total_of_waits/num_waiting_custs)]; 
    % report
    %report;
    %plot the simulated results and the analytic results
end

figure
hold on
scatter(rho, simu_X, "r")
scatter(rho, anal_X, "b")
hold off
legend('simulation X results', 'analytic X results')

figure
hold on
scatter(rho, simu_Q, "r")
scatter(rho, anal_Q, "b")
hold off
legend('simulation Q results', 'analytic Q results')

figure
hold on
scatter(rho, simu_D, "r")
scatter(rho, anal_D, "b")
hold off
legend('simulation D results', 'analytic D results')

figure
hold on
scatter(rho, simu_W, "r")
scatter(rho, anal_W, "b")
hold off
legend('simulation W results', 'analytic W results')