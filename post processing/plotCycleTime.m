function plotCycleTime()

global routeA rawBusA;

timeBus = [];
cycleTime = [];

timeBus1 = [];
cycleTimeBus1 = [];

timeBus2 = [];
cycleTimeBus2 = [];

timeBus3 = [];
cycleTimeBus3 = [];

timeBus4 = [];
cycleTimeBus4 = [];

timeBusRep = [];
cycleTimeBusRep = [];

for iBus=1:length(routeA.bus)
    % if the last stop that this bus services is not the end of the cycle
    % do not calculate cycle time for this bus
    if (max(routeA.bus(iBus).op(:,1))<length(rawBusA.stop))
        continue;
    end

    busBatch = floor(routeA.bus(iBus).busID/10000);
    
    switch busBatch
        case 1
            timeBus1(end+1) = routeA.bus(iBus).op(1,2);
            cycleTimeBus1(end+1) = (routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2))/60;
        case 2
            timeBus2(end+1) = routeA.bus(iBus).op(1,2);
            cycleTimeBus2(end+1) = (routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2))/60;
        case 3
            timeBus3(end+1) = routeA.bus(iBus).op(1,2);
            cycleTimeBus3(end+1) = (routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2))/60;
        case 4
            timeBus4(end+1) = routeA.bus(iBus).op(1,2);
            cycleTimeBus4(end+1) = (routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2))/60;
        otherwise
            timeBusRep(end+1) = routeA.bus(iBus).op(1,2);
            cycleTimeBusRep(end+1) = (routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2))/60;
    end
    
    timeBus(end+1) = routeA.bus(iBus).op(1,2)+7*3600;
    cycleTime(end+1) = routeA.bus(iBus).op(end,2) - routeA.bus(iBus).op(1,2);
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

timeBus1 = (timeBus1 + 7*3600)/3600;
timeBus2 = (timeBus2 + 7*3600)/3600;
timeBus3 = (timeBus3 + 7*3600)/3600;
timeBus4 = (timeBus4 + 7*3600)/3600;
if (~isempty(timeBusRep))
    timeBusRep = (timeBusRep + 7*3600)/3600;
end

figure;
plot(timeBus1,cycleTimeBus1,'ko', timeBus1,cycleTimeBus1, 'k-'); hold on;
plot(timeBus2,cycleTimeBus2,'ks', timeBus2,cycleTimeBus2, 'k-');
plot(timeBus3,cycleTimeBus3,'kx', timeBus3,cycleTimeBus3, 'k-');
plot(timeBus4,cycleTimeBus4,'k^', timeBus4,cycleTimeBus4, 'k-');
if (~isempty(timeBusRep))
    plot(timeBusRep,cycleTimeBusRep,'ro', timeBusRep,cycleTimeBusRep, 'r-');
end
hold off;
ylabel('cycleTime (minutes)');
xlabel('departure time at Northfields');


header = {'depTime(sec)' 'cycleTime(sec)'};
cycleTimeOut = [timeBus' cycleTime'];
csvwrite_with_headers('../output/cycleTime.csv',cycleTimeOut,header);

end