% 用遗传-粒子群混合算法解决 TSP 问题

% 以下是论文中第四章代码的重现
% 《陈克明. 动态多智能算法及其在物流配送系统中的应用研究[D/OL]. 东华大学, 2018.https://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CDFD&dbname=CDFDLAST2019&filename=1018995735.nh&v=.》
% 并非源代码，仅是按照论文中思路的代码重现
% 作者：宋世超
% 邮箱：Ki_Seki@outlook.com

clear;
clc;
close all;

%% 参数设置
dataSet = 'burma14';  % 数据集名称，不带后缀 '.tsp'
nMax = 75;  % 进化次数
indiNumber = 100;  % 个体数目

%% 初始化
[n, cityCoor] = readTsp([dataSet, '.tsp']);  % 读取数据集中的城市数和城市坐标
cityDist = zeros(n, n);  % 城市的邻接矩阵
individual = zeros(indiNumber, n);  % 个体数组，即 indiNumber 个粒子

% 计算邻接矩阵值
for i = 1 : n
    for j = i : n
        x2 = power(cityCoor(i,1) - cityCoor(j, 1), 2);
        y2 = power(cityCoor(i,2) - cityCoor(j, 2), 2);
        cityDist(i, j) = sqrt(x2 + y2);
        cityDist(j, i) = cityDist(i, j);
    end
end

% 为每个粒子生成随机的路径序列
for i = 1 : indiNumber
    individual(i, :) = randperm(n);
end

%% 初始化各个粒子的适应度和对应路径
indiFit = fitness(individual, cityCoor, cityDist);
[~, index] = min(indiFit);
pBest = individual;  % 个体最优值对应的路径
gBest = individual(index, :);  % 全局最优值对应的路径
pBestFitness = inf * ones(1, indiNumber);  % 个体最优值
gBestFitness = indiFit(index);  % 全局最优值

%% 核心循环过程
for i = 1 : nMax
    for j = 1 : indiNumber
        % 对第 j 个粒子进行交叉操作
        p = crossover(individual(j, :), pBest(j, :));
        % 如果值更好，就更新当前 individual
        if fitness(individual(j, :), cityCoor, cityDist) > fitness(p, cityCoor, cityDist)
            individual(j, :) = p;
        end
        % 对第 j 个粒子进行变异操作
        p = mutation(individual(j, :));
        % 如果值更好，就更新当前 individual
        if fitness(individual(j, :), cityCoor, cityDist) > fitness(p, cityCoor, cityDist)
            individual(j, :) = p;
        end
        % 计算新粒子的适应度
        newFit = fitness(individual(j, :), cityCoor, cityDist);
        % 如果值更好，就更新个体最优，即 pBest
        if pBestFitness(j) > newFit
            pBestFitness(j) = newFit;
            pBest(j, :) = individual(j, :);
        end
    end
    % 计算本轮迭代最好适应度
    [bestFit, bestIndex] = min(pBestFitness);
    % 如果值更好，就更新
    if gBestFitness > bestFit
        gBestFitness = bestFit;
        gBest = pBest(bestIndex, :);
    end
    
    % 绘图
    plot(i, gBestFitness, '.');
    hold on;
end

%% 输出
% 结束收敛过程的绘图
title(['PSO 收敛过程（数据集：', dataSet, '）']);
xlabel('迭代次数');
ylabel('适应度值');
hold off;
% 绘制最优路径图
figure(2);
drawPath(gBest, cityCoor);
title(['PSO 最优路径（数据集：', dataSet, '）']);
xlabel('横坐标');
ylabel('纵坐标');
% 输出值
disp(gBest);
disp(gBestFitness);
