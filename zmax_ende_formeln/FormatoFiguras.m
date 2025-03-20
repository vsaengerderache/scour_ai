%% Molde para cambiar el formato de las figuras, incluyendo tama�o, tipo de archivo y resoluci�n DPI
units='centimeters';      % Unidades requeridas
width = 12;               % Ancho 
height = 8;               % Alto 
alw = 0.75;               % Grosor los de los ejes
fsz = 11;                 % Tama�o de letra
lw = 1.5;                 % Ancho de linea
msz = 8;                  % Tama�o de los marcadores
filename = 'untitled';  % Nombre del archivo 
fileformat = '-dtiff';    % Formato del archivo
resolution = '-r600';     % Resoluci�n en dpi (o ppi)

set(gcf, 'Position', [50 50 width*100/2.54, height*100/2.54]); %<- Formatea
% el tama�o de la figura en pantalla
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Seteo del tama�o deletra y
% grosor de l�nea de los ejes

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits',units);
papersize = get(gcf,'PaperSize');
left=(papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
FigureSize = [left, bottom, width, height];
set(gcf,'PaperPosition', FigureSize);

% Guardar el archivo con el nombre, formato y resoluci�n requerida.
print(filename,fileformat,resolution)

