% 以粒子 particle 为解，绘制出 TSP 回路
function drawPath(particle, cityCoor)
    % particle 一个粒子，在 TSP 问题中，即一个路径序列
    % cityCoor 各节点坐标
    
    n = size(particle, 2);
    rearranged = zeros(n+1, 2);  % 因为是回路，所以为 n+1
    for i = 1 : n
        rearranged(i, :) = cityCoor(particle(i), :);
    end
    rearranged(n+1, :) = cityCoor(particle(1), :);
    plot(rearranged(:, 1), rearranged(:, 2), 'r-x');
end