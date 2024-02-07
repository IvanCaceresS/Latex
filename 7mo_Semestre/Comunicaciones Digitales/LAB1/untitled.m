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
% Primera sub-figura

% Tren de pulsos cuadrados con valores 0 y 1
pulso = (square(2*pi*10000*t, d)+1)/2; 
% subplot(3,1,2); % Segunda sub-figura
% plot(t, pulso); % Graficar el tren de pulsos
% xlabel('Tiempo (s)');
% ylabel('Amplitud');
% title('Tren de pulsos');

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

%Cuantización

N = 15; %Cantidad de bits. (configurable)
M = 2^N; %Palabras de codificación únicas y posibles.

vmax = max(y);
vmin = min(y);
dist = (vmax - vmin) / M;
partition = vmin:dist:vmax;
codebook = vmin-(dist/2):dist:vmax+(dist/2);
[index, quantized] = quantiz(y, partition, codebook);

% Codificación
code = de2bi(index, M);

%  Encoding Process
 figure
 code=de2bi(index,'left-msb');             % Cnvert the decimal to binary
 k=1;
for i=1:length(index)
    for j=1:N
        coded(k)=code(i,j);                  % convert code matrix to a coded row vector
        j=j+1;
        k=k+1;
    end
    i=i+1;
end
                                  % Display the encoded signal
                                  subplot(2,1,1)
 plot(t,x);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal original, PAM instantáneo y cuantizada');

 hold on
 plot(t,y,"red")
 stem(t,quantized,"black")
 h = legend({'Sinusoidal', 'PAM muestreo instantáneo', 'PAM cuantizada'});
 set(h,'TextColor',[1 0 0; 0 0 1; 0 0 0]);
 hold off

% Error de cuantización
error = y - quantized;