function [states] = new_propagator(t, S)

% Inputs
    % State vector (position, velocity)
% Outputs
    % Derivative of State Vector  (velocity, acceleration)

s_ref = S(1:6); % first six elements belong to reference model
s_real = S(7:12); % second six elements belong to real model
s_idol = S(13:18); % last six elements belong to model without control

mu = 398600.4418e9; % GM of earth

% reference state vector calculation
pos_vec_ref = norm(s_ref(1:3));
multiplier_ref = (-mu/(pos_vec_ref^3));
Vx_ref = s_ref(4); Vy_ref = s_ref(5); Vz_ref = s_ref(6);

j2_forces_ref = j2_perturbations(pos_vec_ref, s_ref(3)); % [Ax, Ay, Az] acceleration due to J2

Ax_ref = multiplier_ref*s_ref(1) * (1 + j2_forces_ref(1));
Ay_ref = multiplier_ref*s_ref(2) * (1 + j2_forces_ref(2));
Az_ref = multiplier_ref*s_ref(3) * (1 + j2_forces_ref(3));

% -----------------------------------------------------------------------
% forced real state vector calculation
pos_vec_real = norm(s_real(1:3));
multiplier_real = (-mu/(pos_vec_real^3));
Vx_real = s_real(4); Vy_real = s_real(5); Vz_real = s_real(6);

j2_forces_real = j2_perturbations(pos_vec_real, s_real(3)); % [Ax, Ay, Az] acceleration due to J2
drag_accel = drag_perturbations(s_real);
force_vec = input_forces(S);

Ax_real = multiplier_real*s_real(1) * (1 + j2_forces_real(1)) + drag_accel(1) + force_vec(1);
Ay_real = multiplier_real*s_real(2) * (1 + j2_forces_real(2)) + drag_accel(2) + force_vec(2);
Az_real = multiplier_real*s_real(3) * (1 + j2_forces_real(3)) + drag_accel(3) + force_vec(3);

% -----------------------------------------------------------------------
% unforced real state vector calculation
pos_vec_idol = norm(s_idol(1:3));
multiplier_idol = (-mu/(pos_vec_idol^3));
Vx_idol = s_idol(4); Vy_idol = s_idol(5); Vz_idol = s_idol(6);

j2_forces_idol = j2_perturbations(pos_vec_idol, s_idol(3)); % [Ax, Ay, Az] acceleration due to J2
drag_accel_idol = drag_perturbations(s_idol);

Ax_idol = multiplier_idol*s_idol(1) * (1 + j2_forces_idol(1)) + drag_accel_idol(1); 
Ay_idol = multiplier_idol*s_idol(2) * (1 + j2_forces_idol(2)) + drag_accel_idol(2);
Az_idol = multiplier_idol*s_idol(3) * (1 + j2_forces_idol(3)) + drag_accel_idol(3);

% -----------------------------------------------------------------------
states = [Vx_ref, Vy_ref, Vz_ref, Ax_ref, Ay_ref, Az_ref, ...
    Vx_real, Vy_real, Vz_real, Ax_real, Ay_real, Az_real, ...
    Vx_idol, Vy_idol, Vz_idol, Ax_idol, Ay_idol, Az_idol]';