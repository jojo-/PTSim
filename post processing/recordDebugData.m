%{
headerRepReq = {'time', 'tSchedAtCP', 'lateBus', 'reqNxtBus', 'schedDepTimeNxtBus'};

% checking replaced bus at CP2
repFoundCP2 = find(tSchedCP2.time-tSchedCP2.signals.values>=900);
for i=1:length(repFoundCP2)
    idB4CP2Out(i) = idB4CP2.signals.values(find(idB4CP2.time==tSchedCP2.time(repFoundCP2(i))));
end

idRepFrCP2Out = [];
for i=1:length(repFoundCP2)
    tmpIndices = find(idRepFrCP2.time==tSchedCP2.time(repFoundCP2(i)),1,'last');
    for j=1:length(tmpIndices)
        idRepFrCP2Out(end+1,:) = [idRepFrCP2.time(tmpIndices(j)) idRepFrCP2.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end

tDepRepFrCP2Out = [];
for i=1:length(repFoundCP2)
    tmpIndices = find(depTimeRepFrCP2.time==tSchedCP2.time(repFoundCP2(i)),1,'last');
    for j=1:length(tmpIndices)
        tDepRepFrCP2Out(end+1,:) = [depTimeRepFrCP2.time(tmpIndices(j)) depTimeRepFrCP2.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end
repReqAtCP2 = [tSchedCP2.time(repFoundCP2) tSchedCP2.signals.values(repFoundCP2) idB4CP2Out' idRepFrCP2Out(:,2) tDepRepFrCP2Out(:,2)];
csvwrite_with_headers('../output/debug/repReqAtCP2.csv',repReqAtCP2,headerRepReq);
clear repFoundCP2 idB4CP2Out idRepFrCP2Out tDepRepFrCP2Out repReqAtCP2;


% checking replaced bus at CP3
repFoundCP3 = find(tSchedCP3.time-tSchedCP3.signals.values>=900);
for i=1:length(repFoundCP3)
    idB4CP3Out(i) = idB4CP3.signals.values(find(idB4CP3.time==tSchedCP3.time(repFoundCP3(i))));
end

idRepFrCP3Out = [];
for i=1:length(repFoundCP3)
    tmpIndices = find(idRepFrCP3.time==tSchedCP3.time(repFoundCP3(i)),1,'last');
    for j=1:length(tmpIndices)
        idRepFrCP3Out(end+1,:) = [idRepFrCP3.time(tmpIndices(j)) idRepFrCP3.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end

tDepRepFrCP3Out = [];
for i=1:length(repFoundCP3)
    tmpIndices = find(depTimeRepFrCP3.time==tSchedCP3.time(repFoundCP3(i)),1,'last');
    for j=1:length(tmpIndices)
        tDepRepFrCP3Out(end+1,:) = [depTimeRepFrCP3.time(tmpIndices(j)) depTimeRepFrCP3.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end
repReqAtCP3 = [tSchedCP3.time(repFoundCP3) tSchedCP3.signals.values(repFoundCP3) idB4CP3Out' idRepFrCP3Out(:,2) tDepRepFrCP3Out(:,2)];
csvwrite_with_headers('../output/debug/repReqAtCP3.csv',repReqAtCP3,headerRepReq);
clear repFoundCP3 idB4CP3Out idRepFrCP3Out tDepRepFrCP3Out repReqAtCP3;


% checking replaced bus at CP4
repFoundCP4 = find((tSchedCP4.time-tSchedCP4.signals.values)>=900);
for i=1:length(repFoundCP4)
    idB4CP4Out(i) = idB4CP4.signals.values(find(idB4CP4.time==tSchedCP4.time(repFoundCP4(i))));
end

idRepFrCP4Out = [];
for i=1:length(repFoundCP4)
    tmpIndices = find(idRepFrCP4.time==tSchedCP4.time(repFoundCP4(i)),1,'last');
    for j=1:length(tmpIndices)
        idRepFrCP4Out(end+1,:) = [idRepFrCP4.time(tmpIndices(j)) idRepFrCP4.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end

tDepRepFrCP4Out = [];
for i=1:length(repFoundCP4)
    tmpIndices = find(depTimeRepFrCP4.time==tSchedCP4.time(repFoundCP4(i)),1,'last');
    for j=1:length(tmpIndices)
        tDepRepFrCP4Out(end+1,:) = [depTimeRepFrCP4.time(tmpIndices(j)) depTimeRepFrCP4.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end
repReqAtCP4 = [tSchedCP4.time(repFoundCP4) tSchedCP4.signals.values(repFoundCP4) idB4CP4Out' idRepFrCP4Out(:,2) tDepRepFrCP4Out(:,2)];
csvwrite_with_headers('../output/debug/repReqAtCP4.csv',repReqAtCP4,headerRepReq);
clear repFoundCP4 idB4CP4Out idRepFrCP4Out tDepRepFrCP4Out repReqAtCP4;


% checking output of picking replaced buses out of those being requested
idRepedBusDisp = [];
uIDRepedBusOut = unique(idRepedBusOut.signals.values);
for i=1:length(uIDRepedBusOut)
    tmpIndices = find(idRepedBusOut.signals.values==uIDRepedBusOut(i),1);
    for j=1:length(tmpIndices)
        idRepedBusDisp(end+1,:) = [idRepedBusOut.time(tmpIndices(j)) idRepedBusOut.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end

tRepedBusDisp = [];
utRepedBusOut = unique(tRepedBusOut.signals.values);
for i=1:length(utRepedBusOut)
    tmpIndices = find(tRepedBusOut.signals.values==utRepedBusOut(i),1);
    for j=1:length(tmpIndices)
        tRepedBusDisp(end+1,:) = [tRepedBusOut.time(tmpIndices(j)) tRepedBusOut.signals.values(tmpIndices(j))];
    end
    clear tmpIndices;
end
%[idRepedBusDisp tRepedBusDisp]
clear tRepedBusDisp utRepedBusOut;

% output details of replacing buses and corresponding replaced buses
repBusDetails = [idRepBusHB.time idRepBusHB.signals.values repBusIDOut.signals.values];
headerRepBusDetails = {'depTime','replacingBus','replacedBus'};
csvwrite_with_headers('../output/debug/repBusDetails.csv',repBusDetails,headerRepBusDetails);
clear repBusDetails;
%}

% checks new id of bus before reengaging the loop
idNxtBusOut = [];
for i=1:length(idAfterCycle.time)
    tmpIndices = find(idNxtNormalBus.time==idAfterCycle.time(i));
    nxtID = -1;
    if (~isempty(tmpIndices))
        nxtID = idNxtNormalBus.signals.values(tmpIndices);
    end
    clear tmpIndices;
    idNxtBusOut(end+1,:) = [idAfterCycle.time(i) idAfterCycle.signals.values(i) nxtID];
end
%headerNxtBusID = {'timeAtCycleEnd','crnID','nxtID'};
%csvwrite_with_headers('../output/debug/idNxtBusOut.csv',idNxtBusOut,headerNxtBusID);
%clear idNxtBusOut;

busOpSummary = [];
for i=1:length(idInit.signals.values)
    tmpIndices = find(idNxtBusOut(:,2)==idInit.signals.values(i),1);
    if (~isempty(tmpIndices))
        busOpSummary(end+1,:) = [idInit.signals.values(i) idInit.time(i) idNxtBusOut(tmpIndices,1) idNxtBusOut(tmpIndices,3)];
    end
end
headerBusOpSummary = {'busID','depTime','cycleEndTime','nxtID'};
csvwrite_with_headers('../output/debug/busOpSummary.csv',busOpSummary,headerBusOpSummary);
clear busOpSummary idNxtBusOut;

%headerIDInit = {'depTime','busID'};
%csvwrite_with_headers('../output/debug/idInitOut.csv',idInitOut,headerIDInit);
%clear idInitOut;
