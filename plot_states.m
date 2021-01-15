function plot_states(t_span, S, S_pert)

% Inputs
    % State vectors (position, velocity)
% Outputs
    % Plots comparing trajectories

close all
figure('color','white');
plot3(S(:,1),S(:,2),S(:,3),'r')
hold on
plot3(S_pert(:,1),S_pert(:,2),S_pert(:,3),'b')
% hold on
% plot3(S_pert(5760,1),S_pert(5760,2),S_pert(5760,3),'b*')
% hold on
% plot3(S(5760,1),S(5760,2),S(5760,3),'r*')
% legend('Unperturbed','Perturbed', 'Pert Sat (t_end)','Unpert Sat (t_end)')
legend('Unperturbed','Perturbed')
xlabel('\bf ECI x [m]');
ylabel('\bf ECI y [m]');
zlabel('\bf ECI z [m]');
title('Satellite Orbit in ECI Coordinates');
grid on
hold off

figure()
subplot(3,1,1)
plot(t_span, S(:,1),'r')
hold on
plot(t_span, S_pert(:,1),'b')
legend('Unperturbed','Perturbed')
title('ECI X-axis');
ylabel('Position [m]')
subplot(3,1,2)
plot(t_span, S(:,2),'r')
hold on
plot(t_span, S_pert(:,2),'b')
title('ECI Y-axis');
ylabel('Position [m]')
subplot(3,1,3)
plot(t_span, S(:,3),'r')
hold on
plot(t_span, S_pert(:,3),'b')
title('ECI Z-axis');
xlabel('Time (seconds)')
ylabel('Position [m]')
sgtitle('\bf Position in ECI frame')
hold off

figure()
subplot(3,1,1)
plot(t_span, S(:,4),'r')
hold on
plot(t_span, S_pert(:,4),'b')
legend('Unperturbed','Perturbed')
title('ECI X-axis');
ylabel('Velocity [m/s]')

subplot(3,1,2)
plot(t_span, S(:,5),'r')
hold on
plot(t_span, S_pert(:,5),'b')
title('ECI Y-axis');
ylabel('Velocity [m/s]')

subplot(3,1,3)
plot(t_span, S(:,6),'r')
hold on
plot(t_span, S_pert(:,6),'b')
title('ECI Z-axis');
ylabel('Velocity [m/s]')
xlabel('Time (seconds)')
sgtitle('\bf Velocity in ECI frame')
hold off

figure()
subplot(3,1,1)
plot(t_span, S(:,1)-S_pert(:,1),'b')
ylabel('\Delta [m]');
title('ECI X-axis');
subplot(3,1,2)
plot(t_span, S(:,2)-S_pert(:,2),'b')
title('ECI Y-axis');
ylabel('\Delta [m]');
subplot(3,1,3)
plot(t_span, S(:,3)-S_pert(:,3),'b')
title('ECI Z-axis');
ylabel('\Delta [m]');
xlabel('Time (seconds)')
sgtitle('\bf \Delta Position in ECI frame')
hold off

% figure(2)
% curve = animatedline('LineWidth',1);
% curve2 = animatedline('LineWidth',1);
% % set(gca,'XLim',[-1.5 1.5],'YLim',[-1.5 1.5],'ZLim',[0 10]);
% view(43,24);
% hold on;
% for i=1:length(S_pert)
%     addpoints(curve,S_pert(i,1),S_pert(i,2),S_pert(i,3));
%     addpoints(curve2,S(i,1),S(i,2),S(i,3));
%     head = scatter3(S_pert(i,1),S_pert(i,2),S_pert(i,3),'filled','MarkerFaceColor','r');
%     head2 = scatter3(S(i,1),S(i,2),S(i,3),'filled','MarkerFaceColor','b');
%     drawnow
%     pause(1e-7);
%     delete(head);
%     delete(head2);
% end

end