% Close any old plots
close all

% Part 1a
% Free space transmission matrix for 10 cm 
d1 = .2;
Md1 = [1 d1 0 0; 0 1 0 0; 0 0 1 d1; 0 0 0 1];

% 9 angles from -pi/20 to pi/20
angles = -pi/20:pi/80:pi/20;

% Rays from each origin
origin1 = [zeros(1,9);angles;zeros(1,9);zeros(1,9)];
origin2 = [ones(1,9)*.01;angles;zeros(1,9);zeros(1,9)];

% Propogate rays through free space
rays_in1 = [origin1, origin2];
rays_out1 = Md1*rays_in1;

% Plot results
figure;
ray_z1 = [zeros(1,size(rays_in1,2)); d1*ones(1,size(rays_in1,2))];
plot(ray_z1, [rays_in1(1,:); rays_out1(1,:)]);
xlabel("z(m)")
ylabel("z(m)")
title("Ray tracing through free space")
% Part 1b
f = 0.15; % Focal Length
r = 0.02; % Radius of Lens

d2 = 1/(1/f-1/d1); % Calculate d2 constant

% Free space transmission matrix after going through lens
Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

% Lens transmission matrix for focal length f
Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

% Initial Angle and Position
rays_in2 = [origin1, origin2];

% Angle and Position after free transmission for d1 distance
rays_out2a = Md1*rays_in2;

% Angle and Position after going through lens and travel for d2 distance
rays_out2b = Md2*Mf*Md1*rays_in2;

% Create Logical Index to find the light that has contact with the lens
idx1 = abs(rays_out2a(1,:)) <= r;


% Plot the figure
figure;
ray_z2 = [zeros(1,size(rays_in2,2)); (d1)*ones(1,size(rays_in2,2))];
ray_z4 = [(d1)*ones(1,size(rays_in2,2)); (d2)*ones(1,size(rays_in2,2))];
plot(ray_z2, [rays_in2(1,:); rays_out2a(1,:)]);
hold on
plot(ray_z4(1:2,idx1), [rays_out2a(1,idx1); rays_out2b(1,idx1)]);
hold on

% Plot the lens
rectangle('Position',[0.2 -0.02 0.005 0.04],'Curvature',1)
hold off

%Title
xlabel("z(m)")
ylabel("z(m)")
title("Ray tracing through a finite-sized lens")