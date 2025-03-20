%esta función calcula el coeficiente de correlación el error porcentual y la cantidad de datos
%usados para calcular los indicadores (elimina los =-100). 

%observado es el vector con los datos observados
%estimado es el vector con los datos estimados. Los valores estimados no válidos
%son iguales a -100.

function[indicadores]= indicadores(estimado,observado);
aux2=0;
suma_errores=0;
for aux1=1:size(estimado)
   if estimado(aux1)~=-100
      aux2=aux2+1;
      calculado(aux2)=estimado(aux1);
      medido(aux2)=observado(aux1);
      %suma_errores=abs(medido(aux2)-calculado(aux2))/medido(aux2)*100+suma_errores;
   end
end

epp=100*sum(abs(medido-calculado)./medido)/size(medido,2);  %Error porcentual promedio
epmax=100*max(abs(medido-calculado)./medido);					%Error porcentual máximo
epmin=100*min(abs(medido-calculado)./medido);					%Error porcentual minimo
Faktorpro=sum(medido./calculado)/size(medido,2);
Faktormax=max(medido./calculado);

indicadores=[min(min(corrcoef(calculado,medido))) Faktorpro Faktormax epp epmax epmin size(calculado,2)]; %entrega: [coef_corr error_porcentual No_datos]
