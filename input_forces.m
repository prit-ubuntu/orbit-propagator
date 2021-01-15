function [impulse_force] = input_forces(S)

% Inputs
    % State vector (position, velocity) 
    %  (all models)
% Outputs
    % Forces in ECI frame (acceleration)

s_ref = S(1:6)'; % first six elements belong to reference model
s_real = S(7:12)'; % last six elements belong to real model

position_delta = s_real(1:3) - s_ref(1:3);
R_matrix = R_transform(s_ref);
delta_RIC = R_matrix * position_delta'; 
% compute miss vector in RIC frame

if delta_RIC(2) > 4.8e3
    force_RIC = 1e-5*[0;2;0];
    impulse_force = R_matrix' * force_RIC ;
else
    impulse_force = [0;0;0];
end

end
