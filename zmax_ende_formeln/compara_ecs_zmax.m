clear all;
clc;
Y1=[];
Y2=[];
Y3=[];
Y4=[];
Y5=[];
Y6=[];
OJO=[];
g=9.81;         %Erdbeschleunigungskoeffizient
delta=1.65;     %relative Dichte: (rosolido-roagua)/roagua
nu=0.000001;    %m2/s
A=load('datos.txt');

for cont1=1:size(A,1)
   
   b=A(cont1,2);         	%Pfeile Durchmesser m
   H=A(cont1,3);         	%Wassertiefe m
   V=A(cont1,4);          	%mittlere Geschwindigkeit m/s
   d50=A(cont1,5)/1000;   	%Korngröße m
   sigma=A(cont1,6); 		%desviacion estandar para Melville
   
   %cálculos intermedios
   D=d50*(g*delta/(nu)^2)^(1/3);
   w=11/d50*(nu)*(sqrt(1+0.01*D^3)-1);
   Vcr=1.4*(2*sqrt(g*delta*d50)+10.5*nu/(d50));
   OJO=[OJO;Vcr];
   V_Vcr=V/Vcr;
   Fr=V/((g*H)^0.5);
   b_d50=b/d50;
   H_b=H/b;
   
   %Breusers
   if V_Vcr>1.0
      aux=1;
   end
   if V_Vcr<1.0
      aux1=2*V_Vcr-1;
   end
   if V_Vcr<0.5
      aux1=0;
   end
   y1=2*b*tanh(H_b)*aux1;
   if d50==0.999
      y4=-100;
   end
   if y1==0;y1=-100;end
Y1=[Y1;y1];
   
   %CSU
   y2=2*b*(H_b)^0.35*Fr^0.43;
    if y2==0;y2=-100;end
    Y2=[Y2;y2];
  
   
   %Johnsons
   y3=2.01*b*(H_b)^0.02*Fr^0.21*sigma^(-0.24);
   Y3=[Y3;y3];
   
   %Zanke
   if V_Vcr>=1.0
      for cont=0.5*b:0.0001:2.5*b
         omega=0.2234*(cont/b)^6-1.9879*(cont/b)^5+6.3328*(cont/b)^4-8.3095*(cont/b)^3+2.5538*(cont/b)^2+2.0397*(cont/b)+2.0002;
         if (cont>=b*(omega/(V_Vcr^(-1)+V_Vcr^(-2)-V_Vcr^(-3))^0.5-1)) | (cont<=1.02*b*(omega/(V_Vcr^(-1)+V_Vcr^(-2)-V_Vcr^(-3))^0.5-1)) ==1;
            y4=cont;
            break;
         end
      end
   end
   
   if V_Vcr<1.0
      for cont=0.5*b:0.0001:2.5*b
         omega=0.2234*(cont/b)^6-1.9879*(cont/b)^5+6.3328*(cont/b)^4-8.3095*(cont/b)^3+2.5538*(cont/b)^2+2.0397*(cont/b)+2.0002;
         if (cont>=b*(omega*V_Vcr-1)) | (cont<=1.02*b*(omega*V_Vcr-1)) ==1;
            y4=cont;
            break;
         end
      end
   end
   if d50==0.999
      y4=-100;
   end
   Y4=[Y4;y4];
   
   %Jain and Fischer (1981)
   y6=1.86*b*(H_b)^0.5*(Fr-Vcr/((g*H)^0.5))^0.25;
   if ((Fr-Vcr/((g*H)^0.5))<0.15 | (Fr-Vcr/((g*H)^0.5))>1.2)==1 %condicion por Fr
      y6=-100;
   end
   if H_b<1 | H_b>2.1 %condicion por H/b
      y6=-100;
   end
   Y6=[Y6;y6];
   
   %Melville and Sutherland
   m=1.28;
   dmax=sigma^m*d50;
   d50a=dmax/1.8;
   ucr=0.0115+0.0125*d50^1.4;
   if d50>1
      ucr=0.0305*d50^0.5-0.0065*d50^(-1);
   end
   Vcr=ucr*5.75*log(5.53*H/d50);
   
   ucra=0.0115+0.0125*d50a^1.4;
   if d50a>1
      ucra=0.0305*d50a^0.5-0.0065*d50a^(-1);
   end
   Uca=ucra*5.75*log(5.53*H/d50a);
   Ua=0.8*Uca;
   
   if (V-(Ua-Vcr))/Vcr<1
      ki=2.4*abs((V-(Ua-Vcr))/Vcr);
   end
   if (V-(Ua-Vcr))/Vcr>=1
      ki=2.4;
   end
   
   kd=0.57*log(2.24*b_d50);
   if b_d50>25
      kd=1;
   end
   if sigma<=1.3
      kd=0.57*log(2.24*b/d50a);
      if b/d50a>25
         kd=1;
      end
   end
   
   ky=0.78*(H_b)^0.255;
   if H_b>2.6
      ky=1;
   end
   y5=b*ki*kd*ky;
   if d50==0.999
      y4=-100;
   end
   if y5==0;y5=-100;end
Y5=[Y5;y5];
end


aux2=[Y1,Y2,Y3,Y4,Y5,Y6,A(:,1)];
aux3=max(max(aux2));
%Graphische Darstellung der Kurven
% figure(1);
% plot(A(:,1),Y1,'b.',A(:,1),Y2,'rv',A(:,1),Y3,'r+',A(:,1),Y4,'k*',A(:,1),Y5,'bx');
% xlabel('observed maximum scour depth (m)');
% ylabel('estimated maximum scour depth (m)');
% legend('Breusers et al (1977)','CSU equation (1987)','Johnsons (1992)','Zanke (1982)','Melville and Sutherland (1988)');
% hold on;
% plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
% axis([0 aux3 0 aux3]);
% grid on;

figure(2);
plot(A(:,1),Y1,'b.','MarkerSize',15);
xlabel('socavación observada (m)','fontsize',24,'fontweight','b','color','k');
ylabel('socavación calculada(m)','fontsize',24,'fontweight','b','color','k');
legend('Breusers et al (1977)','Location','Best');
legend('boxoff');
%legend('fontsize',24,'fontweight','b','color','k');hold on;
hold on;
plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
axis([0 aux3 0 aux3]);
grid on;
set(gca,'linewidth',2,'fontsize', 24,'fontweight','b');hold on;




figure(3);
plot(A(:,1),Y2,'b.','MarkerSize',15);
xlabel('socavación observada (m)','fontsize',24,'fontweight','b','color','k');
ylabel('socavación calculada(m)','fontsize',24,'fontweight','b','color','k');
legend('Richardson (1987)','Location','Best');
legend('boxoff');
hold on;
plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
axis([0 aux3 0 aux3]);
grid on;
set(gca,'linewidth',2,'fontsize', 24,'fontweight','b');hold on;


% figure(4)
% plot(A(:,1),Y3,'b.');
% xlabel('observed maximum scour depth (m)');
% ylabel('estimated maximum scour depth (m)');
% legend('Johnsons (1992)');
% hold on;
% plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
% axis([0 aux3 0 aux3]);
% grid on;

% figure(5);
% plot(A(:,1),Y4,'b.');
% xlabel('socavación observada (m)');
% ylabel('socavación calculada(m)');
% legend('Zanke (1982)');
% hold on;
% plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
% axis([0 aux3 0 aux3]);
% grid on;


figure(6)
plot(A(:,1),Y5,'b.','MarkerSize',15);
xlabel('socavación observada (m)','fontsize',24,'fontweight','b','color','k');
ylabel('socavación calculada(m)','fontsize',24,'fontweight','b','color','k');
legend('Melville & Sutherland (1988)');
legend('boxoff');
hold on;
plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
axis([0 aux3 0 aux3]);
grid on;
set(gca,'linewidth',2,'fontsize', 24,'fontweight','b');hold on;


% figure(7)
% plot(A(:,1),Y6,'b.');
% xlabel('observed maximum scour depth (m)');
% ylabel('estimated maximum scour depth (m)');
% legend('Jain and Fischer (1980)');
% hold on;
% plot(0:0.01:max(A(:,1))*5,0:0.01:max(A(:,1))*5,'k-');
% axis([0 aux3 0 aux3]);
% grid on;

