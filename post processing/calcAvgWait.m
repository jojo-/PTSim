global routeA rawBusA;

colAvgWaitTime = 9;

nStops = length(rawBusA.stop)-1;
for iStop = 1:nStops
    nBusesTotal = length(routeA.bus);
    nBusesThisStop = 0;
    for iBus = 1:nBusesTotal
        % if the number of stops this bus (iBus) travelled is greater
        % than the index of this stop (iStop), this bus is counted towards
        % the total number of buses travelled pass this stop.
        if length(routeA.bus(iBus).paxActivStop)>=iStop
            nBusesThisStop = nBusesThisStop+1;
        end
    end
    
    %disp([num2str(iStop), ', ', num2str(nBusesThisStop)]);
    
    avgWait = calcAvgWaitAtStop(iStop,nBusesThisStop);
    
    for iBus=1:nBusesThisStop
        routeA.bus(iBus).paxActivStop(iStop).data(colAvgWaitTime) = avgWait(iBus);
    end
end
