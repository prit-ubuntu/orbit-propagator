function plot_states(t_span, S, S_pert)

figure('color','white');
plot3(S(:,1),S(:,2),S(:,3),'r')
hold on
plot3(S_pert(:,1),S_pert(:,2),S_pert(:,3),'b')
legend('Unperturbed','Perturbed')
xlabel('ECI x [m]');
ylabel('ECI y [m]');
zlabel('ECI z [m]');
title('Satellite Orbit in ECI Coordinates');
grid on

figure(2)
subplot(3,1,1)
plot(t_span, S(:,1),'r')
hold on
plot(t_span, S_pert(:,1),'b')
legend('Unperturbed','Perturbed')
title('ECI x [m]');
subplot(3,1,2)
plot(t_span, S(:,2),'r')
hold on
plot(t_span, S_pert(:,2),'b')
title('ECI y [m]');
subplot(3,1,3)
plot(t_span, S(:,3),'r')
hold on
plot(t_span, S_pert(:,3),'b')
title('ECI z [m]');
sgtitle('Position in ECI frame')

figure(3)
subplot(3,1,1)
plot(t_span, S(:,4),'r')
hold on
plot(t_span, S_pert(:,4),'b')
legend('Unperturbed','Perturbed')
title('ECI x velocity [m/s]');
subplot(3,1,2)
plot(t_span, S(:,5),'r')
hold on
plot(t_span, S_pert(:,5),'b')
title('ECI y velocity [m/s]');
subplot(3,1,3)
plot(t_span, S(:,6),'r')
hold on
plot(t_span, S_pert(:,6),'b')
title('ECI z velocity [m/s]');
legend('Unperturbed','Perturbed')
sgtitle('Velocity in ECI frame')


end