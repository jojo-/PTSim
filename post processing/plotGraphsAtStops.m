function plotGraphsAtStops()

global rawBusA;

f = figure('Visible','off');

yTickLabels = {};
for iStop = 1:length(rawBusA.stop)-1
    yTickLabels(end+1) = cellstr(rawBusA.stop(iStop).name);
end


% Create pop-up menu
popup = uicontrol('Style', 'popup',...
    'String', yTickLabels,...
    'Position', [5 660 200 50],...
    'Callback', @plotGraphs);
%[20 340 100 50]

% For R2014a and earlier:
%set(f,'Visible','on');
% for later r2014a 
f.Visible = 'on';
