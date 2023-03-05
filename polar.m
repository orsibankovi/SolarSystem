clear all, close all;
M=1.98847e+30;      %Nap tömege [kg]
m=5.9722e+24;       %Föld tömege [kg]
G=6.67404e-11;      %gravitációs állandó [m^3*kg^{-1}*s^{-2}]
r_nap=696342000;
R=149.6e+9;     %átlagos távolság a Naptól [m]

year=3;

T=365.256*24*60*60*year;     %keringési idő [s]

x=R;
y=0;
v0=29.78e+3;
vx=0;
vy=v0;
t=0; 
E_pot=-G*M*m / (x^2+y^2);
E_kin=(vx^2+vy^2)*m / 2;
E_sum=E_pot+E_kin;

h=R*(vx^2+vy^2)^(0.5)      %r^2*theta derivalt, perdulet egysegnyi tomegre

kezdeti_feltetelek=[x, 0, 0];               %r, kezdeti teta derivalt,  teta
diff=@(t,r) [r(2); -G*M/r(1)^2+h^2/r(1)^3; h/r(1)^2];
[U, V] = ode45(diff, [0 T], kezdeti_feltetelek);

plot(cos(V(:,3)).*V(:, 1), sin(V(:,3)).*V(:,1));
xlim([-190e+9, 190e+9]);
ylim([-190e+9, 190e+9]);
xlabel('x coordinates [m]');
ylabel('y coordinates [m]');
title('Orbital of Earth');

    figure(2);
    plot(U(:,1), -G*M*m./V(:,1))
    xlim([0, T]);
    ylim([-5.35e+33, -5.25e+33]);
    xlabel('time [s]');
    ylabel('Energy [J]');
    title('Potencial Energy');
    
    figure(3);
    plot(U(:,1), 0.5*m.*(h./V(:,1)+V(:,2)).^2)
    xlim([0, T]);    
    ylim([2.6e+33, 2.7e+33]);
    xlabel('time [s]');
    ylabel('Energy [J]');
    title('Kinetic Energy');
    
    figure(4);
    plot(U(:,1), -G*M*m./V(:,1) +0.5*m.*(h./V(:,1)+V(:,2)).^2)
    xlim([0, T]);    
    ylim([-2.7e+33, -2.6e+33]);
    xlabel('time [s]');
    ylabel('Energy [J]');
    title('Sum of Energies');