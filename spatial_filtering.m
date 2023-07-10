%%  Performance of spatial filtering operations and contrast stretching

clc;         %clear command window
clear;    %clear workspace
close;     %clear current folder

% Reading the x-ray image
original_im = imread('xray1.jpg');    %reading image from folder
im = rgb2gray(original_im);     %RGB to gray
im = imresize(im,[500 500]);    %resizing image
figure(1);
subplot(2,2,1),imshow(im);    %subplot:multiple images in 1 window, display result
title('Original X-Ray Image');    %title to image


% Adding noise to the image
im_gaussian_noise = imnoise(im,'gaussian');     %adding gaussian noise to image
subplot(2,2,2),imshow(im_gaussian_noise);
title('X-Ray Image with Gaussian noise');
im_salt_pepper = imnoise(im,'salt & pepper');     %adding salt and pepper noise
subplot(2,2,[3 4]),imshow(im_salt_pepper);
title('X-Ray Image with salt & pepper noise');

%Removing noise using spatial filters (median ,high,low)
%operation performed on salt and pepper noise
c = medfilt2(im_salt_pepper,[3 3]);        % appling median filter
h = ones(5,5)/25; % averaing filter acts like an low pass, mask of 5X5 on image to filter image
b = imfilter(im_salt_pepper,h);     %appling filter
h1 = fspecial('unsharp'); % high pass filter
d = imfilter(im_salt_pepper,h1);
figure(), subplot(2,2,1);
imshow(im_salt_pepper), title('Salt and pepper Input Image');
subplot(2,2,2),imshow(c),title('Median Filtered Image');
subplot(2,2,3),imshow(b),title('Low Pass Filtered Image');
subplot(2,2,4),imshow(d),title('High pass filtered');


% Performing enhancement using contrast stretching
val = double(c);
contra1 = val+25;
figure();
subplot(1,2,1), imshow(c),title('Original Image(salt and pepper noise)');
subplot(1,2,2), imshow(uint8(contra1)),title('Contrast stretching');



%operation performed on gaussian noise
%Removing noise using spatial filters (median ,high,low)
c1=medfilt2(im_gaussian_noise,[3 3]);
h2=ones(5,5)/25;
b1=imfilter(im_gaussian_noise,h2);
h3=fspecial('unsharp');
d1=imfilter(im_gaussian_noise,h1);
figure()
subplot(2,2,1), imshow(im_gaussian_noise);title('Gaussian input image ');
subplot(2,2,2),imshow(c1);title('median filter');
subplot(2,2,3),imshow(b1);title('low pass filter');
subplot(2,2,4),imshow(d1);title('high pass filter');

% Performing enhancement using contrast stretching
val=double(c);
contra1=val+25;
figure()
subplot(1,2,1), imshow(c),title('Original Image(gaussian noise)');
subplot(1,2,2), imshow(uint8(contra1)),title('Contrast stretching');
