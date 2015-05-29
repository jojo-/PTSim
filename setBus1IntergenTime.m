function data = setBus1IntergenTime()
raw_data = xlsread('input data/derived/initBusIntergenTime.xls','Sheet1', '', 'basic');
data = raw_data(:,1);