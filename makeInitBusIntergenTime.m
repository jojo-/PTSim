function initBusIntergenTime = makeInitBusIntergenTime(cycleTime,outFileLoc)
%{
creates intergenration time for the 1st bus in each of the 4 batches based
on the cycle time.
For example if cycle time is 40 minutes, the intergeneration time of 1st
buses are 
1st bus batch 1: 1 second, 
1st bus batch 2: 600 seconds,
1st bus batch 3: 1200 seconds,
1st bus batch 4: 1200 seconds,

the 5th value in the output is for replacement bus and takes value 0, which
means that the replacement bus is available at the very beginning.

Notes that the cycleTime needs to be in minutes.

Example of execution:
>> makeInitBusIntergenTime(40,'./input data/testIntergenTime.xls');
%}

initBusIntergenTime(1) = 1; % 1st bus of batch 1. This value is always 1 regardless of the cycleTime.
initBusIntergenTime(2) = cycleTime*60/4; % 1st bus of batch 2;
initBusIntergenTime(3) = 2*cycleTime*60/4; % 1st bus of batch 3;
initBusIntergenTime(4) = 3*cycleTime*60/4; % 1st bus of batch 4;

initBusIntergenTime(5) = 0; % 1st bus of replacement buses.

xlswrite(outFileLoc,initBusIntergenTime);

end