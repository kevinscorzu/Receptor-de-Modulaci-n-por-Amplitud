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
sin = (sinetone(fc,fs,1,1).*2.5).+2.5;
cos = (cos(asin(sinetone(fc,fs,1,1))).*2.5).+2.5;

filenameSin = "sintest.txt";
filenameCos = "costest.txt";

fsin = fopen(filenameSin, "w");
fcos = fopen(filenameCos, "w");

nl= "\r\n";
for i = 1:fs
    fputs(fsin, num2str(sin(i)));
    fputs(fsin, nl);
    
    fputs(fcos, num2str(cos(i)));
    fputs(fcos, nl);
endfor
fclose(fsin);
fclose(fcos);