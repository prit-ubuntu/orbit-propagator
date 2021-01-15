function [a_real_vec, a_ref_vec, a_idol_vec, force_vec_analysis, drag_force_RIC]...
    = compute_RIC(t_scale, s_theoretical, s_real, s_idol)

% Inputs
    % State vectors (position, velocity)
% Outputs
    % Plots comparing trajectories

close all
% % Computing delta RIC
delta_RIC = zeros(length(s_real),3);
delta_RIC_forced = zeros(length(s_real),3);

% % Semi-major Axis 
a_real_vec = zeros(length(s_real),1);
a_ref_vec = zeros(length(s_real),1);
a_idol_vec = zeros(length(s_real),1);

a_diff_vec_control = zeros(length(s_real),1);
a_diff_vec_idol = zeros(length(s_real),1);

% post force vector computation
force_vec_analysis = zeros(length(s_real), 3);

% drag force recording
drag_force_vector = zeros(length(s_real), 3);
drag_force_RIC = zeros(length(s_real), 3);

for i = 1:length(s_real)
%     delta RIC plots
    R_matrix = R_transform(s_theoretical(i,:));
    delta_XYZ = s_idol(i,1:3)-s_theoretical(i,1:3);
    delta_XYZ_forced = s_real(i,1:3)-s_theoretical(i,1:3);
    delta_RIC(i,:) = R_matrix * delta_XYZ';
    delta_RIC_forced(i,:) = R_matrix * delta_XYZ_forced';
    
%     semi-major axis for each model
    r_ijk = s_real(i,1:3);
    v_ijk = s_real(i,4:6);
    [a_real, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk, v_ijk);
    a_real_vec(i,1) = a_real;
    
    r_ijk_ref =  s_theoretical(i,1:3);
    v_ijk_ref = s_theoretical(i,4:6);
    [a_ref, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk_ref, v_ijk_ref);
    a_ref_vec(i,1) = a_ref;
    
    r_ijk_idol = s_idol(i,1:3);
    v_ijk_idol = s_idol(i,4:6);
    [a_idol, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk_idol, v_ijk_idol);
    a_idol_vec(i,1) = a_idol;
    
    a_diff_vec_control(i,1) = a_real - a_ref ;
    a_diff_vec_idol(i,1) = a_idol - a_ref ;
    
%     force vector calculation
    dummy = [s_theoretical(i,:), s_real(i,:)]';
    force_vec_analysis(i,:) = input_forces(dummy);

%     drag force vector calculation
    drag_force_vector(i,:) = drag_perturbations(s_idol(i,:));
    drag_force_RIC(i,:) = R_matrix * drag_force_vector(i,:)';
end


figure(9)
sgtitle('\bf Miss Distance in the RIC Frame')
subplot(3,1,1)
plot(t_scale, delta_RIC(:,1)/1e3,'r')
title('Radial (R)')
ylabel('\bf \Delta (km)')
subplot(3,1,2)
plot(t_scale, delta_RIC(:,2)/1e3,'r')
title('In-track (I)')
ylabel('\bf \Delta (km)')
subplot(3,1,3)
plot(t_scale, delta_RIC(:,3)/1e3,'r')
title('Cross-track (C)')
ylabel('\bf \Delta (km)')
xlabel('Time (sec)')
sgtitle('\bf \Delta RIC: Nominal and Unforced Model')

figure(10)
plot(t_scale, a_diff_vec_idol,'r')
title('\bf Change in semi-major axis')
ylabel('\bf \Delta a (m)')
xlabel('Time (sec)')

% % % % % % % % % % % % 
figure(11)
sgtitle('\bf Miss Distance in the RIC Frame')
subplot(3,1,1)
plot(t_scale, delta_RIC_forced(:,1)/1e3,'b')
title('Radial (R)')
ylabel('\bf \Delta (km)')

subplot(3,1,2)
plot(t_scale, delta_RIC_forced(:,2)/1e3,'b')
title('In-track (I)')
ylabel('\bf \Delta (km)')

subplot(3,1,3)
plot(t_scale, delta_RIC_forced(:,3)/1e3,'b')
title('Cross-track (C)')
ylabel('\bf \Delta (km)')
xlabel('Time (sec)')
sgtitle('\bf \Delta RIC: Nominal and Forced Model')

figure(12)
plot(t_scale, a_diff_vec_control,'b')
title('\bf Change in semi-major axis with forced model.')
ylabel('\bf \Delta a (m)')
xlabel('Time (sec)')

figure(13)
sgtitle('\bf Force Input applied in ECI frame')
subplot(3,1,1)
plot(t_scale, force_vec_analysis(:,1),'b')
xlabel('Time (sec)')
ylabel('Inpulse in X')
subplot(3,1,2)
plot(t_scale, force_vec_analysis(:,2),'b')
xlabel('Time (sec)')
ylabel('Inpulse in Y')
subplot(3,1,3)
plot(t_scale, force_vec_analysis(:,3),'b')
xlabel('Time (sec)')
ylabel('Inpulse in Z')

end