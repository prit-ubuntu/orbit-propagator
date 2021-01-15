function [forces] = j2_perturbations(r_norm, Z)

% Inputs
    % State vector (position, velocity)
% Outputs
    % Forces in ECI frame (acceleration)

J2 = 1.08262668e-3; % harmonic constant
rE = 6378.137e3; % radius of earth

forces(1) = 1.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ;
forces(2) = 1.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ; 
forces(3) = 4.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ;

end