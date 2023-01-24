% 从 TSP 文件中读取数据
% 文件源：http://comopt.ifi.uni-heidelberg.de/software/TSPLIB95/tsp/
function [n, cityCoor] = readTsp(filename)
    % n 城市数量
    % cityCoor 城市坐标，每一行是一个城市的坐标
    % filename TSP 的文件名
    
    filetext = fileread(filename);
    regex = 'NODE_COORD_SECTION.+EOF';
    matches = regexp(filetext, regex, 'match');
    text = matches{1};
    textlen = size(text, 2);
    strdata = text(20 : textlen - 4);
    numdata = str2num(strdata);
    n = size(numdata, 1);
    cityCoor = numdata(:, 2:3);

    % 以下是占位数据：burma14 数据
    %n = 14;
    %cityCoor = [16.4700000000000,96.1000000000000;16.4700000000000,94.4400000000000;20.0900000000000,92.5400000000000;22.3900000000000,93.3700000000000;25.2300000000000,97.2400000000000;22,96.0500000000000;20.4700000000000,97.0200000000000;17.2000000000000,96.2900000000000;16.3000000000000,97.3800000000000;14.0500000000000,98.1200000000000;16.5300000000000,97.3800000000000;21.5200000000000,95.5900000000000;19.4100000000000,97.1300000000000;20.0900000000000,94.5500000000000];
end