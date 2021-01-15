function [State] = propagator(t, S, flag, input_force)

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


force_vec = [0,0,0];

if input_force == 1
    force_vec = [0.1,0.1,0.1];  
end

% global count;
% if (input_force == 1 && t > 76850)
% %     display('yes');
% %     display(t);
%     if count == 0
%         display(drag_accel)
%         force_vec = 1.0e+15 * [-1.690913649894568, 2.255162334656516, 1.464519544018974];
%         display('yes inside');
%         count = count + 1;
%     end
% end
        
State = [Vx, Vy, Vz, Ax+force_vec(1), Ay+force_vec(2), Az + force_vec(3)]';

end
