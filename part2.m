% Close any old plots
close all

% Load data (part a)
load("lightField.mat")

% Configuration
title_size = 18;
label_size = 16;

% ----------Part 2----------

% -----Vary sensor width (part b)-----

% Animation form
% for w=0:.001:.1
%     img = rays2img(rays(1,:), rays(3,:), w, 200);
%     imshow(img);
% end

% 4 figures form
imgw1 = rays2img(rays(1,:), rays(3,:), 0.01, 200);
imgw2 = rays2img(rays(1,:), rays(3,:), 0.02, 200);
imgw3 = rays2img(rays(1,:), rays(3,:), .05, 200);
imgw4 = rays2img(rays(1,:), rays(3,:), .1, 200);

%Plots
figure
subplot(2,2,1), imshow(imgw1);
title("Sensor Width: 0.01","FontSize",label_size)
subplot(2,2,2), imshow(imgw2);
title("Sensor Width: 0.02","FontSize",label_size)
subplot(2,2,3), imshow(imgw3);
title("Sensor Width: 0.05","FontSize",label_size)
subplot(2,2,4), imshow(imgw4);
title("Sensor Width: 0.1","FontSize",label_size)

% -----Vary pixel count (part c)-----

% Animation form
% figure;
% for p=50:1000
%     img = rays2img(rays(1,:), rays(3,:), .01, p);
%     imshow(img);
% end

% 4 figures form
imgp1 = rays2img(rays(1,:), rays(3,:), .01, 10);
imgp2 = rays2img(rays(1,:), rays(3,:), .01, 50);
imgp3 = rays2img(rays(1,:), rays(3,:), .01, 100);
imgp4 = rays2img(rays(1,:), rays(3,:), .01, 500);

%Plots
figure
subplot(2,2,1), imshow(imgp1);
title("Pixels: 10","FontSize",label_size)
subplot(2,2,2), imshow(imgp2);
title("Pixels: 50","FontSize",label_size)
subplot(2,2,3), imshow(imgp3);
title("Pixels: 100","FontSize",label_size)
subplot(2,2,4), imshow(imgp4);
title("Pixels: 500","FontSize",label_size)

% -----Vary distance (part d)-----

% Animation form
% for d = 0:.1:10
%     Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
%     rays2 = Md*rays;
%     img = rays2img(rays2(1,:), rays2(3,:), .01, 500);
%     imshow(img);
% end

% 4 figures form
figure
tiledlayout(2,2)
i=1;
for d = [0 .1 1 10]
    Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
    rays2 = Md*rays; % Free space propagation
    img = rays2img(rays2(1,:), rays2(3,:), .01, 500); % Capture image
    subplot(2,2,i), imshow(img); %Plot
    title("Distance: " + d, "FontSize",label_size) %Label
    i = i+1;
end

% Plot best image so far
d = 0.001;
Md = [1 d 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
rays2 = Md*rays;

figure
img = rays2img(rays2(1,:), rays2(3,:), .02, 500);
imshow(img);
title( "Raw Light Field", "FontSize", title_size)

% Optical system design:

% Used for focusing system (finding d1) Animation form
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

% 4 Figures form
figure
i = 1;
for d1 = [.35, .38, .4, .42]
    d2 = 1; % lens to sensor
    f = (d1*d2)/(d1+d2);
    
    % Lens transformation
    Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];

    % Free space transformation between lens and sensor
    Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];

    % Transform rays to sensor
    rays_focused = Md2*Mf*rays;

    % Plot results
    img = rays2img(rays_focused(1,:), rays_focused(3,:), .02, 1000);
    subplot(2,2,i), imshow(img);
    title("Focus Distance: " + d1 + "m", "FontSize",label_size);
    i = i+1;
end


% ----------Part 3----------
% Seperate image sources (imagine blocking part of the lens with a card)
rays_lower_quarter = min(rays(1,:)) + range(rays(1,:))/3;
rays_upper_quarter = min(rays(1,:)) + range(rays(1,:))*2/3;

right_rays = rays(:,rays(1,:) > rays_upper_quarter);
left_rays  = rays(:,rays(1,:) < rays_lower_quarter);
center_rays  = rays(:,rays(1,:) < rays_upper_quarter & rays(1,:) > rays_lower_quarter);

d1 = 0.4; % Object to lens(m) - Focusing distance of lens
d2 = 1.5; % lens to sensor(m) - Controls field of view, larger values lead to larger images of objects
f  = (d1*d2)/(d1+d2); % Focal length(m)
    
% Lens transformation
Mf = [1 0 0 0; -1/f 1 0 0; 0 0 1 0; 0 0 -1/f 1];
    
% Free space transformation between lens and sensor
Md2 = [1 d2 0 0; 0 1 0 0; 0 0 1 d2; 0 0 0 1];
    
% Transform rays to sensor
right_rays_focused = Md2*Mf*right_rays;
left_rays_focused  = Md2*Mf*left_rays;
center_rays_focused  = Md2*Mf*center_rays;

% Camera Parameters
sensor_width = 0.02; % (m)
pixels = 500;

% Display results
displayImage(right_rays_focused, sensor_width, pixels, "Right Image", title_size);
displayImage(left_rays_focused, sensor_width, pixels, "Left Image", title_size);
displayImage(center_rays_focused, sensor_width, pixels, "Center Image", title_size);

% Note: Source of center image: https://www.instagram.com/p/CxbBBNBy1FP/
% AI generated image by DALLE3, "An illustration of an avocado sitting in a therapist's chair, saying 
% 'I just feel so empty inside' with a pit-sized hole in its center. The therapist, a spoon, scribbles 
% notes."
% Probable source of left image: https://marcomm.wustl.edu/resources/branding-logo-toolkit/download-logos/
% WashU athletics logo
% Source of right image: https://marcomm.wustl.edu/resources/branding-logo-toolkit/icon-library/
% Washu marketing icon library, Brookings


function displayImage(focused_rays, sensor_width, pixels, title_text, title_size)
% displayImage - Displays an image from a focused light field. See rays2img
% for details on how the camera sensor is simulated.
% 
% inputs:
% focused_rays: A 4 x N matrix with each column as one light ray. The first
% row is the x position of each ray, the next the x angle, then the y
% position, and finally the y angle.
% pixels: A scalar that specifies the number of pixels along one side of
% the square image sensor.
% title_text: A string to be displayed as the title of the image figure.
% title_size: A scalar size for the size of the title font text.

    figure
    % Create an image from the rays
    img = rays2img(focused_rays(1,:), focused_rays(3,:), sensor_width, pixels);

    % Flip the image horizontally
    img = flip(img, 2);

    imshow(img)
    title(title_text, "FontSize", title_size)
end

