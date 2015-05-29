function data = setBus2IntergenTime()
raw_data = xlsread('input data/derived/initBusIntergenTime.xls','Sheet1', '', 'basic');
data = raw_data(:,2);