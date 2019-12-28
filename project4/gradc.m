steps = 100;
gamma = zeros(steps,1); % RMSE = zeros(steps,1);
% [M N] = size(H);
x0 = zeros(128,128);
x1 = zeros(128,128);
alpha = 1/2/norm(H'*H,'fro');
% stepsize 0.25 0.5 1 3.5 4; 3.5L for (b) and (d)

% add Gaussian white noise
% n = randn(M,1)*max(g1)*0.03;
% g11 = g1 + n;

for kk = 1:steps
    x0 = x1;
    beta = H*x0(:) - g1(:);
    x1(:) = x0(:) - alpha*2*H'*beta;
    x1(isnan(x1)) = 0;
%     RMSE(kk) = sqrt(mean2((x1-f1).^2));
    gamma(kk) = norm(beta)^2;
end

figure;imshow(x1(:,:),[]);

figure;
semilogy(gamma,'LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('Least square function','fontname','times','fontsize',16);
titlename = ['Q3(d) Least squares plot'];
title(titlename,'fontname','times','fontsize',16);

% figure;
% plot(RMSE,'LineWidth',3);
% xlabel('Iterations','fontname','times','fontsize',16);
% ylabel('RMSE','fontname','times','fontsize',16);
% titlename = ['Q3(c) RMSE plot'];
% title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);