clear all, close all;

M=1.98847e+30;      %Nap tömege [kg]
m=5.9722e+24;       %Föld tömege [kg]
G=6.67404e-11;      %gravitációs állandó [m^3*kg^{-1}*s^{-2}]
r_nap=696342000;

R=152.10e+9;     %átlagos távolság a Naptól [m]

year=4;

T=365.256*24*60*60*year;     %keringési idõ [s]

figure(1);
keztedi_feltetelek=[0, 29780, R, 0];

diff= @(t, u) [-G*M*u(3)/(u(3)^2+u(4)^2)^(3/2); -G*M*u(4)/(u(3)^2+u(4)^2)^(3/2); u(1); u(2)];
[U, V]=ode45(diff, [0, T], keztedi_feltetelek);

plot(V(:,3), V(:,4));
xlim([-190e+9, 190e+9]);
ylim([-190e+9, 190e+9]);
xlabel('x coordinates [m]');
ylabel('y coordinates [m]');
title('Orbital of Earth');

    figure(2);
    plot(U(:,1), -G*M*m./(V(:,3).^2+V(:,4).^2))
    xlim([0, T]);
  %  ylim([-3.60e+22, -3.48e+22]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Potencial Energy');
    
    figure(3);
    plot(U(:,1), 0.5*m.*(V(:,1).^2+V(:,2).^2))
    xlim([0, T]);    
  %  ylim([2.6e+33, 2.7e+33]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Kinetic Energy');
    
    figure(4);
    plot(U(:,1), -G*M*m./(V(:,3).^2+V(:,4).^2) +0.5.*(V(:,1).^2+V(:,2).^2))
    xlim([0, T]);    
%    ylim([2.6e+33, 2.7e+33]);
    xlabel('time');
    ylabel('Energy [J]');
    title('Sum of Energies');