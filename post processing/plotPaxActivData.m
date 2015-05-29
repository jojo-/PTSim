function plotPaxActivData(routeA,stopID)

% columns in routeA.bus(iBus).paxActivStop(iStop).data
colTime = 1;
colVacanIn = 2;
colPaxDemand = 3;
colPaxAlight = 4;
colPaxWait = 5;
colPaxBoard = 6;
colPaxRemain = 7;
colNewVacan = 8;
colAvgWaitTime = 9;

time = [];
paxDemand = [];
paxAlight = [];
paxBrd = [];
wTime = [];

for iBus = 1:length(routeA.bus)
    % if this bus iBus travels past this stop
    if (length(routeA.bus(iBus).paxActivStop)>=stopID) 
        time(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colTime);
        paxDemand(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colPaxDemand);
        paxAlight(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colPaxAlight);
        paxBrd(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colPaxBoard);
        wTime(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colAvgWaitTime);
    end
end

startTime = 7*3600; %seconds. Simulation (or 1st bus) starts at 7.00am.
simSeconds = routeA.bus(end).op(end,2);
simHours = ceil(simSeconds/3600);
plotSeconds = simHours*3600;
xTickValues = [0:20*60:plotSeconds];
xTickLabels = {};
for iXTick = 1:length(xTickValues)
    xTickLabels(iXTick) = cellstr(sec2ClockTime(xTickValues(iXTick)+startTime));
end

subplot(2,2,1)
plot(time, paxDemand, 'ro');
ylabel('paxDemand');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);

subplot(2,2,2)
plot(time, paxAlight, 'ro');
ylabel('paxAlight');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);

subplot(2,2,3)
plot(time, paxBrd, 'ro');
ylabel('paxBoard');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);

subplot(2,2,4)
plot(time, wTime, 'ro');
ylabel('avg wait time (sec)');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);

end
