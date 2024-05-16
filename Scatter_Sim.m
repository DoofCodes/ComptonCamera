% Constants
h = 4.135667696e-18;      % Planck's constant (keV.s)
m_e = .511;    % Electron mass (MeV/c^2)
c = 3.0e8;          % Speed of light (m/s)

% Incident gamma-ray properties
%E_gamma = 1;    % Energy of incident gamma-ray (MeV)
%lambda_gamma = h * c / E_gamma; % Wavelength of incident gamma-ray (m)

% Initial gamma-ray energies to investigate (MeV)
E_gammas = [0.511, 1, 3, 5]; %( MeV)

% Number of photons to simulate
num_photons = 1000;

% Generate random scattering angles
%theta = [0*pi,pi/12, pi/6,pi/3, 0.5*pi,2*pi/3, pi]; % Random scattering angles (radians)for
theta_deg = randi([0, 180], 1, num_photons); % Angles in degrees
theta = deg2rad(theta_deg); % Convert degrees to radians

% Prepare graph for ΔE vs. θ 
figure;
subplot(1, 2, 1); % Prepare subplot 1
hold on; % Hold on to plot multiple datasets

% Prepare graph for φ vs. θ
subplot(1, 2, 2); % Prepare subplot 2
hold on; % Hold on to plot multiple datasets

% Loopin over each initial gamma-ray energy
for E_gamma = E_gammas
    lambda_gamma = h * c / E_gamma; % Wavelength of incident gamma-ray (m)
    delta_E = zeros(1, length(theta)); % Preallocate delta_e
    phi = zeros(1, num_photons); % Preallocate phi
    for i = 1:length(theta)
        % Compton shift
        %delta_lambda(i) = h / (m_e * c) * (1 - cos(theta(i)));
        % Wavelength of scattered gamma-ray
        %lambda_scat = lambda_gamma + delta_lambda;
        %energy transfer ∆E onto the electron
        delta_E(i) = E_gamma.*(1 - (1 ./ (1+(E_gamma ./ (m_e)) .* (1 - cos(theta(i))))));
        %Electron scatter angle φ
       tan_phi = (1./(1 + E_gamma./m_e)) .* cot(theta./2);
       phi= atan(tan_phi);
    end
   % Plot ΔE vs. θ for each initial energy
    subplot(1, 2, 1);
    plot(rad2deg(theta), delta_E, '.', 'DisplayName', sprintf('E_{gamma} = %0.1f MeV', E_gamma));
    
    % Plot φ vs. θ for each initial energy
    subplot(1, 2, 2);
    plot(rad2deg(theta), rad2deg(phi), '.', 'DisplayName', sprintf('E_{gamma} = %0.1f MeV', E_gamma));
end
% ΔE vs. θ plot
subplot(1, 2, 1);
xlabel('Scattering Angle θ (degrees)');
ylabel('Scattered Gamma-ray Energy (MeV)');
set(gca, 'YScale', 'log'); % Convert y-axis to logarithmic scale
title('ΔE vs. θ for Different Initial Energies');
legend('show');

% φ vs. θ plot
subplot(1, 2, 2);
xlabel('Scattering Angle θ (degrees)');
ylabel('φ (degrees)');
title('φ vs. θ for Different Initial Energies');
legend('show');

hold off; % Release the plot hold for both subplots
save('angles.mat', "theta","phi")