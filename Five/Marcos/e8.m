1;

fid = load("pb100.txt");
fid = fid';

fm = 1000;
Tm = 1/fm;
t =0:Tm:1-Tm;


f1 = 50;
f2 = 80;
f3 = 140;
f4 = 130;
f5 = 150;
f = 0; % fase

S1 = sin(2*pi*f1*t + f);
S2 = sin(2*pi*f2*t + f);
S3 = sin(2*pi*f3*t + f);
S4 = sin(2*pi*f4*t + f);
S5 = sin(2*pi*f5*t + f);

x = S1 + S2 + S3 + S4 + S5;

%% CONVOLUCIONAMOS
sf = conv(x,fid);
X = fft(x);
SF = fft(sf(1:length(x)));

%% DECONVOLUCIONAMOS
[x1 r] = deconv(sf(1:80),fid(1:64));
stem(abs(fft(r)));



	