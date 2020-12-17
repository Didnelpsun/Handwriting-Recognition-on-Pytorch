clc;
clear;
X = xlsread('data\normaliz_data.xls');
X;
[Y,PS] = mapminmax(X);
Y;
X=mapminmax('reverse',Y,PS);
X;
clc;
clear;


data = xlsread('data\discretization_data.xls');
% 分为4类
k = 4;
min = min(data);
max = max(data);
section = (max-min)/k;
variable = min;
rules = zeros(1,k+1);
for i=1:k+1
    rules(i) = variable;
    variable = variable + section;
end
rules;
clear i min max section variable;
rows = size(data,1);
width_data = zeros(k, rows);
for i=1:k
    vardata = data(find(data(1:end,1)>=rules(i)&data(1:end,1)<rules(i+1)));
    if(i==k)
        vardata = [vardata;data([find(data(1:end) == rules(i+1))])];
    end
    for j=1:size(vardata)
        width_data(i,j) = vardata(j);
    end
end
clear i j vardata;
sort_data = sort(data);
row = floor(rows/k);
if(row*k==rows)
    frequancy_data = [k, row];
else
    row = row + 1;
    frequancy_data = [k, row];
end
for i=1:k
    for j=1:row
        if((i-1)*row+j<=rows)
            frequancy_data(i,j) = sort_data((i-1)*row+j);
        end
    end
end
clear i j row sort_data;