% Constants
mec2 = 0.511; % Electron rest mass energy in MeV
r0 = 2.818e-13; % electron radius in cm
E_gammas = [0.005,0.05, 0.5, 1, 2.5]; % in MeV

% Scattering angle from 0 to 2pi
theta = deg2rad(randi([0, 180],1, 1000));
load("angles.mat")
% Create a polar plot
figure;
for E = E_gammas
    epsilon = E/mec2; 
    differential_cross_section = klein_nishina(theta, E, mec2, r0);
    polarplot(theta, differential_cross_section,'.', 'DisplayName', sprintf('e = %g', epsilon));
    hold on; % Ensure multiple lines can be plotted
end
hold off;
title('Klein-Nishina Formula Differential Cross-Section');
legend('show');

% Plot 2: Differential Cross-Section wrt phi
figure; % Second figure for the modified Klein-Nishina formula
for E = E_gammas
    epsilon = E/mec2; 
    differential_cross_section = klein_nishina(theta, E, mec2, r0);
    differential_cross_section_E = klein_nishina_E( differential_cross_section, theta,phi, E, mec2);
    polarplot(theta, differential_cross_section_E,'.', 'DisplayName', sprintf('e = %g', epsilon));
    hold on;
end
hold off;
title('Polar representation of the differential cross section for the Compton scattered electron recoiling at an angle φ ');
legend('show');

% Define the Klein-Nishina formula as a function
function differential_cross_section = klein_nishina(theta, E, mec2, r0)
    alpha = 1 + (E/mec2) .* (1 - cos(theta));
    E_prime = E ./ alpha;
    differential_cross_section = (r0^2 / 2)* 10e27 .* (E_prime./E).^2 .* ((E./E_prime) + (E_prime./E) - sin(theta).^2); % 1 mb= 10e-27 cm^2
end

function differential_cross_section_E = klein_nishina_E( differential_cross_section, theta,phi, E, mec2)
    epsilon = E/mec2; 
    differential_cross_section_E = ((1+epsilon).^2*(1-cos(theta)).^2/(cos(phi)).^3) *differential_cross_section;
end