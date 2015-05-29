function data = setBusRepIntergenTime()
raw_data = xlsread('input data/derived/initBusIntergenTime.xls','Sheet1', '', 'basic');
data = raw_data(:,5);
