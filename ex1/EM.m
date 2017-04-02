
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
[a,b,c]=size(img);
subplot(1, 2, 1);
imagesc(img); 
title('Original');
gray=rgb2gray(img);

[m2,n2]=size(array_sample);


% EM algorithm
% initial parameters

mean1 = 0.4;
standard_deviation1 = 0.10;
a1 = rand();

mean2 = 0.7;
standard_deviation2 = 0.15;
a2 = 1 - a1;

step = 30;


label = zeros(size(array_sample), 1);
i = 0;
fflush(stdout);

while(i<=step)
  % predict
  printf("running EM step %d\n", i);
  if (mod(i, 1) == 0)
      countSampleError=0;
      for j=1:m2
        x=array_sample(j,1:1); % get the gra from traning set
        px1= a1 * computeSingleGaussModule(x, mean1, standard_deviation1 * standard_deviation1);
        px2= a2 * computeSingleGaussModule(x, mean2, standard_deviation2 * standard_deviation2);
        p1 = px1 / (a1 * px1 + a2 * px2);
        p2 = px2 / (a1 * px1 + a2 * px2); 
        countSampleError += countError(p1, p2, array_sample(j,5));
       endfor
      fprintf("Error num = %d\n", countSampleError);
      fflush(stdout);
  end
  % EM 
  %% E step

  p = zeros(m2, 2);
  for j=1:m2
    x=array_sample(j, 1:1);
    px1 = computeSingleGaussModule(x, mean1, standard_deviation1 * standard_deviation1);
    px2 = computeSingleGaussModule(x, mean2, standard_deviation2 * standard_deviation2);
    p(j, 1) = px1 / (a1 * px1 + a2 * px2);
    p(j, 2) = px2 / (a1 * px1 + a2 * px2); 
  endfor
  
  %% M step

  mean1_ = 0.0;
  mean2_ = 0.0;

  standard_deviation1_ = 0.0;
  standard_deviation2_ = 0.0;
  a1_ = 0.0;
  a2_ = 0.0;

  sum_1 = 0.0;
  sum_2 = 0.0;

  for j  = 1:m2
    sum_1 += p(j, 1);
    sum_2 += p(j, 2);
    a1_ += p(j, 1) / m2;
    a2_ += p(j, 2) / m2;
  endfor
  for j = 1:m2
    mean1_ += p(j, 1) * array_sample(j, 1:1);
    mean2_ += p(j, 2) * array_sample(j, 1:1);
  endfor
  mean1_ = mean1_ / sum_1;
  mean2_ = mean2_ / sum_2;

  for j = 1:m2
    standard_deviation1_ += p(j, 1) * (array_sample(j, 1:1) - mean1_) * (array_sample(j, 1:1) - mean1_);
    standard_deviation2_ += p(j, 2) * (array_sample(j, 1:1) - mean2_) * (array_sample(j, 1:1) - mean2_);
  endfor
  standard_deviation1_ /= sum_1;
  standard_deviation2_ /= sum_2;
  standard_deviation1_ = sqrt(standard_deviation1_);
  standard_deviation2_ = sqrt(standard_deviation2_);

  a1 = a1_;
  a2 = a2_;
  mean1 = mean1_;
  mean2 = mean2_;
  standard_deviation1 = standard_deviation1_;
  standard_deviation2 = standard_deviation2_;

  i++;
endwhile


R=img(:,:,1); %red  
G=img(:,:,2); %green  
B=img(:,:,3); %blue  

tmpPixel=0;
for i=1:a

	for j=1:b
		tmpPixel=double(gray(i,j));

		if (tmpPixel!=0)
			tmpPixel=double(tmpPixel)/255.0;
			px1= computeSingleGaussModule(tmpPixel, mean1, standard_deviation1 * standard_deviation1);
			px2= computeSingleGaussModule(tmpPixel, mean2, standard_deviation2 * standard_deviation2);
            p1 = px1 / (a1 * px1 + a2 * px2);
            p2 = px2 / (a1 * px1 + a2 * px2); 
			if (p1>p2)
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
 

  