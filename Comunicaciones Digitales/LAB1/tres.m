clc;
close;
clear;
% Definir los parámetros de la señal
A = 1; % amplitud
fc = 1e3; % frecuencia en Hz
fs = 1e5; % frecuencia de muestreo en Hz (configurable)
d = 50; % ciclo de trabajo (configurable)
ts= 1/fc;
cant_muestras=ts/(1/fs);
tau=cant_muestras*d*ts;

% Generar el vector de tiempo
t = 0:1/fs:1/fc;

% Generar la señal sinusoidal
x = A*sin(2*pi*fc*t);

% Graficar la señal generada
subplot(3,1,1); % Primera sub-figura
plot(t,x);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal sinusoidal de 1000 Hz');

% Tren de pulsos cuadrados con valores 0 y 1
pulso = (square(2*pi*10000*t, d)+1)/2; 
subplot(3,1,2); % Segunda sub-figura
plot(t, pulso); % Graficar el tren de pulsos
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Tren de pulsos');

y = zeros(size(x));     % Inicializar la señal resultante
temp2 = zeros(size(x));
temp=0;
for i = 2:length(x)
    if pulso(i) == 1 && pulso(i-1) == 0
        y(i) = pulso(i) * x(i);
    elseif pulso(i) == 1 && pulso(i-1) == 1
        y(i) = y(i-1);
    else
        y(i) = 0;
    end
end


subplot(3,1,3)
plot(t,y)
title('Señal resultante y')



