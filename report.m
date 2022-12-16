% Average number in the system E[X]
display(['simulation E[X] = ' ...
    num2str(area_num_in_s/sim_time)]);

% Average number in the queue E[Q]
display(['simulation E[Q] = ' ...      
    num2str(area_num_in_q /sim_time)]);

% Average delay in the system E[D]
display(['simulation E[D] = ' ...
    num2str(total_of_delays/num_delay_custs)]);

% Average delay in the queue E[W]
display(['simulation E[W] = ' ...
    num2str(total_of_waits/num_delay_custs)]);

%  Blocking probability
display(['simulation P_B = ' num2str(num_blocked/limit_customers)]);

% The utilization of Server
% Server utilization = fraction of time that the service channel is busy;
area_server_status_sum = 0;
for i = 1:num_events-1
    area_server_status_sum = area_server_status_sum + area_server_status(i);
end
display(['System Utilization = ' ...
    num2str(area_server_status_sum/(2*sim_time))]);


