function [forces] = drag_perturbations(state)

Cd = 2.2;
A = 10; % m2
rho = 4.89e-13; % kg/m3
mass = 500; % kg

% V = state(4:6);
% forces = -0.5*(Cd*A/mass)*rho*norm(V).*V;

omega = 7.292115e-5;

v_rel = zeros(3,1);

v_rel(1) = state(4) + omega*state(2);
v_rel(2) = state(5) - omega*state(1);
v_rel(3) = state(6);

forces = -0.5*(Cd*A/mass)*rho*norm(v_rel)*v_rel;

end