num_in_s = num_in_s - 1;
num_delay_custs = num_delay_custs + 1;  

if num_in_q == 0
    % The queue is empty so make the server idle and eliminate the
    % departure (service completion) event from consideration.
    server_status(next_event_type-1) = 0;
    time_next_event(next_event_type) = 1.0e+30;
end
if num_in_q > 0
    % The queue is nonempty, so decrement the number of customers in queue
    num_in_q = num_in_q - 1;
    
    
    % Compute the delay of the customer who is beginning service and update
    
    %time_arrival_system(next_event_type) = time_arrival_queue(Q_HEAD);
    wait_time(next_event_type) = sim_time - time_arrival_queue(Q_HEAD);
    total_of_waits = total_of_waits + wait_time(next_event_type);
    if num_in_q == 0
        Q_HEAD = 0;
        Q_TAIL = 0;
    elseif Q_HEAD == Q_LIMIT
        Q_HEAD = 1;
    else
        Q_HEAD = Q_HEAD + 1;
    end
    
    % Increment the number of customers delayed,
    % and schedule next departure.
    num_waiting_custs = num_waiting_custs + 1;
    time_next_event(next_event_type) = sim_time + exprnd(mean_service_time);
    %update total delay accumulator
    total_of_delays = total_of_delays + time_next_event(next_event_type)- sim_time; 
end