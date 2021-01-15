mu = 398600.4418e9;

a_real_vec = zeros(length(s_real),1);
a_ref_vec = zeros(length(s_real),1);

norm_vec = zeros(length(s_real),1);
a_diff_vec = zeros(length(s_real),1);

for i=1:length(s_real)
    r_ijk = s_real(i,1:3);
    v_ijk = s_real(i,4:6);
    display(r_ijk)
    display(v_ijk)
    
    [a_real, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk, v_ijk);
    a_real_vec(i,1) = a_real;
    
    r_ijk_ref =  s_theoretical(i,1:3);
    v_ijk_ref = s_theoretical(i,4:6);
    display(size(r_ijk_ref))
    display(size(v_ijk_ref))
    [a_ref, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk_ref, v_ijk_ref);
    a_ref_vec(i,1) = a_ref;
    
    norm_vec(i,1) = norm(s_theoretical(i,1:3))-norm(s_real(i,1:3));
    a_diff_vec(i,1) = a_ref - a_real;
end

figure(1)
plot(t_span, a_real_vec,'r') 
hold on
plot(t_span, a_ref_vec,'b') 
legend('Real','Ref')
hold off

figure(2)
plot(t_span, norm_vec, 'r')
hold on 
plot(t_span, a_diff_vec, 'b')
legend('ECI norm','A diff')

% hohmann delta v 

t_int = 1282;

delta_a = a_ref_vec(t_int) - a_real_vec(t_int);

v_a = sqrt(mu/a_real_vec(t_int));
v_ta = sqrt((2*mu/a_real_vec(t_int))-(1/(delta_a+a_ref_vec(t_int))));

del_v1 = v_ta - v_a;

del_v_eic = inv(R_transform(s_theoretical(t_int,:))) * [0;del_v1;0];


%     force_RIC = 9.173470583755262e-06*[0;1;0];
%     force_RIC = 1e-3*[0;0.08120;0];






