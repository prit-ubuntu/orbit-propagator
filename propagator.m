function [State] = propagator(t, S, flag)

pos_vec = norm(S(1:3));

mu = 398600.4418e9;
multiplier = (-mu/(pos_vec^3));

Vx = S(4); Vy = S(5); Vz = S(6);

if flag==0 % only J2 forces acting
    j2_forces = j2_perturbations(pos_vec, S(3)); % [Ax, Ay, Az] acceleration due to J2
    Ax = multiplier*S(1) * (1 + j2_forces(1));
    Ay = multiplier*S(2) * (1 + j2_forces(2));
    Az = multiplier*S(3) * (1 + j2_forces(3));

elseif flag==1 % drag and J2 forces acting
    j2_forces = j2_perturbations(pos_vec, S(3)); % [Ax, Ay, Az] acceleration due to J2
    drag_accel = drag_perturbations(S);
    Ax = multiplier*S(1) * (1 + j2_forces(1)) + drag_accel(1);
    Ay = multiplier*S(2) * (1 + j2_forces(2)) + drag_accel(2);
    Az = multiplier*S(3) * (1 + j2_forces(3)) + drag_accel(3);

elseif flag==2 % no perturbations
    Ax = multiplier*S(1);
    Ay = multiplier*S(2);
    Az = multiplier*S(3);
    
elseif flag==3 % only drag
    drag_accel = drag_perturbations(S);
    Ax = multiplier*S(1) + drag_accel(1);
    Ay = multiplier*S(2) + drag_accel(2);
    Az = multiplier*S(3) + drag_accel(3);
end

State = [Vx, Vy, Vz, Ax, Ay, Az]';

end
