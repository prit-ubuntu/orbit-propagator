function [matrix] = R_transform(state)

R_vec = state(1:3);
V_vec = state(4:6);

H_vec = cross(R_vec,V_vec);

R_hat = R_vec./norm(R_vec);
C_hat = H_vec./norm(H_vec);
I_hat = cross(C_hat, R_hat);

matrix = [R_hat; I_hat; C_hat];

end