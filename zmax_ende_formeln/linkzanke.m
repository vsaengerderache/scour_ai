function[res_linkzanke]=linkzanke(V_Vcr, b, d50,V,H)
%d50 en m.
%si no es posible ocupar la formula, el resultado es -100
%oscar es una constante pa corregirle la fomrula al mr. con 2.5 queda atr.
oscar=2.5;
%OK, 21.06.2004
%Zanke

if V_Vcr>=1.0
   for cont=0.3*b:0.00000001:2.5*b 
      omega=0.2234*(cont/b)^6-1.9879*(cont/b)^5+6.3328*(cont/b)^4-8.3095*(cont/b)^3+...
         2.5538*(cont/b)^2+2.0397*(cont/b)+2.0002; %polinomio que ajusta datos de ettema
      omega=0.42*omega*V^(-0.5)*(H^(1.6-2));
      if (cont>=0.99*b*(omega/(V_Vcr^(-1)+V_Vcr^(-2)-V_Vcr^(-3))^0.5-1)) |...
            (cont<=1.01*b*(omega/(V_Vcr^(-1)+V_Vcr^(-2)-V_Vcr^(-3))^0.5-1)) ==1;
         res_linkzanke=oscar*cont;
         break;
      end
   end
end

if V_Vcr<1.0
   for cont=0.3*b:0.0000001:2.5*b
      omega=0.2234*(cont/b)^6-1.9879*(cont/b)^5+6.3328*(cont/b)^4-8.3095*(cont/b)^3+...
         2.5538*(cont/b)^2+2.0397*(cont/b)+2.0002; %polinomio que ajusta datos de ettema
      omega=0.42*omega*V^(-0.5)*(H^(1.6-2));
      if (cont>=b*(omega*V_Vcr-1)) | (cont<=1.02*b*(omega*V_Vcr-1)) ==1;
         res_linkzanke=oscar*cont;
         break;
      end
   end
end

if res_linkzanke<0; res_linkzanke=-100;end

if V_Vcr>8.8 | b==999==1 | d50==0.999 %verifica aplicabilidad
   res_linkzanke=-100;
   break;
end

