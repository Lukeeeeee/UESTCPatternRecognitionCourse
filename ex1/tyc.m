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
%show original img
subplot(1, 2, 1);
imagesc(img); 
title('Original');
gray=rgb2gray(img);
%subplot(1, 2, 2);
%imagesc(gray); 
%title('Gray');


%gray=double(gray)/255.0;



%try to get module
[m2,n2]=size(array_sample);
graySample=zeros(m2,2);
graySample(:,1)=array_sample(:,1);
graySample(:,2)=array_sample(:,5);

%try to get module as nomal Bayesian Distrubution
num1=0;
u1=0;
u2=0;
num2=0;
deltaSquare1=0;
deltaSquare2=0;
for i=1:m2
	if(graySample(i,2)==1)
		u1=u1+graySample(i,1);
		
		num1++;
	else
		u2=u2+graySample(i,1);
		num2++;
	end
end
fprintf('get mean: \n');
u1=u1/num1
u2=u2/num2
for i=1:m2
	if(graySample(i,2)==1)
		deltaSquare1=deltaSquare1+(graySample(i,1)-u1)^2;
	else
		deltaSquare2=deltaSquare2+(graySample(i,1)-u2)^2;
	end
end

fprintf('get deltaSquare: \n');
deltaSquare1=deltaSquare1/num1
deltaSquare2=deltaSquare2/num2

fprintf('test module \n');%module is computeSingleGaussModule in tycfunctions
countSampleError=0;
for i=1:m2
	x=graySample(i,1);
	px1=computeSingleGaussModule(x,u1,deltaSquare1);
	px2=computeSingleGaussModule(x,u2,deltaSquare2);
	if (px1>px2)
		if (graySample(i,2)==1)
		else
			%printf('error \n');
			countSampleError++;
		end
	else
		if (graySample(i,2)==-1)
		else
			%printf('error \n');
			countSampleError++;
		end
	end
end
countSampleError

R=img(:,:,1); %red  
G=img(:,:,2); %green  
B=img(:,:,3); %blue  

tmpPixel=0;
for i=1:a

	for j=1:b
		tmpPixel=double(gray(i,j));

		if (tmpPixel!=0)
			tmpPixel=double(tmpPixel)/255.0;
			px1=computeSingleGaussModule(tmpPixel,u1,deltaSquare1);
			px2=computeSingleGaussModule(tmpPixel,u2,deltaSquare2);
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