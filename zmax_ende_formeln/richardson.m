function[res_richardson]=richardson(b, H_b, Fr);
%si no es posible ocupar la formula, el resultado es -100
%Richardson 1987, CSU-equation

res_richardson=2*b*(H_b)^0.35*Fr^0.43;

%verifica aplicabilidad
     
%no tiene restricciones