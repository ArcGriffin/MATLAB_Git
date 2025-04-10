function required_charge = calculate_particle_charge()
    % Constants
    g = 9.81; % Acceleration due to gravity (m/s^2)
    density_al2o3 = 3980; % Density of Al2O3 in kg/m^3
    
    % Inputs
    radius = input('Enter the particle radius (m): '); % e.g., 10e-6
    drop_height = input('Enter the drop height (m): '); % e.g., 0.02
    voltage = input('Enter the voltage of the plane (V): '); % e.g., 620
    net_acceleration = input('Enter the particle net acceleration (m/s^2): '); % e.g., 1.8
    
    % Particle volume and mass (assuming spherical particle)
    volume = (4/3) * pi * radius^3; % Volume in m^3
    mass = density_al2o3 * volume; % Mass in kg
    
    % Electric field
    electric_field = voltage / drop_height; % Electric field in V/m
    
    % Gravitational force
    force_gravity = mass * g; % Gravitational force in N
    
    % Electric force
    force_electric = mass * net_acceleration + force_gravity; % Electric force in N
    
    % Required charge
    required_charge = force_electric / electric_field; % Charge in C
    
    % Output
    fprintf('The required charge is %.3e C\n', required_charge);
end
