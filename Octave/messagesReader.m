clear
clc
pkg load signal

% Frecuencia de la señal de información.
f1  = 20;
f2  = 60;
% Frecuencia de la portadora o carrier
fc  = 5e3;
% Frecuencia de muestreo
fs  = fc * 20;
fs2 = fs / 2;

filename1 = "message1.txt";
filename2 = "message2.txt";
f1 = fopen(filename1, "r");
f2 = fopen(filename2, "r");

M1 = [];
M2 = [];

M1 = [M1 fscanf(f1, "%f")];
M2 = [M2 fscanf(f2, "%f")];
    
fclose(f1);
fclose(f2);

figure(1)
subplot(3,1,1)
plot(M1,";Mensaje 1;");
axis([0 2*fs/f1])
subplot(3,1,2)
plot(M2,";Mensaje 2;");
subplot(3,1,3)
plot(M2,";Mensaje 2 zoom;");
axis([0 2*fs/f2])