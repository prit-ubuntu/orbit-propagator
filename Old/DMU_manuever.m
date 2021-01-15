function [manuever_vec] = DMU_manuever(S_ref, S_real, delta_RIC)

gmEarth = 398600.4418e9;

manuever_vec = zeros(5762,3);

for i = 1:length(delta_RIC)
    
    if (delta_RIC(i,2) >= 5 && delta_RIC(i,2) <= 6) 
%         display(i)
%         convert ECI to elements
        r_ijk = S_real(i,1:3);
        v_ijk = S_real(i,4:6);
        [a_real, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk, v_ijk);
        
        r_ijk_ref =  S_ref(i,1:3);
        v_ijk_ref = S_ref(i,4:6);
        [a_ref, ~, ~, ~, ~, ~, ~, ~, ~] = ijk2keplerian(r_ijk_ref, v_ijk_ref);
        
        delta_V = sqrt(gmEarth/a_ref) - sqrt(gmEarth/a_real);
        
        v_RIC = [0;delta_V;0];
        
        ric_eci = inv(R_transform(S_ref(i,:)));
        
        deltaV_EIC = ric_eci * v_RIC;
        
        manuever_vec(i,:) = deltaV_EIC;
%         find semi
    
    else
        manuever_vec(i,:) = [0,0,0];
        
    end

end


end