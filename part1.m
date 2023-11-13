% Part 1a
% Close any old plots
close all

% Free space transmission matrix for 10 cm 
d = .1;
Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

% 9 angles from -pi/20 to pi/20
angles = -pi/20:pi/80:pi/20;

% Rays from each origin
origin1 = [zeros(1,9);angles;zeros(1,9);zeros(1,9)];
origin2 = [ones(1,9)*.01;angles;zeros(1,9);zeros(1,9)];

% Propogate rays through free space
rays_in = [origin1, origin2];
rays_out = Md*rays_in;

% Plot results
ray_z = [zeros(1,size(rays_in,2)); d*ones(1,size(rays_in,2))];
plot(ray_z, [rays_in(1,:); rays_out(1,:)]);

% Part 1b
a = 1;