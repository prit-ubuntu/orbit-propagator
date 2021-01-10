function [forces] = j2_perturbations(r_norm, Z)

J2 = 1.08262668e-3;
rE = 6378.137e3;

forces(1) = 1.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ;
forces(2) = 1.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ; 
forces(3) = 4.5*J2*(rE/r_norm)^2 - 7.5*J2*(rE*Z/r_norm^2)^2 ;

end