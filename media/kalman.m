clear
clf
N=1000;
sigu = 0.1;
sigw = 0.5;

% synthesize
y(1) = 0.1*randn;
a = 0.99;
for n=2:N
    y(n) = a*y(n-1) + 0.1*randn;
end
x = y + 0.5*randn(size(y));

figure(1)
subplot(2,1,2)
plot(x)
title('Observations x')
ax = axis;
subplot(2,1,1)
plot(y)
title('Signal y')
axis(ax)

% Kalman filter
p(1) = sigu^2;
q(1) = a^2*p(1) + sigu^2;
g(1) = q(1) + sigw^2;
k(1) = q(1)/g(1);
ey(1) = 0;

for n=2:N
    
    q(n) = a^2*p(n-1) + sigu^2;
    g(n) = q(n) + sigw^2;
    p(n) = q(n) - q(n)^2/g(n);
    k(n) = q(n)/g(n);
    py(n) = a*ey(n-1);
    ey(n) = py(n) + k(n)*(x(n)-py(n-1));
    
end


figure(2)

subplot(3,1,2)
plot(x)
title('Observations x')
axis(ax)
subplot(3,1,1)
plot(y)
title('Signal y')
axis(ax)
subplot(3,1,3)
plot(ey)
title('Filter Output')
axis(ax)