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
img = rays2img(rays(1,:), rays(3,:), .02, 500);
imshow(img);

% Question 2:
% We have no optical system. Light coming from one point of an object will
% hit many points of the sensor...

d2 = 1;
Md2 = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];



