function f = lsq(x,H,g)
f = norm(g(:)-H*x(:))^2;
end