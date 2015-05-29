function avgWait = calcAvgWaitAtStop(iStop,nBuses)

global routeA;

colTime = 1;
colVacanIn = 2;
colPaxDemand = 3;
colPaxAlight = 4;
colPaxWait = 5;
colPaxBoard = 6;
colPaxRemain = 7;
colNewVacan = 8;

% bus 1
iBus = 1;
paxBoard(1,1) = routeA.bus(iBus).paxActivStop(iStop).data(colPaxBoard);
tWait(iBus) = 0;
avgWait(iBus) = 0;

% bus 2 to end bus
for iBus = 2:nBuses
    for jBus = 1: iBus-1
        % calculates number of pax planning to board bus j and successfully
        % boarded a bus between bus j and bus i-1
        paxjBusBoarded = 0;
        for kBus = jBus : iBus-1
            paxjBusBoarded = paxjBusBoarded + paxBoard(jBus,kBus);
        end
        % calculates number of pax planning to board bus j and is waiting
        % to board bus i
        paxWait(jBus,iBus) = routeA.bus(jBus).paxActivStop(iStop).data(colPaxDemand) - paxjBusBoarded;
        % calculates number of pax who planned to board buses before bus j
        % and successfully boarded bus i
        paxBoardediBus = 0;
        for kBus = 1:jBus-1
            paxBoardediBus = paxBoardediBus + paxBoard(kBus,iBus);
        end
        % calculates number of pax planning to board bus j and successfully
        % boarded bus i
        paxBoard(jBus,iBus) = min(paxWait(jBus,iBus), ...
                routeA.bus(iBus).paxActivStop(iStop).data(colPaxBoard) - paxBoardediBus);
    end
    
    % calculates number of pax planning to board iBus and successfully
    % boarded iBus
    paxBoardediBus = 0;
    for kBus = 1:iBus-1
        paxBoardediBus = paxBoardediBus + paxBoard(kBus,iBus);
    end
    paxBoard(iBus,iBus) = routeA.bus(iBus).paxActivStop(iStop).data(colPaxBoard) - paxBoardediBus;
    
    % calculates time between arrivals of bus iBus-1 and bus iBus
    tWait(iBus) = routeA.bus(iBus).paxActivStop(iStop).data(colTime) - routeA.bus(iBus-1).paxActivStop(iStop).data(colTime);
    
    % calculates the product of number of pax successfully boarding iBus
    % and the corresponding waiting time 
    prevPaxBoardediBusTime = 0;
    for jBus = 1:iBus-1
        % calculates waiting time of passengers who planned to board jBus
        tWaitjBus = 0;
        for kBus = (jBus+1):iBus
            tWaitjBus = tWaitjBus + tWait(kBus);
        end
        prevPaxBoardediBusTime = prevPaxBoardediBusTime + paxBoard(jBus,iBus)*tWaitjBus;
    end
    
    % calculates wait time of passengers who planned to board previous buses
    % and successfully boarded bus iBus
    avgWait(iBus) = (prevPaxBoardediBusTime + 0.5*paxBoard(iBus,iBus)*tWait(iBus))/...
                    routeA.bus(iBus).paxActivStop(iStop).data(colPaxBoard);
end

end