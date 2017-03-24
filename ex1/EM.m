clear;
clc;

fprintf('opening file Mask.mat \n\n');

% Load an example dataset that we will be using
load('Mask.mat');

fprintf('opening file array_sample.mat \n\n');
load('array_sample.mat')

[m,n]=size(Mask) %get colums and rows

img=imread('309.bmp');

img=img.*Mask;
[a,b,c]=size(img)
%show original img
subplot(1, 2, 1);
imagesc(img); 
title('Original');
gray=rgb2gray(img);

[m2,n2]=size(array_sample)
graySample=zeros(m2,2);
graySample(:,1)=array_sample(:,1);
graySample(:,2)=array_sample(:,5);


% EM algorithm

mean1 = rand();
standard_deviation1 = rand();

mean2 = rand();
standard_deviation2 = rand();

label = zeros(size(array_sample, 1));
i = 0;
while(i<=10000)
  % predict
  if (mod(i, 100) == 0)
    fprintf('runing epoch = i\n');
   end
  for i=1:m2
    x=graySample(i,1);
    px1=computeSingleGaussModule(x, label, 1, mean1, standard_deviation1 * standard_deviation1);
    px2=computeSingleGaussModule(x, label, -1, mean2, standard_deviation2 * standard_deviation2);
    if (px1 > px2)
      label(i) = 1;
     else
      label(i) = -1;
     end
    [mean1, standard_deviation1] = computeSingleGaussGradient(graySample, label, +1, mean1, standard_deviation1);
    [mean2, standard_deviation2] = computeSingleGaussGradient(graySample, label, -1, mean2, standard_deviation2);
    i++;
  endfor
end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  