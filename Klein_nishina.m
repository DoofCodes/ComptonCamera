% Define constants
re = 2.8179403227e-15; % Classical electron radius in meters
E_gammas = [0.045, 0.1, 0.511,3,5]; % Energy of the photon in MeV
mc2 = 0.511; % Rest mass energy of the electron in MeV


% Define theta range
%theta_deg = randi([0, 180],1, 1000); % Theta from 0 to 2*pi
%theta = deg2rad(theta_deg);

% Prepare figure
figure;
hold on; % Hold on to plot multiple graphs on the same figure
  
load("angles.mat");
%disp(theta)
%disp(phi)

% Loop over each energy level to plot
for E_gamma = E_gammas
    epsilon= E_gamma/mc2;
    dSigmaC_dOmega_r_E = zeros(1, length(theta));
    %dSigmaC_dOmegaE_r_E = zeros(1,length(theta));
    for i = 1:length(theta)
        % Calculate the differential cross section per electron for Compton scattering
        dSigmaC_dOmega_r_E(i) = (1 / 2) * ((1 + cos(theta(i)).^2) ./ (1 + epsilon .* (1 - cos(theta(i)))).^2) .* ...
            (1+((epsilon^2 .* (1 - cos(theta(i))).^2) ./ (1 + epsilon .* (1 - cos(theta(i))) .* (1 + cos(theta(i)).^2))));
        %%dSigmaC_dOmegaE_r_E(i)= (1+epsilon^2)*(1-cos(theta(i)))^2/(cos(phi(i)))^3 * dSigmaC_dOmega_r_E(i);
    end
    % Plot the graph for this energy level
    plot(rad2deg(theta), dSigmaC_dOmega_r_E, '.','DisplayName', sprintf('E_{gamma} = %0.1f MeV', E_gamma));
    %polarplot(epsilon, dSigmaC_dOmegaE_r_E)
end
% Customize the plot
xlabel('\theta (degrees)');
ylabel('1/r^2 d\sigma_C / d\Omega (1/Sr)');
%set(gca, 'YScale', 'log'); % Set the y-axis to log scale
title('Differential Cross Section for Compton Scattering per Electron for Different Energies');
legend('show')
grid on;
hold off; % Release the figure for other plots
%disp(dSigmaC_dOmegaE_r_E)
% figure; % Create a new figure window

% Loop over each energy level to plot on the polar plot
%for E_gamma = E_gammas
%    epsilon = E_gamma / mc2;
%    dSigmaC_dOmegaE_r_E = zeros(1, length(theta));
%    for i = 1:length(theta)
        % Your existing differential cross section calculation here...
%        dSigmaC_dOmegaE_r_E(i)= (1+epsilon^2)*(1-cos(theta(i)))^2/(cos(phi(i)))^3 * dSigmaC_dOmega_r_E(i);
%    end
% 
%     % Convert your angle theta and your differential cross section into polar coordinates
%     % Note: You might need to adjust this part based on what exactly you want to plot as radius
%     rho = dSigmaC_dOmegaE_r_E; % For example, use your differential cross section values as radius
% 
%     % Polar plot for this energy level
%     polarplot(theta,rho ,'.', 'DisplayName', sprintf('epsilon = %0.1f', epsilon));
%     hold on; % Hold on to plot multiple graphs in the polar plot
% end
% 
% % Customize the polar plot
% title('Polar Representation for Different Energies');
% legend('show')