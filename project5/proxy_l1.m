function x = proxy_l1(v,lambda)
% proxy_l1: the proximal operator of the l1 norm

x = max(0, v - lambda) - max(0, -v -lambda);
end