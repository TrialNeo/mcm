%% 层次分析法 Analytic Hierarchy Process, AHP
% 只有非一致性矩阵才需要进行一致性检验
% 来一个测试用的
% A = [1 2 5; 1/2 1 2; 1/5 1/2 1]
%% 清除
clc;
%% 要求输入
disp('请输入判断矩阵');
A = input('A=');
[~, n] = size(A);

%% 通过算数平均求权重
sum_A = sum(A);
sum_A_row = repmat(sum_A, n, 1);
stand_A = A ./ sum_A;

w1 = sum(stand_A, 2) ./ n;
disp(['通过算数平均求权重的结果为：', mat2str(w1)]);

%% 通过特征值求权重
[V, D] = eig(A);
max_eig = max(max(D));

[r, c] = find(D == max_eig, 1);
w2 = V(:, c) ./ sum(V(:, c));
disp(['特征值求权重的结果为: ', mat2str(w2)]);

%% 再求平均比较准确
w_mean = (w1 + w2) ./ 2;

disp(['the mean of the two: ', mat2str(w_mean)]);

%% 计算一致性比例CR
CI = (max_eig - n) / (n - 1);
RI = [0 1e-10 0.52 0.89 1.12 1.26 1.36 1.41 1.46 1.49 1.52 1.54 1.56 1.58 1.59];
CR = CI / RI(n);
disp(['Random Index, RI = ', num2str(RI(n))]);
disp(['一致性指标 CI = ', num2str(CI)]);
disp(['一致性比例 CR = ', num2str(CR)]);

if CR >= 0.1
    disp('判断矩阵不一致');
    exit(0)
end

disp('一致性检验通过');
