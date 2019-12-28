A = [1 2 3; 4 5 6;];
ais = sum(A,2);
ajs = sum(A,1);

b = [1;3;];
x0 = [1;2;4];
x1 = [0;0;0];

x1 = x0 + (A'*((b-A*x0)./ais))./ajs';

for kk = 1:steps
    f00 = f01;
    ik = mod(kk,M) + 1; %Q1(a)(c)
    hik = zeros(1,N);
    disp('hi');
    for jj = 1:N
        hik(jj) = sum((H(:,jj)/sum(H,2)*(g1-H*f00(:))));
        jj
    end
%     ik = ceil(rand(1)*11789); % Q1(b), Q2
%     hik = sum(H(:,ik));
    f01(:) = f00(:) + 1/sum(H,1)*hik;
%     f01(:) = f00(:) - hik'*((hik*f00(:)) - g11(ik)) / (norm(hik))^2;
    RMSE(kk) = sqrt(mean2((f01-f1).^2));
    
end

figure;imshow(f01(:,:),[]);

figure;
plot(RMSE,'LineWidth',3);
xlabel('Iterations','fontname','times','fontsize',16);
ylabel('RMSE','fontname','times','fontsize',16);
titlename = ['Q1(c) RMSE plot'];
title(titlename,'fontname','times','fontsize',16);
% axis([0 steps 0 0.3]);