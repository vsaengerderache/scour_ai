function[res_breusers]=breusers(V_Vcr, b, H_b, d50)
%si no es posible ocupar la formula, el resultado es -100
%OK, 21.06.2004
%Breusers
if V_Vcr>1.0
   aux1=1;
end
if V_Vcr<=1.0
   aux1=2*V_Vcr-1;
end
if V_Vcr<=0.5
   aux1=0;
end
res_breusers=2*b*tanh(H_b)*aux1;


if d50==0.999 %verifica aplicabilidad
   res_breusers=-100;
end


