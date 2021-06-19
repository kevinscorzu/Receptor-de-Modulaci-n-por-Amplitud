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

% Modula la señal con seno (señal 1) y coseno (señal 2) de la portadora
data_mod = sinetone(f1,fs,1,1).*sinetone(fc,fs,1,1) + ...
            sinetone(f2,fs,1,1).*cos(asin(sinetone(fc,fs,1,1)));

filename = "data_mod.txt";
f = fopen(filename, "w");
nl= "\r\n";
for i = 1:fs
    fputs(f, num2str(data_mod(i)));
    fputs(f, nl);
endfor
fclose(f);