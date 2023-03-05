clear all, close all;
M=1.98847e+30;      %Nap tömege [kg]
m=5.9722e+24;       %Föld tömege [kg]
G=6.67404e-11;      %gravitációs állandó [m^3*kg^{-1}*s^{-2}]
r_nap=696342000;

R=149.6e+9;     %átlagos távolság a Naptól [m]

year=4;

T=365.256*24*60*60*year;     %keringési idõ [s]
dt=24*60*60;        %lépésköz; 1 nap [s]

x=R;
y=0;
v0=29.78e+3;
vx=0;
vy=v0;
t=0;        %keztettõl eltelt idõ;
E_pot=-G*M*m / (x^2+y^2);
E_kin=(vx^2+vy^2)*m / 2;
E_sum=E_pot+E_kin;

x_=[x];
y_=[y];
vx_=[vx];
vy_=[vy];
E_pot_=[E_pot];
E_kin_=[E_kin];
E_sum_=[E_sum];
t_=[t];

figure(1);

th=0:pi/60:2*pi;
xunit=r_nap*cos(th);
yunit=r_nap*sin(th);
hold on;
plot(xunit, yunit)

for i = 2:(T/dt)
        ax=-G*M*x /R^3;
        ay=-G*M*y /R^3;
        
        R=sqrt(x^2+y^2);

        v_x(1)=-dt*G*M*x / R^3;
        v_y(1)=-dt*G*M*y / R^3;
        x_k(1)=dt*vx;
        y_k(1)=dt*vy;
        
        v_x(2)=-dt*G*M*(x+x_k(1)/2) / R^3;
        v_y(2)=-dt*G*M*(y+y_k(1)/2) / R^3;
        x_k(2)=dt*(vx+v_x(1)/2);
        y_k(2)=dt*(vy+v_y(1)/2);
        
        v_x(3)=-dt*G*M*(x+x_k(2)/2) / R^3;
        v_y(3)=-dt*G*M*(y+y_k(2)/2) / R^3;
        x_k(3)=dt*(vx+v_x(2)/2);
        y_k(3)=dt*(vy+v_y(2)/2);
        
        v_x(4)=-dt*G*M*(x+x_k(3)) / R^3;
        v_y(4)=-dt*G*M*(y+y_k(3)) / R^3;
        x_k(4)=dt*(vx+v_x(3));
        y_k(4)=dt*(vy+v_y(3));
        
        vx=vx+(v_x(1)+2*v_x(2)+2*v_x(3)+v_x(4))/6;
        vy=vy+(v_y(1)+2*v_y(2)+2*v_y(3)+v_y(4))/6;
        
        vx_=[vx_ vx];
        vy_=[vy_ vy];
        
        x=x+(x_k(1)+2*x_k(2)+2*x_k(3)+x_k(4))/6;
        y=y+(y_k(1)+2*y_k(2)+2*y_k(3)+y_k(4))/6;
        
        x_=[x_ x];
        y_=[y_ y];
        
        t=t+dt;
        t_=[t_ t];
        
        E_pot=-G*M*m / (x^2+y^2);
        E_kin=(vx^2+vy^2)*m / 2;
        E_sum=E_pot+E_kin;
        
        E_pot_=[E_pot_ E_pot];
        E_kin_=[E_kin_ E_kin];
        E_sum_=[E_sum_ E_sum];
end
    plot(x_, y_)
    xlim([-190e+9, 190e+9]);
    ylim([-190e+9, 190e+9]);
    xlabel('x coordinates [m]');
    ylabel('y coordinates [m]');
    title('Orbital of Earth');
    
    figure(2);
    plot(t_, E_pot_)
    xlim([0, 365.256*24*60*60*year]);
    ylim([-3.60e+22, -3.48e+22]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Potencial Energy');
    
    figure(3);
    plot(t_, E_kin_)
    xlim([0, 365.256*24*60*60*year]);    
    ylim([2.6e+33, 2.7e+33]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Kinetic Energy');
    
    figure(4);
    plot(t_, E_sum_)
    xlim([0, 365.256*24*60*60*year]);    
    ylim([2.6e+33, 2.7e+33]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Sum of Energies');