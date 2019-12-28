clear all; clc;

% the cost function 0.5*(least square function)
% F = 0.5x'Ax + b'x + c
% A = H'H; b = - H'g; c = g'g; grad(F) = H'Hx - H'g = -r

% load data
load bme593_project_data.mat
figure;imshow(imgref,[]);
% figure(2);imshow(sinogram,[]);

% initialization 
nx = 256; ny = nx ; npixel = nx*ny;
nviews = size(sinogram,1); nrays = size(sinogram,2)/2;
sample = 2*(1:nrays);
x = zeros(ny,nx); 
g = sinogram(:,sample); b = backward(g,nx);
rec = forward(x, nviews, nrays); r = b - backward(rec,nx);
cost = norm(r)^2;
d = r;

niter = 100; ii=1;
epsilon = 1e-6; mse = zeros(niter,1);
recon = zeros(ny,nx,niter);

while ii<niter+1 && cost > epsilon
    if (mod(ii,10) == 0)
        disp(['Iteration:' num2str(ii)]);
        disp(['Cost:' num2str(cost)]);
    end
    q = forward(d, nviews, nrays); q = backward(q, nx);
    deltax = (r(:)'*r(:))/(d(:)'*q(:));
    x = x + deltax*d;
    r = r - deltax*q;
    cost0 = cost;
    cost = norm(r)^2;
    beta = cost/cost0;
    d = r + beta*d;
    x (x<0) = 0;
    ii = ii+1;
    mse(ii) = mean((x(:)-imgref(:)).^2);
    recon(:,:,ii) = x;
end

figure;imshow(x,[]);
figure;plot(mse);