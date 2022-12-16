    %% initialize
    sim_time = 0;               % Initialize simulation time  
    
    % Initialize the state variables
    num_in_s = 0;               % number of customers in the system (or system size, denoted as X)
    num_in_q = 0;               % number of customers in the queue (wait size, denoted as Q)
    time_last_event = 0;        % the time of the latest recorded event
    
    % Initialize the statistical counters.
    num_waiting_custs = 0;      % cumulative number of customers that have experienced delay time up to this time
    num_delay_custs = 0;        % cumulative number of customers that have experienced waiting time up to this time
    total_of_customers = 0;     
    total_of_waits = 0;         % Cumulative sum of the waiting times experience by all customers served by the system up to this time
    total_of_delays = 0;        % Cumulative sum of the delay times experience by all customers served by the system up to this time
    area_num_in_s = 0;          % cumulative system size area up to this time
    area_num_in_q = 0;          % cumulative queue size area up to this time
    % Initialize event list.  Since no customers are present,
    % the departure (service completion) event is eliminated from consideration.
    % Matlab defines exprnd(mean_interarrival) = exponentially distributed RV with this specified mean
    
    server_status = ones(1,num_events-1);
    area_server_status = ones(1,num_events-1);
    time_next_event = ones(1,num_events);
    time_next_event(1) = sim_time + exprnd(mean_interarrival);  % time of next arrival event
    for i = 1:num_events-1
        server_status(i) = 0;
        area_server_status(i) = 0;
        time_next_event(i+1) = 1e30; %set departure event from all servers to infinity
    end
    num_blocked = 0;            %number of customers blocked
    
    
    
    %time_next_event(2) = 1e30;                                  % time of next departure event for server 1; 1e30 denotes infinite
    %time_next_event(3) = 1e30;                                  % time of next departure event for server 2; 1e30 denotes infinite