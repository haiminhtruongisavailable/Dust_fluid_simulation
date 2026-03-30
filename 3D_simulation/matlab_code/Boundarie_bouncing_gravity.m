%% 10 Particles with Visible Boundaries + Success Pop-up

clear; clc; close all;

domainSize = 10.0;
dt = 0.032;
N_PARTICLES = 10;

% Initialize particles
pos = zeros(N_PARTICLES, 2);
vel = zeros(N_PARTICLES, 2);

for i = 1:N_PARTICLES
    pos(i, :) = [1.5 + rand*2, 6 + rand*2.5];
    vel(i, :) = [1.2 + rand*1.5, -1.5 + rand*1.0];
end

% Create flexible figure
fig = figure('Color', 'white', 'Position', [100 100 900 900], ...
             'Name', 'DustCluster - 10 Particles Simulation', ...
             'NumberTitle', 'off', ...
             'Resize', 'on', ...
             'Toolbar', 'figure');

ax = gca;
ax.Color = 'white';
ax.XLim = [0 domainSize];
ax.YLim = [0 domainSize];
ax.XColor = 'black';
ax.YColor = 'black';
ax.GridColor = [0.7 0.7 0.7];
grid on;

title('10 Particles with Visible Boundaries', 'FontSize', 14);
xlabel('X Axis');
ylabel('Y Axis');

% Draw particles
h_particles = plot(pos(:,1), pos(:,2), 'o', 'MarkerSize', 10, ...
                   'MarkerFaceColor', [0.85 0.65 0.4], ...
                   'MarkerEdgeColor', 'black', 'LineWidth', 1.5);

% Draw visible boundary box (red rectangle)
hold on;
boundary = rectangle('Position', [0.5, 0.5, domainSize-1, domainSize-1], ...
                     'EdgeColor', 'red', 'LineWidth', 2.5, 'LineStyle', '--');

zoom on;
pan on;

for frame = 1:800
    for i = 1:N_PARTICLES
        vel(i,2) = vel(i,2) - 9.81 * dt * 0.9;
        pos(i,:) = pos(i,:) + vel(i,:) * dt;
        
        if pos(i,1) <= 0.5 || pos(i,1) >= domainSize - 0.5
            vel(i,1) = vel(i,1) * -0.88;
            pos(i,1) = max(0.5, min(domainSize - 0.5, pos(i,1)));
        end
        if pos(i,2) <= 0.5 || pos(i,2) >= domainSize - 0.5
            vel(i,2) = vel(i,2) * -0.88;
            pos(i,2) = max(0.5, min(domainSize - 0.5, pos(i,2)));
        end
    end
    
    h_particles.XData = pos(:,1);
    h_particles.YData = pos(:,2);
    
    drawnow;
    pause(0.045);
end

disp('Simulation finished.');

% === Success Pop-up Message ===
successFig = uifigure('Name', 'Simulation Complete', 'Position', [600 400 360 140]);
uialert(successFig, 'Operation completed successfully.', 'Success', 'Icon', 'success');
