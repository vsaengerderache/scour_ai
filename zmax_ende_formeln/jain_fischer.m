function[res_jain_fischer]=jain_fischer(b, H, H_b, Fr, Vcr, g, d50);
%si no es posible ocupar la formula, el resultado es -100
%Jain and Fischer (1981)

res_jain_fischer=1.86*b*(H_b)^0.5*(Fr-Vcr/((g*H)^0.5))^0.25;

%verifica aplicabilidad
if ((Fr-Vcr/((g*H)^0.5))<0.15 | (Fr-Vcr/((g*H)^0.5))>1.2)==1 %condicion por Fr
   res_jain_fischer=-100;
end
if H_b<1 | H_b>2.1 %condicion por H/b
   res_jain_fischer=-100;
end
if d50==0.999
   res_jain_fischer=-100;
end
