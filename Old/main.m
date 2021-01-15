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
num_days = 1;
tf   = num_days*24*60*60; % seconds 
step = 60; % one minute time steps

% global t_span
t_span = t0:step:tf+step;  % plots until end of time
% t_span = t0:step:T+step; % plots only one orbit                         

options = odeset('RelTol',1e-10,'AbsTol',1e-10);

enable_force = 0; 

% global s_theoretical

flag = 2;
[~,s_theoretical] = ode45(@(t,S) propagator(t, S, flag, enable_force), t_span, init_vector, options);

flag = 3; % perturbed model
[~,s_real] = ode45(@(t,S) propagator(t, S, flag, enable_force), t_span, init_vector, options);

% plot_states(t_span, s_theoretical, s_real)

% run test file
% test

global count

count = 0;

enable_force = 1;
flag = 3; % perturbed model
[~,s_forced] = ode45(@(t,S) propagator(t, S, flag, enable_force), t_span, init_vector, options);

% % Computing delta RIC
delta_RIC = zeros(length(s_real),3);
delta_RIC_forced = zeros(length(s_real),3);

for i = 1:length(s_real)
    R_matrix = R_transform(s_theoretical(i,:));
    delta_XYZ = s_real(i,1:3)-s_theoretical(i,1:3);
    delta_XYZ_forced = s_forced(i,1:3)-s_theoretical(i,1:3);
    delta_RIC(i,:) = R_matrix * delta_XYZ';
    delta_RIC_forced(i,:) = R_matrix * delta_XYZ_forced';
    
end

plot_states(t_span, s_theoretical, s_forced)

figure(5)
sgtitle('\bf Miss Distance in the RIC Frame')
subplot(3,1,1)
plot(t_span, delta_RIC(:,1)/1e3,'r')
hold on
plot(t_span, delta_RIC_forced(:,1)/1e3,'b')
legend('unforced','forced')
title('Radial (R)')
ylabel('\bf \Delta (km)')
xlabel('Time (sec)')

subplot(3,1,2)
plot(t_span, delta_RIC(:,2)/1e3,'r')
hold on
plot(t_span, delta_RIC_forced(:,2)/1e3,'b')
legend('unforced','forced')
title('In-track (I)')
ylabel('\bf \Delta (km)')
xlabel('Time (sec)')

subplot(3,1,3)
plot(t_span, delta_RIC(:,3)/1e3,'r')
hold on
plot(t_span, delta_RIC_forced(:,3)/1e3,'b')
legend('unforced','forced')
title('Cross-track (C)')
ylabel('\bf \Delta (km)')
xlabel('Time (sec)')

