
n = 20;

wpass = 0.12*pi;   % end of the passband
wstop = 0.24*pi;   % start of the stopband
% delta = 1;         % maximum passband ripple in dB (+/- around 0 dB)
alpha = 1.1;
delta = 1.1;

m = 15*n;
w = linspace(0,pi,m)'; % omega
space = w(2)-w(1);

% A is the matrix used to compute the power spectrum
% A(w,:) = [1 2*cos(w) 2*cos(2*w) ... 2*cos((n-1)*w)]
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
options = optimoptions('linprog','Algorithm','dual-simplex');
r1 = linprog(c,A,b,Aeq,beq,lb,ub,options);
r = r1(1:end-1);
% h = spectral_fact(r);
% 
% H = [exp(-j*kron(w,[0:n-1]))]*h;
% 
% figure()
% % FIR impulse response
% plot([0:n-1],h','o',[0:n-1],h','b:')
% xlabel('t'), ylabel('h(t)')
% 
% 
% figure()
% % magnitude
% subplot(2,1,1)
% plot(w,20*log10(abs(H)))
% xlabel('w')
% ylabel('mag H(w) in dB')
% axis([0 pi -50 5])
% % phase
% subplot(2,1,2)
% plot(w,angle(H))
% axis([0,pi,-pi,pi])
% xlabel('w'), ylabel('phase H(w)')


r=[ 0.1475,  0.1414,  0.1244,  0.0991,  0.0694,  0.0394,  0.0130, -0.0073,...
         -0.0203, -0.0263, -0.0265, -0.0229, -0.0175, -0.0118, -0.0070, -0.0036,...
         -0.0015, -0.0004, -0.0000,  0.0001]';
h = spectral_fact(r);

H = [exp(-j*kron(w,[0:n-1]))]*h;

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
