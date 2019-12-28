steps = 100;
gamma = zeros(steps,1);% RMSE = zeros(steps,1);
% [M N] = size(H);
x0 = zeros(128,128);
x1 = zeros(128,128);
alpha = 7/0.0024;
beta = 0.5; eta = 0.99;

% add Gaussian white noise
% n = randn(M,1)*max(g1)*0.03;
% g11 = g1 + n;

for kk = 1:steps
    x0 = x1; t = alpha; a1 = H*x0(:) - g1(:);
    grad = 2* H'* a1;
    lsq0 = lsq(x0,H,g1);
    while (lsq0-lsq(x0(:)-t*grad, H, g1)<eta*t*norm(grad)^2)
        t = beta*t;
    end
    x1(:) = x0(:) - t*grad;
    x1(isnan(x1)) = 0;
    gamma(kk) = norm(a1)^2;
    % RMSE(kk) = sqrt(mean2((x1-f1).^2));
end

figure;imshow(x1(:,:),[]);

figure;
semilogy(gamma,'LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('Least square function','fontname','times','fontsize',16);
titlename = ['Q4(c) Least squares plot, eta = ' num2str(eta)];
title(titlename,'fontname','times','fontsize',16);

% figure;
% plot(RMSE,'LineWidth',3);
% xlabel('Iterations','fontname','times','fontsize',16);
% ylabel('RMSE','fontname','times','fontsize',16);
% titlename = ['Q4(d) RMSE plot'];
% title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);