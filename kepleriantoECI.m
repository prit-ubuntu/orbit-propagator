function [X, Y, Z, Vx, Vy, Vz] = kepleriantoECI(a, ecc, inc, w, nu, RAAN)
%--------------------------------------------------------------------------------------------------------%
%
% 			USAGE: Conversion of Keplerian Classic Orbital Elements into geocentric-equatorial reference system OXYZ
%
% 			AUTHOR: Thameur Chebbi(PhD)		E-MAIL: chebbythamer@gmail.com
%
% 			DATE: 01,Oct,2020
%
% 			DESCIPTION:      This function is created to convert the classical 
%               		     orbital elements to cartesian position and velocity 
%		       		         parameters of any satellite orbit in the geocentric-equatorial
%                            reference system.
%
% 			INPUT:
% 			a:      Altitude.....................(Km)							
% 			ecc:    Eccentricity											    
% 			inc:	Inclination..................(rad)							
% 			w:	    Argument of perigee..........(rad)	
% 			nu:	    Satellite position...........(rad)							
% 			RAAN:	Right Asc. of Ascending Node.(rad)							
%
% 			OUTPUT:
%			Position Components: 		
% 			[X Y Z]...(Km)
%
%			Velocity Components:
% 			[Vx Vy Vz]...(Km/s) 														
%
%
%%---------------------------- Constants ----------------------------------------------%
mu_earth = 398600.4418e9; % Earth Gravitational Constant
re = 6378.137e3; % earth radius
%
%%--------------------------------------------------------------------------------------
p = a*(1-ecc ^2);
r_0 = p / (1 + ecc * cos(nu));
%
%%--------------- Coordinates in the perifocal reference system Oxyz -----------------%
%
% position vector coordinates
x = r_0 * cos(nu);
y = r_0 * sin(nu);
%
%
% velocity vector coordinates
Vx_ = -(mu_earth/p)^(1/2) * sin(nu);
Vy_ = (mu_earth/p)^(1/2) * (ecc + cos(nu));
%
%
%%-------------- the geocentric-equatorial reference system OXYZ ---------------------%
%
% position vector components X, Y, and Z
X = (cos(RAAN) * cos(w) - sin(RAAN) * sin(w) * cos(inc)) * x + (-cos(RAAN) * sin(w) - sin(RAAN) * cos(w) * cos(inc)) * y;
Y = (sin(RAAN) * cos(w) + cos(RAAN) * sin(w) * cos(inc)) * x + (-sin(RAAN) * sin(w) + cos(RAAN) * cos(w) * cos(inc)) * y;
Z = (sin(w) * sin(inc)) * x + (cos(w) * sin(inc)) * y;
% velocity vector components X', Y', and Z'
Vx = (cos(RAAN) * cos(w) - sin(RAAN) * sin(w) * cos(inc)) * Vx_ + (-cos(RAAN) * sin(w) - sin(RAAN) * cos(w) * cos(inc)) * Vy_;
Vy = (sin(RAAN) * cos(w) + cos(RAAN) * sin(w) * cos(inc)) * Vx_ + (-sin(RAAN) * sin(w) + cos(RAAN) * cos(w) * cos(inc)) * Vy_;
Vz = (sin(w) * sin(inc)) * Vx_ + (cos(w) * sin(inc)) * Vy_;



% 
% position = 1e6*[0,5.6789,3.6879]';
% velocity = 1e3*[-7.6762, 0, 0]';
% 
% init_vector = [position; velocity];
% tspan = 0:100:50000;
% 
% [t,S] = ode45(@propagator, tspan, init_vector);
% 
% % Separate my states into x,y,z components
% States_X = S(:,1); % all x
% States_Y = S(:,2); % all y
% States_Z = S(:,3); % all z
% States_Xdot = S(:,4); % all xdot
% States_Ydot = S(:,5); % all ydot
% States_Zdot = S(:,6); % all zdot
% % Develop the figure plot
% figure;
% plot3(States_X,States_Y,States_Z,'r');
% grid on;
% % title_form = sprintf('%s Trajectory About %s',Orbit,Body); % make the title unique to the orbit body and conic section
% % title(title_form);
% xlabel('X(km)');
% ylabel('Y(km)');
% zlabel('Z(km)');
% 
% 
% 
% % a = 6778.137e3;
% % ecc = 1e-3;
% % incl = 33;
% % RAAN = 0;
% % argp = 90;
% % nu = 0;
% % [r_ijk, v_ijk] = keplerian2ijk(a, ecc, incl, RAAN, argp, nu)
% % 
% % r_ijk =
% % 
% %    1.0e+06 *
% % 
% %     0.0000
% %     5.6789
% %     3.6879
% % 
% % 
% % v_ijk =
% % 
% %    1.0e+03 *
% % 
% %    -7.6762
% %     0.0000
% %     0.0000