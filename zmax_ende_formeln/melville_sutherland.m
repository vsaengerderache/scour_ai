function[res_melville_sutherland]=melville_sutherland(b, V, H, b_d50, H_b, d50, sigma, Vcr);
%si no es posible ocupar la formula, el resultado es -100


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
res_melville_sutherland=b*ki*kd*ky;

%verifica aplicabilidad
if d50==0.999
   res_melville_sutherland=-100;
end
