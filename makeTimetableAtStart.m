function timetableAtStart = makeTimetableAtStart(cycleTime,outFileLoc)
%{
creates a timetable of scheduled buses based on cycle time.
For example is the cycle time is 40 minutes, the timetable of 4 batches of
buses will look like below
    [0	600	1200	1800;
    2400	3000	3600	4200;
    4800	5400	6000	6600;
    7200	7800	8400	9000;
    9600	10200	10800	11400;
    12000	12600	13200	13800;
    14400	15000	15600	16200;
    16800	17400	18000	18600;
    ...]
Notes that cycleTime needs to be in minutes
%}

cycleTimeSec = cycleTime*60; % converts cycleTime into seconds

% creates first line of the timetable
timetableAtStart = [0 cycleTimeSec/4 2*cycleTimeSec/4 3*cycleTimeSec/4];

% if the scheduled departure time (in seconds) of the last bus of the last 
% batch (batch 4) is still within 24 hours, keeps generating new line in
% the timetable
cntLine = 1;
while (timetableAtStart(end,4)<24*3600)
    timetableAtStart(end+1,:) = timetableAtStart(cntLine,:) + cycleTimeSec;
    cntLine = cntLine+1;
end

xlswrite(outFileLoc,timetableAtStart);

end