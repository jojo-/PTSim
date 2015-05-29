function plotGraphs(source,callbackdata)

global routeA;

% For later R2014a
val = source.Value;
maps = source.String;

% For R2014a and earlier: 
%val = get(source,'Value');

%plotPaxActivData(routeA,val);
plotStopData(routeA,val);