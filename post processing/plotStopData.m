function plotStopData(routeA,stopID)

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
timeGap = [];
paxDemand = [];
paxAlight = [];
paxBoard = [];
paxRemain = [];
vacanIn = [];
vacanOut = [];

for iBus = 1:length(routeA.bus)
    % if this bus iBus travels past this stop
    if (length(routeA.bus(iBus).paxActivStop)>=stopID) 
        if (length(time)==0)
            timeGap(end+1)=0;
            time(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colTime);
        else 
            time(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colTime);
            timeGap(end+1) = (time(length(time)) - time(length(time)-1))/60;
        end
        
        paxDemand(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colPaxDemand);
        paxAlight(end+1) = -routeA.bus(iBus).paxActivStop(stopID).data(colPaxAlight);
        
        paxBoard(end+1) = -routeA.bus(iBus).paxActivStop(stopID).data(colPaxBoard);
        paxRemain(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colPaxRemain);
        
        vacanIn(end+1) = routeA.bus(iBus).paxActivStop(stopID).data(colVacanIn);
        vacanOut(end+1) = -routeA.bus(iBus).paxActivStop(stopID).data(colNewVacan);
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
plot(time,timeGap,'ko'); hold on;
%bar(time,timeGap);
ylabel('timeGap (minutes)');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);
hold off;

subplot(2,2,2)
bar(time, paxDemand); hold on;
bar(time, paxAlight);
plot(time, paxDemand, 'ko');
plot(time, paxAlight, 'ko');
ylabel('paxAlight/paxDemand');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);
hold off;

subplot(2,2,3)
bar(time, paxBoard); hold on;
bar(time, paxRemain);
plot(time, paxBoard, 'ko');
plot(time, paxRemain, 'ko');
ylabel('paxBoard/paxRemain');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);
hold off;

subplot(2,2,4)
bar(time, vacanOut); hold on;
bar(time, vacanIn);
plot(time, vacanIn, 'ko');
plot(time, vacanOut, 'ko');
ylabel('vacancyOut/vacancyIn');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds]);
rotateticklabel(gca,90);
hold off;

end