function[res_yanmaz_ciceckdag]=yanmaz_ciceckdag(b, H, Fr);
%si no es posible ocupar la formula, el resultado es -100
%Yanmaz & Ciceckdag 2001

res_yanmaz_ciceckdag=b*(-0.1331*(b/H+Fr)^2+0.9249*(b/H+Fr)+0.1371);

%verifica aplicabilidad
if (b/H+Fr)>3.30 | 0.69>(b/H+Fr)
   res_yanmaz_ciceckdag=-100;
end




