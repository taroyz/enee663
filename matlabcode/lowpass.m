clc,clear
n = 20;
wpass = 0.12*pi;   % end of the passband
wstop = 0.24*pi;   % start of the stopband
% delta = 1;         % maximum passband ripple in dB (+/- around 0 dB)
alpha = 1.1;
delta = 1.1;

m = 15*n;
w = linspace(0,pi,m)'; % omega
space = w(2)-w(1);

a = [ones(m,1) 2*cos(kron(w,[1:n-1]))];

n1 = floor(wpass/space)+1;
n2 = m - floor(wstop/space);
A = zeros(n1+n1+n2+m, n+1);
b = zeros(n1+n1+n2+m,1);

A(1:n1,1:n) = a(1:n1,:);
for i = 1: n1
    b(i) = alpha^2;
    A(i,n+1) = 0;
end

A(n1+1:2*n1,1:n) = -a(1:n1,:);
for i = n1+1:2*n1
    b(i) = -1/alpha^2;
    A(i,n+1) = 0;
end

A(2*n1+1:2*n1+n2,1:n) = a(m-n2+1:m,:);
for i = 2*n1+1:2*n1+n2
    b(i) = 0;
    A(i,n+1) = -1;
end

A(2*n1+n2+1:m+2*n1+n2,1:n) = -a(1:m,:);
for i = 2*n1+n2+1:m+2*n1+n2
    b(i) = 0;
    A(i,n+1) = 0;
end

c = zeros(1,n+1);
c(end) = 1;

Aeq = zeros(n1+n1+n2+m, n+1);
beq = zeros(n1+n1+n2+m,1);
lb = ones(n+1,1)*-1000;
ub = ones(n+1,1)*1000;
options = optimoptions('linprog','Algorithm','interior-point');
r1 = linprog(c,A,b,Aeq,beq,lb,ub,options);
r = r1(1:end-1);
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
plot(w,20*log10(abs(H)))
xlabel('w')
ylabel('mag H(w) in dB')
axis([0 pi -50 5])
% phase
subplot(2,1,2)
plot(w,angle(H))
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')


% results obtained using MLP
r = [0.1499,  0.1436,  0.1260,  0.0999,  0.0693,  0.0386,  0.0116, -0.0089,...
         -0.0219, -0.0276, -0.0274, -0.0234, -0.0177, -0.0118, -0.0069, -0.0034,...
         -0.0014, -0.0003,  0.0000,  0.0001]';
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
plot(w,20*log10(abs(H)))
xlabel('w')
ylabel('mag H(w) in dB')
axis([0 pi -50 5])
% phase
subplot(2,1,2)
plot(w,angle(H))
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')
