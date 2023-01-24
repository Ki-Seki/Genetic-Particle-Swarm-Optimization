% 对粒子 particle 进行交叉操作，将 another 中的部分交叉至 particle
function particle = crossover(particle, another)
    % particle 行向量，一个粒子
    % another 另外一个粒子
    
    % 计算粒子长度
    n = size(particle, 2);
    % 产生两个交叉点
    c1 = unidrnd(n - 1);
    c2 = unidrnd(n - 1);
    % 保证交叉点不同
    while c1 == c2
        c1 = round(rand * (n-2) + 1);
        c2 = round(rand * (n-2) + 1);
    end
    % chb1 和 chb2 分别为两个交叉点中的小值和大值
    chb1 = min(c1, c2);
    chb2 = max(c1, c2);
    % 获得交叉区域
    cros = another(chb1:chb2);
    % 交叉区域元素个数
    ncros = size(cros, 2);
    % 删除交叉区域中相同的粒子，删除具体逻辑是：
    % 把与交叉区域中相同的元素全部移到末尾，
    % 最后插入时，直接插到末尾
    % 这里的代码其实是毫无逻辑的
    for j = 1 : ncros
        for k = 1 : n
            if particle(k) == cros(j)
                for t = 1 : n-k
                    tmp = particle(k+t-1);
                    particle(k+t-1) = particle(k+t);
                    particle(k+t) = tmp;
                end
            end
        end
    end
    % 插入交叉区域，也就是插到末尾
    particle(n-ncros+1 : n) = cros;
end