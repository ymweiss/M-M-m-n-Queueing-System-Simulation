time_next_event(1) = sim_time + exprnd(mean_interarrival);

%num_in_s = num_in_s + 1;
%time_arrival_system(num_in_s) = sim_time;       % time arrival system (i) = time of arrival of message-i
                                                % time arrival system (num_in_s) = time of arrival of the last message to arrive
total_of_customers = total_of_customers + 1;
for i = 1:num_events-1
   if server_status(i) == 0
       server_status(i) = 1; %server is busy
       time_next_event(i+1) = sim_time + exprnd(mean_service_time);
       %time_arrival_system(i) = sim_time;
       total_of_delays = total_of_delays + time_next_event(i+1) - sim_time;
       num_in_s = num_in_s + 1;
       time_arrival_system(num_in_s) = sim_time;
       return;
   end
end

% all servers are busy
if num_in_q < Q_LIMIT
    num_in_s = num_in_s + 1;
    time_arrival_system(num_in_s) = sim_time;
    num_in_q = num_in_q + 1; %will always be 1
    if Q_TAIL == Q_LIMIT
        Q_TAIL = 1;
    else
        Q_TAIL = Q_TAIL + 1;
    end
    if num_in_q == 1
       Q_HEAD = Q_TAIL; 
    end
    time_arrival_queue(Q_TAIL) = sim_time;
else %system is full
    num_blocked = num_blocked + 1;
    return;
end