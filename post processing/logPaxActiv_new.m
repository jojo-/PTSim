global routeA rawBusA;

colTime = 1;
colVacanIn = 2;
colPaxDemand = 3;
colPaxAlight = 4;
colPaxWait = 5;
colPaxBoard = 6;
colPaxRemain = 7;
colNewVacan = 8;
colAvgWaitTime = 9;

if (exist('./outputCSV','dir')==0)
    mkdir('./outputCSV');
end

header = {'iBus' 'busID' 'iStop' 'arrTime' 'vacancy' 'paxDemand' 'paxAlight' 'paxWait' 'paxBoard' 'paxRemain' 'newVacancy' 'avgWaitTime'};
nStops = length(rawBusA.stop);
logPaxActivData = [[]];
nBuses = length(routeA.bus);
for iBus = 1:nBuses
    % gets the number of stops this bus successfully arrives
    for iStop = 1:length(routeA.bus(iBus).paxActivStop)
        logPaxActivData(end+1,:) = [iBus routeA.bus(iBus).busID iStop routeA.bus(iBus).paxActivStop(iStop).data];
        %routeA.bus(iBus).paxActivStop(iStop).data(end+1) = -1;
    end
end
csvwrite_with_headers('../output/logPaxActiv.csv',logPaxActivData,header);

% logs average wait time by bus by stop
avgWaitByBusByStop = [[]];
header1 = {'time' 'stop1' 'stop2' 'stop3' 'stop4' 'stop5' 'stop6' 'stop7' 'stop8' 'stop9' 'stop10'...
    'stop11' 'stop12' 'stop13' 'stop14' 'stop15' 'stop16' 'stop17' 'stop18'};
for iBus = 1:nBuses
    % the first column is the time the bus on this row starts the cycle (i.e. the time it arrives at stop 1)
    avgWaitByBusByStop(iBus,1) = routeA.bus(iBus).paxActivStop(1).data(1);
    for iStop=1:length(routeA.bus(iBus).paxActivStop)
        if(isnan(routeA.bus(iBus).paxActivStop(iStop).data(end)))
            avgWaitByBusByStop(iBus,iStop+1) = 0;
        else
            avgWaitByBusByStop(iBus,iStop+1) = routeA.bus(iBus).paxActivStop(iStop).data(colAvgWaitTime);
        end
    end
    lastStop = iStop;
    for iStop = lastStop+1:length(rawBusA.stop)-1
        avgWaitByBusByStop(iBus,iStop+1) = 99999;
    end
end
csvwrite_with_headers('../output/avgWaitByBusByStop.csv',avgWaitByBusByStop,header1);

paxBoardByBusByStop = [[]];
header1 = {'time' 'stop1' 'stop2' 'stop3' 'stop4' 'stop5' 'stop6' 'stop7' 'stop8' 'stop9' 'stop10'...
    'stop11' 'stop12' 'stop13' 'stop14' 'stop15' 'stop16' 'stop17' 'stop18'};
for iBus=1:length(routeA.bus)
    % the first column is the time the bus on this row starts the cycle (i.e. the time it arrives at stop 1)
    paxBoardByBusByStop(iBus,1) = routeA.bus(iBus).paxActivStop(1).data(1);
    for iStop=1:length(routeA.bus(iBus).paxActivStop)
        if(isnan(routeA.bus(iBus).paxActivStop(iStop).data(end)))
            paxBoardByBusByStop(iBus,iStop+1) = 0;
        else
            paxBoardByBusByStop(iBus,iStop+1) = routeA.bus(iBus).paxActivStop(iStop).data(colPaxBoard);
        end
    end
    lastStop = iStop;
    for iStop = lastStop+1:length(rawBusA.stop)-1
        paxBoardByBusByStop(iBus,iStop+1) = 0;
    end
end
csvwrite_with_headers('../output/paxBoardByBusByStop.csv',paxBoardByBusByStop,header1);

