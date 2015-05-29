function timetableAtCP = makeTimetableAtCP(timetableAtStart, timeFromStartToCP, outFileLoc)
%{
creates timetable at a checkpoint for each bus in the 4 bus batches.
The checkpoint timetable is constructed by adding timeToCP to each
value in the timetableAtStart.
Notes that cycleTime and timeToCP need to be in minutes.
%}

timetableAtCP = timetableAtStart + timeFromStartToCP*60;

xlswrite(outFileLoc,timetableAtCP);

end