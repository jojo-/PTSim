% This script takes the output of the Simulink gong shuttle model
% and convert it to something used by the visualisation software written
% with the Gama platform.

clc
clear
load routeA

%% Bus schedules: time whn the buses arrive and leave each stop

% Note: the data of interest for i.e. bus 35 is stored in the structure 
% routeA.bus(35).op

% preparing outputs
n_bus                   = 35;
res_arrive_at_stops     = zeros(n_bus,19);
res_depart_from_stops   = zeros(n_bus,19);

% loop over the buses for gathering the data
for i=1:1:n_bus
    
    data_stop = routeA.bus(i).op(:,1);
    data_time = routeA.bus(i).op(:,2);
    
    
    % loop over the stops
    s_idx = 0;
    for s=1:1:20
        
        % skipping a stop that is not used in the new version of the model
        if s == 4 
            continue
        end        
        s_idx = s_idx + 1;
        
        res_arrive_at_stops(i,s_idx)    = min(data_time(data_stop==s));
        res_depart_from_stops(i,s_idx ) = max(data_time(data_stop==s));        
            
    end
            
end

% output

id_bus = 1:35;
id_bus = mod(id_bus,4);
id_bus(id_bus == 0) = 4;

dlmwrite('time_bus_arrive_at_stop.csv',res_arrive_at_stops,'delimiter',',')
dlmwrite('time_bus_depart_from_stop.csv',res_depart_from_stops,'delimiter',',')

%% Average waiting time at a bus stop for passenger sucessfully boarding the bus (in seconds)

% Note: the data is stored in routeA.bus(2).paxActivStop(4)
%        -> data: [856 73 1 0 1 1 0 72 335]
%        -> need to plot 335 (last column)
%        -> if NaN -> -1 (no passengers alighting or boarding)

res_pass_wait = zeros(n_bus,18);

% loop over the buses for gathering data
for i=1:1:n_bus
       
    data_pass_wait = routeA.bus(i).paxActivStop;
        
    % loop over the stops
    s_idx = 0;
    for s=1:1:19
       
        % skipping a stop that is not used in the new version of the model
        if s == 4 
            continue
        end        
        s_idx = s_idx + 1;
        
        res_pass_wait(i,s_idx) = data_pass_wait(s).data(end);

        % removing the NaN and replacing them with -1
        if (isnan(res_pass_wait(i,s_idx)) == 1 )
            res_pass_wait(i,s_idx) = -1;
        end
        
    end
    
end

% output

dlmwrite('pass_average_waiting_time.csv',res_pass_wait,'delimiter',',')




