%this porgramm calculates the maximal scour of depth in front of a cylindrical bridge pier by different empirical formulas.
clear all;
clc;

%Variable declaration: these are the estimated scour depths by the different formulas. 
BREUSERS=[];
JAIN_FISCHER=[];
ZANKE=[];
LINKZANKE=[];
RICHARDSON=[];
MELVILLE_SUTHERLAND=[];
JOHNSONS=[];
YANMAZ_CICECKDAG=[];

%Datos
g=9.81;         %Erdbeschleunigungskoeffizient
%delta=1.65;     %relative Dichte: (rosolido-roagua)/roagua
nu=0.000001;    %m2/s
A=load('c:\matlabr11\work\kolkformeln\datos\datos_kolkvergleich.txt'); %Matrix containing the data: their columns are ...
%A=load('F:\99_varios\Darmstadt2004\Kolke\datos\datos_zobs.txt'); %Matrix containing the data: their columns are ...
% 1:measured scour depth 
% 2:pier width 
% 3:wather depth 
% 4:average flow velocity 
% 5:sediment particle diameter, d50 
% 6:sediment unifomrity, d85/d15 or d90/d10. 
% no data values are 999.


%Aquí parte la weá
for cont1=1:size(A,1) %para cada dato calcula la erosion con cada formula
   %extrae los datos
   b=A(cont1,2);         	%Pfeile Durchmesser m
   H=A(cont1,3);         	%Wassertiefe m
   V=A(cont1,4);          	%mittlere Geschwindigkeit m/s
   d50=A(cont1,5)/1000;   	%Korngröße m
   delta=A(cont1,6);			%relative dichte: ros-1
   sigma=A(cont1,7); 		%desviacion estandar para Melville
   
   %cálculos intermedios
   D=d50*(g*delta/(nu)^2)^(1/3);
   w=11/d50*(nu)*(sqrt(1+0.01*D^3)-1);
   Vcr=1.4*(2*sqrt(g*delta*d50)+10.5*nu/(d50));
   V_Vcr=V/Vcr;
   Fr=V/((g*H)^0.5);
   b_d50=b/d50;
   H_b=H/b;
   
   %calculo de la profundidad con las diferentes fórmulas empíricas. Cuando una formula no es aplicable, su resultado es -100
   %BREUSERS=[BREUSERS; breusers(V_Vcr, b, H_b, d50)];
   %JAIN_FISCHER=[JAIN_FISCHER; jain_fischer(b, H, H_b, Fr, Vcr, g, d50)];
   ZANKE=[ZANKE; zanke(V_Vcr,b,d50)];
   LINKZANKE=[LINKZANKE; linkzanke(V_Vcr,b,d50,V,H)];
   %RICHARDSON=[RICHARDSON; richardson(b, H_b, Fr)];
   %MELVILLE_SUTHERLAND=[MELVILLE_SUTHERLAND; melville_sutherland(b, V, H, b_d50, H_b, d50, sigma, Vcr)];
   %JOHNSONS=[JOHNSONS; johnsons(b, H_b, Fr, sigma)];
   %YANMAZ_CICECKDAG=[YANMAZ_CICECKDAG; yanmaz_ciceckdag(b, H, Fr)];
end

%estadísticas

%indicadores_estadisticos=[indicadores(BREUSERS,A(:,1)); indicadores(JAIN_FISCHER,A(:,1));...
%      indicadores(ZANKE,A(:,1)); indicadores(RICHARDSON,A(:,1));...
%      indicadores(MELVILLE_SUTHERLAND,A(:,1)); indicadores(JOHNSONS,A(:,1));...
%      indicadores(YANMAZ_CICECKDAG,A(:,1))] %columna1: R2 columna2: cant. datos usados. 

%Graphische Darstellung der Kurven
aux3=max([max(BREUSERS),max(JAIN_FISCHER),max(ZANKE),max(LINKZANKE),max(RICHARDSON),...
      max(MELVILLE_SUTHERLAND),max(JOHNSONS),max(YANMAZ_CICECKDAG),...
      max(A(:,1))]);
aux3=0.7;



figure(3); %%%Zanke 1982
plot(A(:,1),ZANKE,'k.');
xlabel('gemessene Kolktiefe (m)');
ylabel('berechnete Kolktiefe (m)');
%xlabel('observed maximum scour depth (m)');
%ylabel('estimated maximum scour depth (m)');
legend('Zanke (1982)');
hold on;
plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
axis([0 aux3 0 aux3]);
grid on;

figure(8); %%%Zanke 1982
plot(A(:,1),LINKZANKE,'k.');
xlabel('gemessene Kolktiefe (m)');
ylabel('berechnete Kolktiefe (m)');
%xlabel('observed maximum scour depth (m)');
%ylabel('estimated maximum scour depth (m)');
legend('Zanke modifiziert');
hold on;
plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
axis([0 aux3 0 aux3]);
grid on;


ploteo=0;
if ploteo==1
   figure(1); %%%Breusers et al. 1977
   plot(A(:,1),BREUSERS,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Breusers et al (1977)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-'); %grafica la linea a 45°
   axis([0 aux3 0 aux3]);
   grid on;
   
   figure(2); %%%Jain & Fischer 1980
   plot(A(:,1),JAIN_FISCHER,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Jain & Fischer (1980)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
   axis([0 aux3 0 aux3]);
   grid on;
   
   figure(4) %%%Richardson 1987
   plot(A(:,1),RICHARDSON,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Richardson (1987)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
   axis([0 aux3 0 aux3]);
   grid on;
   
   figure(5)  %%%%%Melville & Sutherland 1988
   plot(A(:,1),MELVILLE_SUTHERLAND,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Melville & Sutherland (1988)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
   axis([0 aux3 0 aux3]);
   grid on;
   
   figure(6);  %%%%% Johnsons 1992
   plot(A(:,1),JOHNSONS,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Johnsons (1992)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
   axis([0 aux3 0 aux3]);
   grid on;
   
   figure(7);  %%%%% Yanmaz & Ciceckdag 2001
   plot(A(:,1),YANMAZ_CICECKDAG,'k.');
   xlabel('gemessene Kolktiefe (m)');
   ylabel('berechnete Kolktiefe (m)');
   %xlabel('observed maximum scour depth (m)');
   %ylabel('estimated maximum scour depth (m)');
   legend('Yanmaz & Ciceckdag (2001)');
   hold on;
   plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
   axis([0 aux3 0 aux3]);
   grid on;
   
   
   p1
end

