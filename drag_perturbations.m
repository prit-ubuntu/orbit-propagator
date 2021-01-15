function [forces] = drag_perturbations(state)

% Inputs
    % State vector (position, velocity)
% Outputs
    % Forces in ECI frame (acceleration)

Cd = 2.2;
A = 10; % m2
rho = 4.89e-13; % kg/m3
mass = 500; % kg

omega = 7.292115e-5; % rotational speed of Earth

v_rel = zeros(3,1);

v_rel(1) = state(4) + omega*state(2);
v_rel(2) = state(5) - omega*state(1);
v_rel(3) = state(6);

forces = -0.5*(Cd*A/mass)*rho*norm(v_rel)*v_rel;

end