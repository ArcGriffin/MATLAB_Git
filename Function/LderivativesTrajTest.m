% Function to calculate derivatives
function [dx, dy, dvx, dvy] = derivatives(x, y, vx, vy, m, q1, q2, q3, k, g)
    r1 = sqrt((x+0.00001).^2 + (y).^2); % Distance between particles
    r2 = sqrt((x-0.00001).^2 + (y).^2); % Distance between particles
    Fe1 = (k * q1 * q2 / r1.^2);% Magnitude of electrostatic force
    Fe2 = (k * q3 * q2 / r2.^2);% Magnitude of electrostatic force
    Fx = (Fe1 * x / r1)+(Fe2 * x / r2); % Electrostatic force in x direction
    Fy = (Fe1 * y / r1)+(Fe2 * y / r2); % Electrostatic force in y direction
    dx = vx;
    dy = vy;
    dvx = Fx / m;
    dvy = -g + Fy / m;
end