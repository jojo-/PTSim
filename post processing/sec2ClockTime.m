function clockTime = sec2ClockTime(sec)
clkHour = floor(sec/3600);
clkMin = floor(mod(sec,3600)/60);
clkSec = mod(mod(sec,3600),60);

charHour = num2str(clkHour);
if (clkHour<10)
    charHour = ['0' num2str(clkHour)];
end

charMin = num2str(clkMin);
if (clkMin<10)
    charMin = ['0' num2str(clkMin)];
end

charSec = num2str(clkSec);
if (clkSec<10)
    charSec = ['0' num2str(clkSec)];
end

clockTime = [charHour ':' charMin ':' charSec];
