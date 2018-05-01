% Karolina Firszt - 22/11/2017 -
% Avec l'aide de Clément Dupont :)

% PROBLEME 6 JOIES DU LOTO..
function [U Ubouncing] = bouncingBall(dt,Ustart,g,m,k)

U=Ustart;
x=Ustart(1);
y=Ustart(2);

i=1;
while(sqrt((x^2)+(y^2))<=1)
    K1 = f(U(i,:));
    K2 = f(U(i,:) + dt*K1);
    U(i+1,:) = U(i,:) + dt*(K1+K2)/2;
    U(i+1,end) = U(i,end)+dt;
    x=U(i+1,1);
    y=U(i+1,2);
    i=i+1;
       
end

 x = (U(i,2) - U(i-1,2))/(U(i,1) - U(i-1,1));
 y = U(i-1,2) - (U(i,2) - U(i-1,2))/(U(i,1) - U(i-1,1)) * U(i-1,1);
 
 delta = sqrt((2*x*y)^2 - 4*(x^2+1)*(y^2-1));
 
 t = (-(2*x*y) + delta)/(2*(x^2+1));
 s = (-(2*x*y) - delta)/(2*(x^2+1));
 
 if ( abs(U(i,1) - t) <= abs(U(i,1) - s ))
    U(i,1) = t;
 else
    U(i,1) = s;
 end 
 
   if (U(i-1,2) >= 0)
   
   U(i,2) = sqrt(1-(U(i,1))^2);
   
   else
   
   U(i,2)= -sqrt(1-(U(i,1))^2);
   
   end

    function [vr1 vr2] = newDirection(x,y,v1,v2)
        a = atan2(y,x);
        if a < 0
            a = a + 2*pi;
        end
        b = atan2(v2,v1);
        if b < 0
            b = b + 2*pi;
        end
        c = 2*(a-b);
        rot = [cos(c) -sin(c); sin(c) cos(c)];
        vr1 = -rot*[v1;v2];
        vr2 = -rot'*[vr1(1); -vr1(2)];
    end

 function unext = f(u)
        unext = u;
        unext(1) = u(3);
        unext(2) = u(4);
        unext(3) = -k*u(3)/m;
        unext(4) = -(m*g + k*u(4))/m; 
 end

vr = newDirection(U(end,1),U(end,2),U(end,3),U(end,4));
Ubouncing = [ U(end,1) U(end,2) vr(1) vr(2) U(end,5)+dt ];

end