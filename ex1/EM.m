pkg load image;

clear;
clc;

fprintf('opening file Mask.mat \n\n');

% Load an example dataset that we will be using
load('Mask.mat');

fprintf('opening file array_sample.mat \n\n');
load('array_sample.mat')

[m,n]=size(Mask)%get colums and rows

img=imread('309.bmp');


img=img.*Mask;
[a,b,c]=size(img)
%show original img
subplot(1, 2, 1);
imagesc(img); 
title('Original');
gray=rgb2gray(img);
%subplot(1, 2, 2);
%imagesc(gray); 
%title('Gray');


%gray=double(gray)/255.0;

[m2,n2]=size(array_sample)
graySample=zeros(m2,2);
graySample(:,1)=array_sample(:,1);
graySample(:,2)=array_sample(:,5);

% EM algorithm
mean1 = rand();
standard_deviation1 = rand();
a1 = 0.5;


mean2 = rand();
standard_deviation2 = rand();
a2 = 0.5;


label = zeros(size(array_sample), 1);
i = 0;
fflush(stdout);

while(i<=50)
  % predict
  if (mod(i, 5) == 0)
      fprintf('runing epoch = %d\n', i);
      countSampleError=0;
      for j=1:m2
        x=graySample(j,1);
        px1=computeSingleGaussModule(x,mean1,standard_deviation1 * standard_deviation1);
        px2=computeSingleGaussModule(x,mean2,standard_deviation2 * standard_deviation2);
        countSampleError += countError(px1, px2, graySample(j,2));
       endfor
      fprintf("Error num = %d\n", countSampleError);
      fflush(stdout);
  end
  for j=1:m2
    x=graySample(j,1);
    px1=computeSingleGaussModule(x, mean1, standard_deviation1 * standard_deviation1);
    px2=computeSingleGaussModule(x, mean2, standard_deviation2 * standard_deviation2);
    if (px1 > px2)
      label(j) = 1;
     else
      label(j) = -1;
     end
   endfor
   
  [mean1, standard_deviation1] = computeSingleGaussGradient(graySample, label, +1, mean1, standard_deviation1);
  [mean2, standard_deviation2] = computeSingleGaussGradient(graySample, label, -1, mean2, standard_deviation2);
  i++;
end


R=img(:,:,1); %red  
G=img(:,:,2); %green  
B=img(:,:,3); %blue  

tmpPixel=0;
for i=1:a

	for j=1:b
		tmpPixel=double(gray(i,j));

		if (tmpPixel!=0)
			tmpPixel=double(tmpPixel)/255.0;
			px1=computeSingleGaussModule(tmpPixel, mean1, standard_deviation1 * standard_deviation1);
			px2=computeSingleGaussModule(tmpPixel, mean2, standard_deviation2 * standard_deviation2);
			if (px1>px2)
				R(i,j) = 255;  
            	G(i,j) = 0;  
            	B(i,j) = 0; 
			else
				R(i,j) = 255;  
            	G(i,j) = 255;  
            	B(i,j) = 0; 
			end
		end
	end
end
resultRGB(:,:,1)=R(:,:);  
resultRGB(:,:,2)=G(:,:);  
resultRGB(:,:,3)=B(:,:);  

subplot(1, 2, 2);
imagesc(resultRGB); 
title('resultRGB');
  
  