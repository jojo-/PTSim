close all;

global routeA rawBusA;

nStops = length(rawBusA.stop);

data_boxplot    = [];
data_boxplot_id = [];
data_busarrive  = cell(nStops,1);
data_avgwait    = cell(nStops,1);

for iStop=1:nStops
    if (isempty(rawBusA.stop(iStop).idBusArr))
        continue;
    end
    nBuses = length(rawBusA.stop(iStop).idBusArr(:,1));
    for iBus=1:nBuses        
        %routeA.bus(iBus).paxActivStop(iStop).data(end)
        
        if (routeA.bus(iBus).paxActivStop(iStop).data(end)==0 || isnan(routeA.bus(iBus).paxActivStop(iStop).data(end))) 
            continue;
        end
        
        data_boxplot    = [data_boxplot; routeA.bus(iBus).paxActivStop(iStop).data(end)];
        data_boxplot_id = [data_boxplot_id; iStop];

        data_busarrive{iStop} = [data_busarrive{iStop}; routeA.bus(iBus).paxActivStop(iStop).data(1)];
        data_avgwait{iStop}   = [data_avgwait{iStop}; routeA.bus(iBus).paxActivStop(iStop).data(end)];
        
    end

end

data_boxplot = data_boxplot/60; % convert avergage wait time to minutes

figure;
boxplot(data_boxplot,data_boxplot_id)

% finding and removing the outliers
h_outliers=findobj(gca,'tag','Outliers');
set(h_outliers,'Visible','off')

%{
%adding the max
vec_max = zeros(max(data_boxplot_id),1); 
for i = 1:length(vec_max)
     vec_max(i) = max(data_boxplot(data_boxplot_id == i)); 
end

hold on;
plot(vec_max,'rX')
hold off;
%}

hold on;
idealWTime = 40/4/2;
plot ([1 18], [idealWTime idealWTime], 'k--')
hold off;
 
xTickLabels = {};
xTickValues = [1:1:length(rawBusA.stop)-1];
for iStop = 1:(length(rawBusA.stop)-1)
    xTickLabels(end+1) = cellstr(rawBusA.stop(iStop).name);
end
ylabel('avg wait time (minutes)');
set(gca,'XTick',xTickValues, 'XTickLabel',xTickLabels);
axis([0 (length(rawBusA.stop)-1) 0 inf]);
rotateticklabel(gca,-30);


%{
figure;
boxplot(data_boxplot,data_boxplot_id)

% finding and removing the outliers
h_outliers=findobj(gca,'tag','Outliers');
set(h_outliers,'Visible','off')

% adding the max
hold on
plot( max(data_boxplot),'X' )
%}

%figure;
%stopToPlot=5;
%plot(data_busarrive{stopToPlot},data_avgwait{stopToPlot});

save('data_gui.mat','data_busarrive', 'data_avgwait','data_boxplot','data_boxplot_id');


%units: seconds
%% avg waiting time of passengers sucessfully boarded bus iBus at stop iStop
%routeA.bus(iBus).paxActivStop(iStop).data(end)
%% time bus iBus arrives at stop iStop
%routeA.bus(iBus).paxActivStop(iStop).data(1)

