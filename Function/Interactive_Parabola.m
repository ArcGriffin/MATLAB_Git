function adjust_kinematic_inverted_parabola
    % Use the current open figure
    fig = gcf; 
    ax = gca;  % Get the current axes

    hold on;   % Ensure we don't overwrite the current plot

    % Initial values for the parameters
    y0 = 100;        % Initial vertical position
    v0y = 50;        % Initial vertical velocity
    a_y = -9.8;      % Vertical acceleration (gravity)

    % Create sliders to adjust initial values
    sliderY0 = uicontrol('Style', 'slider', 'Min', 0, 'Max', 200, ...
        'Value', y0, 'Position', [20 20 200 20], 'Parent', fig);
    sliderV0y = uicontrol('Style', 'slider', 'Min', -100, 'Max', 100, ...
        'Value', v0y, 'Position', [20 50 200 20], 'Parent', fig);
    sliderAy = uicontrol('Style', 'slider', 'Min', -20, 'Max', 0, ...
        'Value', a_y, 'Position', [20 80 200 20], 'Parent', fig);

    % Add labels
    uicontrol('Style', 'text', 'Position', [230 20 50 20], 'String', 'y0', 'Parent', fig);
    uicontrol('Style', 'text', 'Position', [230 50 50 20], 'String', 'v0y', 'Parent', fig);
    uicontrol('Style', 'text', 'Position', [230 80 50 20], 'String', 'a_y', 'Parent', fig);

    % Add text fields to display parameter values
    textY0 = uicontrol('Style', 'text', 'Position', [280 20 100 20], 'String', num2str(y0), 'Parent', fig);
    textV0y = uicontrol('Style', 'text', 'Position', [280 50 100 20], 'String', num2str(v0y), 'Parent', fig);
    textAy = uicontrol('Style', 'text', 'Position', [280 80 100 20], 'String', num2str(a_y), 'Parent', fig);

    % Generate time values for the curve with 1-second increments
    t_fit = 0:1:10;  % Time vector from 0 to 10 seconds with 1-second increments

    % Plot initial inverted parabola on the current axes
    y_fit = -kinematicEquation(t_fit, y0, v0y, a_y);  % Invert the parabola
    h = plot(ax, t_fit, y_fit, 'r-o', 'LineWidth', 2);

    % Add listeners to update the curve and text on slider movement
    addlistener(sliderY0, 'ContinuousValueChange', @(src, event) updateCurve());
    addlistener(sliderV0y, 'ContinuousValueChange', @(src, event) updateCurve());
    addlistener(sliderAy, 'ContinuousValueChange', @(src, event) updateCurve());

    function updateCurve()
        % Get current slider values
        y0 = sliderY0.Value;
        v0y = sliderV0y.Value;
        a_y = sliderAy.Value;

        % Update the inverted kinematic curve
        y_fit = -kinematicEquation(t_fit, y0, v0y, a_y);  % Invert the parabola
        set(h, 'YData', y_fit);

        % Update the displayed parameter values
        set(textY0, 'String', num2str(y0, '%.2f'));
        set(textV0y, 'String', num2str(v0y, '%.2f'));
        set(textAy, 'String', num2str(a_y, '%.2f'));
    end

    hold off;
end

function y = kinematicEquation(t, y0, v0y, a_y)
    % Calculate the vertical position using the kinematic equation
    y = y0 + v0y * t + 0.5 * a_y * t.^2;
end

