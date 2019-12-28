steps = 20000;
% Q1(a)(b) steps = 20000;
RMSE = zeros(steps,1);
[M N] = size(H);
x0 = zeros(128,128);
x1 = zeros(128,128);

his = sum(H,2); % Dim 1*M
hjs = sum(H,1); % Dim N*1

% g11 = awgn(g1,15.2288,'measured'); % Q1(c)-Method1
% Q1(c)-Method2
n = randn(M,1)*max(g1)*0.03;
g11 = g1 + n;

for kk = 1:steps
    x0 = x1;
    ik = mod(kk,M) + 1;
%     ik = ceil(rand(1)*11789); % Q1(b), Q2
    x1(:) = x0(:) + (H'*((g11(:)-H*x0(:))./his))./hjs';
    x1(isnan(x1)) = 0;
    RMSE(kk) = sqrt(mean2((x1-f1).^2));
end

figure;imshow(x1(:,:),[]);

figure;
plot(RMSE,'LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('RMSE','fontname','times','fontsize',16);
titlename = ['Q1(d) RMSE plot'];
title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);