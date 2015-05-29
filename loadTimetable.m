clear all;

disp('start PreloadFcn, executing loadTimetable.m ...');

rawConst = xlsread('input data/user input/constants.xls','Sheet1', '', 'basic');
tConst = 0;
maxBusCap = rawConst(1);
tBoardPerPax = rawConst(2);
cycleTime = rawConst(3);
tSchedToCP2 = rawConst(4);
tSchedToCP3 = rawConst(5);
tSchedToCP4 = rawConst(6);
disp('finished loading constants.xls!');

rawDataPaxArrive = xlsread('input data/user input/paxRateDemand.xls','Sheet1', '', 'basic');
t = rawDataPaxArrive(:,1);
arrS1 = rawDataPaxArrive(:,2);
arrS2 = rawDataPaxArrive(:,3);
arrS3 = rawDataPaxArrive(:,4);
arrS4 = rawDataPaxArrive(:,5);
arrS5 = rawDataPaxArrive(:,6);
arrS6 = rawDataPaxArrive(:,7);
arrS7 = rawDataPaxArrive(:,8);
arrS8 = rawDataPaxArrive(:,9);
arrS9 = rawDataPaxArrive(:,10);
arrS10 = rawDataPaxArrive(:,11);
arrS11 = rawDataPaxArrive(:,12);
arrS12 = rawDataPaxArrive(:,13);
arrS13 = rawDataPaxArrive(:,14);
arrS14 = rawDataPaxArrive(:,15);
arrS15 = rawDataPaxArrive(:,16);
arrS16 = rawDataPaxArrive(:,17);
arrS17 = rawDataPaxArrive(:,18);
arrS18 = rawDataPaxArrive(:,19);
disp('finished loading paxRateDemand.xls!');

rawDataPaxAlight = xlsread('input data/user input/paxRateAlight.xls','Sheet1', '', 'basic');
t = rawDataPaxAlight(:,1);
alightS1 = rawDataPaxAlight(:,2);
alightS2 = rawDataPaxAlight(:,3);
alightS3 = rawDataPaxAlight(:,4);
alightS4 = rawDataPaxAlight(:,5);
alightS5 = rawDataPaxAlight(:,6);
alightS6 = rawDataPaxAlight(:,7);
alightS7 = rawDataPaxAlight(:,8);
alightS8 = rawDataPaxAlight(:,9);
alightS9 = rawDataPaxAlight(:,10);
alightS10 = rawDataPaxAlight(:,11);
alightS11 = rawDataPaxAlight(:,12);
alightS12 = rawDataPaxAlight(:,13);
alightS13 = rawDataPaxAlight(:,14);
alightS14 = rawDataPaxAlight(:,15);
alightS15 = rawDataPaxAlight(:,16);
alightS16 = rawDataPaxAlight(:,17);
alightS17 = rawDataPaxAlight(:,18);
alightS18 = rawDataPaxAlight(:,19);
disp('finished loading paxRateAlight.xls!');

rawLinkProp = xlsread('input data/user input/linkProperties.xls','Sheet1', '', 'basic');
tTravTime = 0;
tTravL1 = rawLinkProp(1,3);
tTravL2 = rawLinkProp(2,3);
tTravL3 = rawLinkProp(3,3);
tTravL4 = rawLinkProp(4,3);
tTravL5 = rawLinkProp(5,3);
tTravL6 = rawLinkProp(6,3);
tTravL7 = rawLinkProp(7,3);
tTravL8 = rawLinkProp(8,3);
tTravL9 = rawLinkProp(9,3);
tTravL10 = rawLinkProp(10,3);
tTravL11 = rawLinkProp(11,3);
tTravL12 = rawLinkProp(12,3);
tTravL13 = rawLinkProp(13,3);
tTravL14 = rawLinkProp(14,3);
tTravL15 = rawLinkProp(15,3);
tTravL16 = rawLinkProp(16,3);
tTravL17 = rawLinkProp(17,3);
tTravL18 = rawLinkProp(18,3);
disp('finished loading linkProperties.xls!');

rawLinkDelay = xlsread('input data/user input/linkDelay.xls','Sheet1', '', 'basic');
tLinkDelay = rawLinkDelay(:,1);
delayL1 = rawLinkDelay(:,2);
delayL2 = rawLinkDelay(:,3);
delayL3 = rawLinkDelay(:,4);
delayL4 = rawLinkDelay(:,5);
delayL5 = rawLinkDelay(:,6);
delayL6 = rawLinkDelay(:,7);
delayL7 = rawLinkDelay(:,8);
delayL8 = rawLinkDelay(:,9);
delayL9 = rawLinkDelay(:,10);
delayL10 = rawLinkDelay(:,11);
delayL11 = rawLinkDelay(:,12);
delayL12 = rawLinkDelay(:,13);
delayL13 = rawLinkDelay(:,14);
delayL14 = rawLinkDelay(:,15);
delayL15 = rawLinkDelay(:,16);
delayL16 = rawLinkDelay(:,17);
delayL17 = rawLinkDelay(:,18);
delayL18 = rawLinkDelay(:,19);
disp('finished loading linkDelay.xls!');

rawTimetbl = makeTimetableAtStart(cycleTime,'./input data/derived/dervd_ttableAtStart.xls');
%rawTimetbl = xlsread('input data/derived/busTimetable_sec.xls','Sheet1', '', 'basic');
timetable.time = 0;
timetable.signals.values = rawTimetbl;
sizeTimetable = size(rawTimetbl);
timetable.signals.dimensions = [sizeTimetable(1) sizeTimetable(2)];
disp('finished loading busTimetable_sec.xls!');

rawTimetblChkPnt2 = makeTimetableAtCP(rawTimetbl,tSchedToCP2,'./input data/derived/dervd_ttableCP2.xls');
%rawTimetblChkPnt2 = xlsread('input data/busTimetableChkPnt2_sec.xls','Sheet1', '', 'basic');
timetblChkPnt2.time = 0;
timetblChkPnt2.signals.values = rawTimetblChkPnt2;
sizeTimetable = size(rawTimetblChkPnt2);
timetblChkPnt2.signals.dimensions = [sizeTimetable(1) sizeTimetable(2)];
disp('finished loading busTimetableChkPnt2_sec.xls!');

rawTimetblChkPnt3 = makeTimetableAtCP(rawTimetbl,tSchedToCP3,'./input data/derived/dervd_ttableCP3.xls');
%rawTimetblChkPnt3 = xlsread('input data/busTimetableChkPnt3_sec.xls','Sheet1', '', 'basic');
timetblChkPnt3.time = 0;
timetblChkPnt3.signals.values = rawTimetblChkPnt3;
sizeTimetable = size(rawTimetblChkPnt3);
timetblChkPnt3.signals.dimensions = [sizeTimetable(1) sizeTimetable(2)];
disp('finished loading busTimetableChkPnt3_sec.xls!');

rawTimetblChkPnt4 = makeTimetableAtCP(rawTimetbl,tSchedToCP4,'./input data/derived/dervd_ttableCP4.xls');
%rawTimetblChkPnt4 = xlsread('input data/busTimetableChkPnt4_sec.xls','Sheet1', '', 'basic');
timetblChkPnt4.time = 0;
timetblChkPnt4.signals.values = rawTimetblChkPnt4;
sizeTimetable = size(rawTimetblChkPnt4);
timetblChkPnt4.signals.dimensions = [sizeTimetable(1) sizeTimetable(2)];
disp('finished loading busTimetableChkPnt4_sec.xls!');

makeInitBusIntergenTime(cycleTime,'./input data/derived/initBusIntergenTime.xls');

clear rawConst rawTimetbl rawTimetblChkPnt2 rawTimetblChkPnt3 rawTimetblChkPnt4 ...
    sizeTimetable;

disp('finished loadTimetable.m!');