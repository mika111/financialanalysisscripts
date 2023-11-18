%k = ((current close - lowest low)/(highest high - lowest low)) 
%Date	Open	High	Low	Close	Adj Close	Volume

%d = 3 day ma of %k

data = readtable("TSMstockpostcovid.csv");



[i,curr] = findk(data,100);
rows = size(data,1);
x = [];
y = [];
disp(rows);

for index = 14:rows

    [l,m] = findk(data,index)
    x(end + 1) = l;
    y(end + 1) = m;


end

time = datetime(y,'ConvertFrom','datenum');




smooth = [];

for avgind = 7:1:length(x)

smooth(end + 1) = (x(avgind) + x(avgind - 1) + x(avgind - 2) + x(avgind - 3) + x(avgind - 4) + x(avgind - 5) + x(avgind - 6))/7;

end

plot(time,x,'b',time(7:end),smooth,'r');
xlim([datetime('12/06/2021'),datetime('now')]);
legend("%K","%D");
disp(smooth);
%plot(time(7:end),smooth,'b');

function [k,currentd] = findk(data,currentindex)
    highs = [];
    lows = [];
    pointer = 0;
    currentd = (datenum(data{currentindex,'Date'}));
  
    currentdate = datetime(data{currentindex,'Date'});
    currclose = data{currentindex,'Close'};
    while true

        if days(datetime(data{currentindex,'Date'}) - datetime(data{currentindex - pointer,'Date'})) > 14
            disp("break");
            break;
        else
            highs(end + 1) = data{currentindex - pointer,'High'};
            lows(end + 1) = data{currentindex - pointer,'Low'};
            pointer = pointer +1;

        end
    end

    k = ((currclose - min(lows))/(max(highs) - min(lows))) * 100;
end

