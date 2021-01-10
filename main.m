gmEarth = 398600.4418e9; % m3/s2
radiusEarth = 6378.137e3; % m
craft_area = 10; % m2
craft_mass = 500; % kg
craft_Cd = 2.2;
densityEarth = 4.89e-13; % kg/m3

% orbit reference R
a = 6778.137e3; % semimajor axis (m) 
e = 1e-3; % eccentricity
i = 33; % inclination (degree)
argPeri = 90; % argument of perigee (degree)
trueAnomaly = 0; % true anomaly (degree)
RAAN = 0; % right ascesion of ascending node

% position = 1e6*[0,5.6789,3.6879]';
% velocity = 1e3*[-7.6762, 0, 0]';
% 
% init_vector = [position; velocity];

[X, Y, Z, Vx, Vy, Vz] = kepleriantoECI(a,e,deg2rad(i),deg2rad(argPeri),deg2rad(trueAnomaly),deg2rad(RAAN));
init_vector = [X,Y,Z,Vx,Vy,Vz];

T = 2*pi*sqrt(a^3/gmEarth);

t0   = 0;                                        
tf   = 4*24*60*60; % seconds 
step = 60; % one minute time steps

t_span = t0:step:tf+step;  % plots until end of time
% t_span = t0:step:T+step; % plots only one orbit                         

options = odeset('RelTol',1e-10,'AbsTol',1e-10);

flag = 0;
[~,s_theoretical] = ode45(@(t,S) propagator(t, S, flag), t_span, init_vector, options);

flag = 1; % perturbed model
[~,s_real] = ode45(@(t,S) propagator(t, S, flag), t_span, init_vector, options);

plot_states(t_span, s_theoretical, s_real)

% RIC_theoretical = RIC_convert(s_theoretical);
% RIC_real = RIC_convert(s_real);
% 
% delta_RIC = RIC_theoretical - RIC_real;

% % Method - 2
delta_RIC = zeros(length(s_real),3);

for i = 1:length(s_real)
    delta_XYZ = s_theoretical(i,1:3)-s_real(i,1:3);
    delta_RIC(i,:) = R_transform(s_real(i,:))*delta_XYZ';
end

figure(4)
subplot(3,1,1)
plot(t_span, delta_RIC(:,1)/1e3)
title('Radial (R)')
ylabel('Miss Distance (km)')
xlabel('Time (sec)')

subplot(3,1,2)
plot(t_span, delta_RIC(:,2)/1e3)
title('In-track (I)')
ylabel('Miss Distance (km)')
xlabel('Time (sec)')

subplot(3,1,3)
plot(t_span, delta_RIC(:,3)/1e3)
title('Cross-track (C)')
ylabel('Miss Distance (km)')
xlabel('Time (sec)')

figure(5)
plot(delta_RIC(:,1),delta_RIC(:,2),'r')
title('R-I (x-y)')
figure(6)
plot(delta_RIC(:,2),delta_RIC(:,3),'r')
title('I-C (x-y)')
figure(7)
plot(delta_RIC(:,3),delta_RIC(:,1),'r')
title('C-R (x-y)')
