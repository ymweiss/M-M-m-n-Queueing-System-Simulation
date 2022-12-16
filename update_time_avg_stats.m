time_since_last_event = sim_time - time_last_event;
time_last_event       = sim_time;


area_num_in_s = area_num_in_s + num_in_s*time_since_last_event;
% Update area under number-in-system function.
area_num_in_q = area_num_in_q + num_in_q*time_since_last_event;
% Update area under number-in-queue function.

% Update area under server-busy indicator function.
for i = 1:num_events-1
    area_server_status(i) = area_server_status(i) + ...
        server_status(i)*time_since_last_event;
end
