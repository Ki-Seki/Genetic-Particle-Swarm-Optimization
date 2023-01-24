% 对粒子 particle 进行变异操作
function particle = mutation(particle)
    % particle 行向量，一个粒子
    
    % 计算粒子长度
    n = size(particle, 2);
    % 产生两个变异位置
    c1 = round(rand * (n-2) + 1);
    c2 = round(rand * (n-2) + 1);
    % 保证 c1 和 c2不同
    while c1 == c2
        c1 = round(rand * (n-2) + 1);
        c2 = round(rand * (n-2) + 1);
    end
    % 变异，也即交换两个变异点
    t = particle(c1);
    particle(c1) = particle(c2);
    particle(c2) = t;
end