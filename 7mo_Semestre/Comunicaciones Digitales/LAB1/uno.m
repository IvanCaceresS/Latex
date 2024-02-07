clc;
close;
clear;
% Definir los parámetros de la señal
A = 1; % amplitud
fc = 1e3; % frecuencia en Hz
fs = 1e5; % frecuencia de muestreo en Hz (configurable)

% Generar el vector de tiempo
t = 0:1/fs:1/fc;

% Generar la señal sinusoidal
x = A*sin(2*pi*fc*t);

% Graficar la señal generada
plot(t,x);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal sinusoidal de 1000 Hz');
