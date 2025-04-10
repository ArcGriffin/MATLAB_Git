% Function to calculate derivatives
function [dx, dy, dvx, dvy] = derivatives(x, y, vx, vy, m, q1, q2, k, g)
    r = sqrt((x)^2 + y^2); % Distance between particles
    Fe = k * q1 * q2 / r^2; % Magnitude of electrostatic force
    Fx = Fe * x / r; % Electrostatic force in x direction
    Fy = Fe * y / r; % Electrostatic force in y direction
    
    dx = vx;
    dy = vy;
    dvx = Fx / m;
    dvy = -g + Fy / m;
end