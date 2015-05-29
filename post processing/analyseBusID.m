%function routeA = analyseBusID() 

global routeA rawBusA;

% extracts all bus IDs that are generated in the simulation.
% these are ID of buses arriving at the first stop
busIDs = rawBusA.stop(1).idBusArr(:,1);

chkPntStopID = [5 11 14];

% for each of the buses in busIDs
for iBus = 1:length(busIDs) 
    dataPoints = 0;

    busID = busIDs(iBus);
    
    % for each of the stops
    for stopID = 1:(length(rawBusA.stop)-1)
        %distThisStop = rawBusA.stop(stopID).dist;
        distThisStop = stopID;
        
        % gets the time busID arriving at stopID
        if (~isempty(rawBusA.stop(stopID).idBusArr))
            idxThisBus = find(rawBusA.stop(stopID).idBusArr(:,1)==busID);
            if (~isempty(idxThisBus))
                dataPoints = dataPoints + 1;
                timeArrThisStop = rawBusA.stop(stopID).idBusArr(idxThisBus(1),2);
                routeA.bus(iBus).busID = busID;
                routeA.bus(iBus).op(dataPoints,:) = [distThisStop timeArrThisStop];
            end
        end
        
        % if this stop is a major check point and if the bus arrives early
        if (ismember(stopID,chkPntStopID))
            if (~isempty(rawBusA.stop(stopID).idBusOutChkPnt))
                idxThisBus = find(rawBusA.stop(stopID).idBusOutChkPnt==busID);
                if (~isempty(idxThisBus))
                    dataPoints = dataPoints + 1;
                    timeOutChkPnt = rawBusA.stop(stopID).idBusOutChkPnt(idxThisBus(1),2);
                    routeA.bus(iBus).op(dataPoints,:) = [distThisStop timeOutChkPnt];
                end
            end
        end
        
        % gets the time busID leaving stopID
        if (~isempty(rawBusA.stop(stopID).idBusOut(:,1)))
            idxThisBus = find(rawBusA.stop(stopID).idBusOut(:,1)==busID);
            if (~isempty(idxThisBus))
                dataPoints = dataPoints + 1;
                timeOutThisStop = rawBusA.stop(stopID).idBusOut(idxThisBus(1),2);
                routeA.bus(iBus).op(dataPoints,:) = [distThisStop timeOutThisStop];
            end
        end
    end
    
    % gets the time busID finishing travel on the last link
    lastLinkID = stopID;
    %distNextStop = rawBusA.stop(stopID+1).dist;
    distNextStop = stopID+1;
    if (~isempty(rawBusA.link(lastLinkID).idBusOut))
        idxThisBus = find(rawBusA.link(lastLinkID).idBusOut(:,1)==busID);
        if (~isempty(idxThisBus))
            dataPoints = dataPoints + 1;
            timeFinThisLink = rawBusA.link(lastLinkID).idBusOut(idxThisBus(1),2);
            routeA.bus(iBus).op(dataPoints,:) = [distNextStop timeFinThisLink];
        end
    end
    
    % gets the time busID needs to wait at the end of the cycle before
    % reenterring the loop.
    % Notes: ID of the current bus needs to increas by 1 because busID was
    % increased by 1 before it is logged in
    % rawBusA.stopEnd.idBusOutChkPnt (or idBusOutChkPntEndCycle)
    busID = busID + 1; 
    if (~isempty(rawBusA.stopEnd.idBusOutChkPnt))
        idxThisBus = find(rawBusA.stopEnd.idBusOutChkPnt(:,1)==busID);
        if (~isempty(idxThisBus)) 
            dataPoints = dataPoints + 1;
            timeOutChkPnt = rawBusA.stopEnd.idBusOutChkPnt(idxThisBus(1),2);
            routeA.bus(iBus).op(dataPoints,:) = [distNextStop,timeOutChkPnt];
        end
    end
end

%end
