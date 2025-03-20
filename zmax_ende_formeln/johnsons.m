function[res_johnsons]=johnsons(b, H_b, Fr, sigma);
%si no es posible ocupar la formula, el resultado es -100
%Johnsons 1992

res_johnsons=2.01*b*(H_b)^0.02*Fr^0.21*sigma^(-0.24);

%verifica aplicabilidad
%no tiene restricciones