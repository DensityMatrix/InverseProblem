steps = 500; g11 = g1*1e7;
% g1(isnan(g1)) = 0;
g0 = poissrnd(g11); % g0(isnan(g0)) = 0;% Poisson noise
% n = randn(M,1)*max(g1)*0.03; g0 = g1 + n; % Gaussian noise
% RMSE = zeros(steps,1);rmse1 = RMSE;
klnl = zeros(steps,1); kln = klnl;
% wlsnl = zeros(steps,1); wlsn = wlsnl;
[M N] = size(H);
x0 = ones(128,128); x00 = x0;
x1 = ones(128,128); x01 = x1;
xc = 1:steps;

his = sum(H,2); % Dim 1*M
hjs = sum(H,1); % Dim N*1

for kk = 1:steps
    x0 = x1; x00 = x01;
    hx0 = H*x0(:); hx00 = H*x00(:);
    % x1(:) = x0(:).*((H'*(g1(:)./(H*x0(:))))./hjs');
    % x01(:) = x00(:).*((H'*(g0(:)./(H*x00(:))))./hjs');
    x1(:) = x0(:).*((H'*(g11(:)./hx0))./hjs');
    x01(:) = x00(:).*((H'*(g0(:)./hx00))./hjs');
    
    x1(isnan(x1)) = 0; x01(isnan(x01)) = 0;
    RMSE(kk) = sqrt(mean2((x1-f1).^2));
    rmse1(kk) = sqrt(mean2((x01-f1).^2));
    
    idx1 = find(g11(:)>0); idx0 = find(g0(:)>0);
    % klnl(kk) = sum(g1(:).*log(g1(:)./(H*x1(:))) + H*x1(:) - g1(:));
    % kln(kk) = sum(g0(:).*log(g0(:)./(H*x01(:))) + H*x01(:) - g0(:));
    klnl(kk) = sum(g11(idx1).*log(g11(idx1)./hx0(idx1)) + hx0(idx1) - g11(idx1));
    kln(kk) = sum(g0(idx0).*log(g0(idx0)./hx00(idx0)) + hx00(idx0) - g0(idx0));
    wlsnl(kk) = norm(g11(:)-hx0)^2; wlsn(kk) = norm(g0(:)-hx00)^2; 
end

figure(1);imshow(x1(:,:),[]);
figure(2);imshow(x01(:,:),[]);

figure(3);
semilogy(xc,RMSE,'-',xc,rmse1,'--','LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('RMSE','fontname','times','fontsize',16);
titlename = ['Q1(b) RMSE plot'];
title(titlename,'fontname','times','fontsize',16);

figure(4);
loglog(xc,klnl,'-',xc,kln,'--','LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('KL distance','fontname','times','fontsize',16);
titlename = ['Q1(c) KL distance plot'];
title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);

figure(5);
loglog(xc,wlsnl,'-',xc,wlsn,'--','LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('Weighted least square','fontname','times','fontsize',16);
titlename = ['Q1(d) WLS plot'];
title(titlename,'fontname','times','fontsize',16);