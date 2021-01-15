% Main script to call propagator and plotting functions

% Constants
gmEarth = 398600.4418e9; % m3/s2
radiusEarth = 6378.137e3; % m
craft_area = 10; % area m2
craft_mass = 500; % mass kg
craft_Cd = 2.2; % coefficient of drag
densityEarth = 4.89e-13; % kg/m3

% initial orbit
a = 6778.137e3; % semimajor axis (m) 
e = 1e-3; % eccentricity
i = 33; % inclination (degree)
argPeri = 90; % argument of perigee (degree)
trueAnomaly = 0; % true anomaly (degree)
RAAN = 0; % right ascesion of ascending node

% Orbit Propagation
% Initial Conditions
[r_vec, v_vec] = keplerian2ijk(a,e,i,RAAN,argPeri,trueAnomaly);
X = r_vec(1); Y = r_vec(2); Z = r_vec(3);
Vx = v_vec(1); Vy = v_vec(2); Vz = v_vec(3);
p
init_vector = [X, Y, Z, Vx, Vy, Vz,... 
               X, Y, Z, Vx, Vy, Vz,...
               X, Y, Z, Vx, Vy, Vz];

% Here, the same initial conditions are used for 3 models: 
% 1. Reference model (only J2 perturbations)
% 2. Realistic model (J2 + drag perturbations)
% 3. Forced realistic model 

% Time Definition
T = 2*pi*sqrt(a^3/gmEarth); % time period of orbit
% Time scale 
t0   = 0;  
num_days = 4;
tf   = num_days*24*60*60; % seconds 
step = 60; % one minute time steps
% t_span = t0:step:T+step; % plots only one orbit
t_span = t0:step:tf+step;  % plots until end of time

% Integrate EOMs using ODE45
options = odeset('RelTol',1e-10,'AbsTol',1e-10);
[t_scale, all_states] = ode45(@(t,S) new_propagator(t, S), t_span, init_vector, options);

% decouple states into two seperate vectors
s_reference = all_states(:,1:6);
s_real = all_states(:,7:12); % forced
s_idol = all_states(:,13:18); % unforced

% Plot both the states on the same graph
plot_states(t_scale, s_reference, s_idol)

% Compute & plot miss distance in RIC frame
[a_real_vec, a_ref_vec, a_idol_vec, force_in, drag_force] ...
    = compute_RIC(t_scale, s_reference, s_real, s_idol);
