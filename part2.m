% Close any old plots
close all

% Load data (part a)
load("lightField.mat")

% Vary sensor width (part b)
% for w=0:.001:.1
%     img = rays2img(rays(1,:), rays(3,:), w, 200);
%     imshow(img);
% end

% Vary pixel count (part c)
% for p=50:1000
%     img = rays2img(rays(1,:), rays(3,:), .01, p);
%     imshow(img);
% end

% Vary distance (part d)
% for d = 0:.1:10
%     Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
%     rays2 = Md*rays;
%     img = rays2img(rays2(1,:), rays2(3,:), .01, 500);
%     imshow(img);
% end

% Plot image
% img = rays2img(rays(1,:), rays(3,:), .02, 500);
% imshow(img);

% Question 2:
% We have no optical system. Light coming from one point of an object will
% hit many points of the sensor...

% Optical system design:

% Used for focusing system
% for d1=.3:.0015:.5 % Unknown distance from object to lens
%     %d1 = .4;
%     d2 = .8; % lens to sensor
%     f = (d1*d2)/(d1+d2);
% 
%     % Lens transformation
%     Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
% 
%     % Free space transformation between lens and sensor
%     Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];
% 
%     % Transform rays to sensor
%     rays_focused = Md2*Mf*rays;
% 
%     % Plot results
%     img = rays2img(rays_focused(1,:), rays_focused(3,:), .02, 1000);
%     imshow(img)
% end

% Seperate image sources (imagine blocking part of the lens with a card)
castle_rays = rays(:,rays(1,:) > 0.01);
washu_rays  = rays(:,rays(1,:) < -0.01);
comic_rays  = rays(:,rays(1,:) < 0.01 & rays(1,:) > -0.01);

d1 = .4; % Object to lens(m)
d2 = .8; % lens to sensor(m)
f = (d1*d2)/(d1+d2); % Focal length(m)
    
% Lens transformation
Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
    
% Free space transformation between lens and sensor
Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];
    
% Transform rays to sensor
castle_rays_focused = Md2*Mf*castle_rays;
washu_rays_focused = Md2*Mf*washu_rays;
comic_rays_focused = Md2*Mf*comic_rays;

% Plot results
sensor_width = 0.02; % (m)
pixels = 600;

figure
img = rays2img(castle_rays_focused(1,:), castle_rays_focused(3,:), sensor_width, pixels);
imshow(img)
figure
img = rays2img(washu_rays_focused(1,:), washu_rays_focused(3,:), sensor_width, pixels);
imshow(img)
figure
img = rays2img(comic_rays_focused(1,:), comic_rays_focused(3,:), sensor_width, pixels);
imshow(img)
