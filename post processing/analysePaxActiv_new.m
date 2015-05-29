global routeA rawBusA;

nBuses = length(routeA.bus);

stopChkPnts = [5, 11, 14];

for iBus = 1:nBuses
    % gets the number of stops this bus successfully arrives
    nStops = max(routeA.bus(iBus).op(:,1));
    
    for iStop = 1:nStops
        % gets the time this bus starts handling passengers at iStop
        time=-1;
        rowIndices = find(routeA.bus(iBus).op(:,1)==iStop);
        if ismember(iStop,stopChkPnts) % if this stop is a check point
            if length(rowIndices)>1 % if this bus finished waiting for checkpoint time
                time = routeA.bus(iBus).op(rowIndices(2),2);
            end
        else
            time = routeA.bus(iBus).op(rowIndices(1),2);
        end
        
        % proceeds with extracting data about passengers only if time~=-1
        if (time~=-1 && ~isempty(rawBusA.stop(iStop).vacanIn) && ...
                ~isempty(rawBusA.stop(iStop).paxDemand) && ...
                ~isempty(rawBusA.stop(iStop).paxAlight) && ...
                ~isempty(rawBusA.stop(iStop).paxWait) && ...
                ~isempty(rawBusA.stop(iStop).paxBoard) && ...
                ~isempty(rawBusA.stop(iStop).paxRemain) && ...
                ~isempty(rawBusA.stop(iStop).newVacan))
            
            % find the value corresponding to this time in
            % rawBusA.stop(iStop).vacanIn(:,2), etc.
            
            rowVacanIn = find(rawBusA.stop(iStop).vacanIn(:,2)==time,1);
            rowPaxDemand = find(rawBusA.stop(iStop).paxDemand(:,2)==time,1);
            rowPaxAlight = find(rawBusA.stop(iStop).paxAlight(:,2)==time,1);
            rowPaxWait = find(rawBusA.stop(iStop).paxWait(:,2)==time,1);
            rowPaxBoard = find(rawBusA.stop(iStop).paxBoard(:,2)==time,1);
            rowPaxRemain = find(rawBusA.stop(iStop).paxRemain(:,2)==time,1);
            rowNewVacan = find(rawBusA.stop(iStop).newVacan(:,2)==time,1);
            
            if (~isempty(rowVacanIn) && ~isempty(rowPaxDemand) && ~isempty(rowPaxAlight) && ...
                    ~isempty(rowPaxWait) && ~isempty(rowPaxBoard) && ~isempty(rowPaxRemain) && ~isempty(rowNewVacan))
                
                routeA.bus(iBus).paxActivStop(iStop).data = [rawBusA.stop(iStop).vacanIn(rowVacanIn,2) ...
                    rawBusA.stop(iStop).vacanIn(rowVacanIn,1) ...
                    rawBusA.stop(iStop).paxDemand(rowPaxDemand,1) ...
                    rawBusA.stop(iStop).paxAlight(rowPaxAlight,1) ...
                    rawBusA.stop(iStop).paxWait(rowPaxWait,1) ...
                    rawBusA.stop(iStop).paxBoard(rowPaxBoard,1) ...
                    rawBusA.stop(iStop).paxRemain(rowPaxRemain,1) ...
                    rawBusA.stop(iStop).newVacan(rowNewVacan,1)];
                
                
            end
            
        end
        
    end
    
end