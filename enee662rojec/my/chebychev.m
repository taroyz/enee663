clc,clear;
n = 50;

wpass = 0.12*pi;   % end of the passband
wstop = 0.24*pi;   % start of the stopband
% delta = 1;         % maximum passband ripple in dB (+/- around 0 dB)
alpha = 1.1;
delta = 1.1;

m = 20*n;
w = linspace(0,pi,m)'; % omega
w = linspace(0,pi,m)';
r=[ 1.3484,  0.7739,  0.4953,  0.3666,  0.2627,  0.1866,  0.1283,  0.0866,...
          0.0436,  0.0073, -0.0183, -0.0364, -0.0545, -0.0705, -0.0888, -0.1005,...
         -0.1060, -0.1119, -0.1155, -0.1229, -0.1217, -0.1242, -0.1246, -0.1250,...
         -0.1263, -0.1227, -0.1170, -0.1120, -0.1104, -0.1077, -0.1048, -0.0977,...
         -0.0920, -0.0839, -0.0802, -0.0735, -0.0661, -0.0612, -0.0577, -0.0502,...
         -0.0453, -0.0385, -0.0309, -0.0293, -0.0257, -0.0190, -0.0187, -0.0150,...
         -0.0095, -0.0087]';
      
h = spectral_fact(r);

H = [exp(-j*kron(w,[0:n-1]))]*h;

figure()
% FIR impulse response
plot([0:n-1],h','o',[0:n-1],h','b:')
xlabel('t'), ylabel('h(t)')


figure()
% magnitude
subplot(2,1,1)
plot(w,abs(H))
xlabel('w')
ylabel('mag H(w) in dB')
axis([0.01*pi pi 0.1 10])
% phase
subplot(2,1,2)
plot(w,angle(H))
axis([0,pi,-pi,pi])
xlabel('w'), ylabel('phase H(w)')
