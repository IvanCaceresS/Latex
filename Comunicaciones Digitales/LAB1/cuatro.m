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

% Tren de pulsos cuadrados con valores 0 y 1
pulso = (square(2*pi*10000*t, d)+1)/2; 

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

y1 = zeros(size(x));     % Inicializar la señal resultante
for i = 1:length(x)
    y1(i) = x(i) * pulso(i);     % Multiplicar los valores correspondientes
end

plot(t, x, 'red', t, y1, 'blue', t, y, 'black')
h = legend({'SINUSOIDE', 'PAM muestreo natural', 'PAM muestreo instantáneo'});
set(h, 'TextColor', [1 0 0; 0 0 1; 0 0 0]);