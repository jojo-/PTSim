function plotBusOp()

global routeA rawBusA;

%{
for iBus = 1:length(routeA.bus)
    plot(routeA.bus(iBus).op(:,1),routeA.bus(iBus).op(:,2),'-k',routeA.bus(iBus).op(:,1),routeA.bus(iBus).op(:,2),'or');
    hold on;
end
grid on;
%}

% processes routeA.bus().op for plotting
clear routeAPlot xTickValues xTickLabels yTickValues yTickLabels;
startTime = 7*3600; %seconds. Simulation (or 1st bus) starts at 7.00am.
for iBus = 1:length(routeA.bus)
    routeAPlot.bus(iBus).busID = routeA.bus(iBus).busID;
    for iRow=1:length(routeA.bus(iBus).op(:,1))
        stopID = routeA.bus(iBus).op(iRow,1);
        routeAPlot.bus(iBus).op(iRow,1) = rawBusA.stop(stopID).dist;
        routeAPlot.bus(iBus).op(iRow,2) = routeA.bus(iBus).op(iRow,2);
    end
end

%{
xTickLabels = {};
for iBus = 1:length(routeAPlot.bus)
    xTickLabels(end+1) = cellstr(sec2ClockTime(routeAPlot.bus(iBus).op(1,2)));
end
%}
xTickValues = [];
simSeconds = routeAPlot.bus(end).op(end,2);
simHours = ceil(simSeconds/3600);
plotSeconds = simHours*3600;
xTickValues = [0:20*60:plotSeconds];
xTickLabels = {};
for iXTick = 1:length(xTickValues)
    xTickLabels(iXTick) = cellstr(sec2ClockTime(xTickValues(iXTick)+startTime));
end


yTickLabels = {};
yTickValues = [];
for iStop = 1:length(rawBusA.stop)
    yTickLabels(end+1) = cellstr(rawBusA.stop(iStop).name);
    yTickValues(end+1) = rawBusA.stop(iStop).dist;
end

figure;
for iBus = 1:length(routeAPlot.bus)
    % if this bus is a replacement bus
    if floor(routeAPlot.bus(iBus).busID/10000)==9 
        plot(routeAPlot.bus(iBus).op(:,2),routeAPlot.bus(iBus).op(:,1),'-b',...
        routeAPlot.bus(iBus).op(:,2),routeAPlot.bus(iBus).op(:,1),'or');
    else
        plot(routeAPlot.bus(iBus).op(:,2),routeAPlot.bus(iBus).op(:,1),'-k',...
            routeAPlot.bus(iBus).op(:,2),routeAPlot.bus(iBus).op(:,1),'or');
    end
    
    hold on;
end
hold off;
grid on;

set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels, 'XLim', [0 plotSeconds], ...
    'YTick', yTickValues, 'YTickLabel',yTickLabels);

rotateticklabel(gca,90);

end