% 用于计算适应度，即路径长度，值越小越好
function indiFit = fitness(x, cityCoor, cityDist )
    % x 粒子种群，每一行代表一个个体
    % cityCoor 城市坐标
    % cityDist 城市距离
    % indiFit 个体适应度

    m = size(x, 1);  % 个体数量
    n = size(cityCoor, 1);  % 城市数量
    indiFit = zeros(m, 1);  % 3×1 数组矩阵
    for i = 1 : m  % 为每个个体计算适应度
        for j = 1 : n-1
            indiFit(i) = indiFit(i) + cityDist(x(i,j), x(i,j+1));
        end
        indiFit(i) = indiFit(i) + cityDist(x(i,1), x(i,n));  % 完成回路
    end
end
