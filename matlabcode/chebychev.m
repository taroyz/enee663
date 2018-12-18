clc,clear;
n = 50;
m = 60*n;
w = linspace(0,pi,m)';

%OBTAINED FROM MLP
r=[ 1.8163, 1.2618, 0.9975, 0.8735, 0.7716, 0.7010, 0.6376, 0.5884, 0.5425,...
         0.5052, 0.4699, 0.4391, 0.4107, 0.3850, 0.3608, 0.3392, 0.3194, 0.2996,...
         0.2823, 0.2652, 0.2494, 0.2350, 0.2216, 0.2072, 0.1964, 0.1835, 0.1735,...
         0.1618, 0.1521, 0.1433, 0.1328, 0.1249, 0.1171, 0.1094, 0.1018, 0.0945,...
         0.0881, 0.0817, 0.0753, 0.0699, 0.0647, 0.0600, 0.0545, 0.0496, 0.0455,...
         0.0413, 0.0375, 0.0340, 0.0297, 0.0183]';
      
h = spectral_fact(r);

H = [exp(-j*kron(w,[0:n-1]))]*h;

% USING CVX EAMPLE CODE
figure()
% FIR impulse response
plot([0:n-1],h','o',[0:n-1],h','b:')
xlabel('t'), ylabel('h(t)')


figure()
% magnitude
subplot(2,1,1)
loglog(w,abs(H))
xlabel('w')
ylabel('mag H(w) in dB')
axis([0.01*pi pi 0.1 10])
% phase
subplot(2,1,2)
plot(w,angle(H))
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')
