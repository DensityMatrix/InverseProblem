steps = 20000;
% Q1(a)(b) steps = 20000;
RMSE1 = zeros(steps,1);
[M N] = size(H);
f00 = zeros(128,128);
f01 = zeros(128,128);

% g11 = awgn(g1,15.2288,'measured'); % Q1(c)-Method1
% Q1(c)-Method2
n = randn(M,1)*max(g1)*0.03;
g11 = g1 + n;

for kk = 1:steps
    f00 = f01;
    ik = mod(kk,M) + 1; %Q1(a)(c)
%     ik = ceil(rand(1)*11789); % Q1(b), Q2
    hik = H(ik,:);
    f01(:) = f00(:) - hik'*((hik*f00(:)) - g11(ik)) / (norm(hik))^2;
    RMSE1(kk) = sqrt(mean2((f01-f1).^2));
end

figure;imshow(f01(:,:),[]);

% xxx = 1:steps;
% figure;
% plot(xxx,RMSE1,'r',xxx,RMSE,'b','LineWidth',3);
% xlabel('Iterations','fontname','times','fontsize',16);
% ylabel('RMSE','fontname','times','fontsize',16);
% titlename = ['Q1(c) RMSE plot'];
% title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);