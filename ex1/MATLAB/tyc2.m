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
%test=array_sample(1,1:5-1)

%return



%try to get module
[m2,n2]=size(array_sample)


%try to get module as Multi Bayesian Distrubution
fprintf('get mean: \n');
num1=0;
num2=0;
u1=zeros(1,n2-2);%r,g,b
u2=zeros(1,n2-2);
for i=1:m2
	if(array_sample(i,5)==1)
		num1++;
		u1=u1+array_sample(i,2:n2-1);
	else
		u2=u2+array_sample(i,2:n2-1);
		num2++;
	end
end


u1=u1/num1
u2=u2/num2
deltaSquare1=zeros(n2-2,n2-2);%协方差矩阵

deltaSquare2=zeros(n2-2,n2-2);
for i=1:m2
	if(array_sample(i,n2)==1)
		tmpArrow=(array_sample(i,2:n2-1)-u1);
		tmpDelta=tmpArrow'*tmpArrow;
		deltaSquare1=deltaSquare1+tmpDelta;
	else
		tmpArrow=(array_sample(i,2:n2-1)-u2);
		tmpDelta=tmpArrow'*tmpArrow;
		deltaSquare2=deltaSquare2+tmpDelta;
	end

end


fprintf('get deltaSquare: \n');
deltaSquare1=deltaSquare1/num1;
deltaSquare2=deltaSquare2/num2;
for i=1:n2-2
	for j=1:n2-2
		if(i!=j)
			deltaSquare1(i,j)=0;
			deltaSquare2(i,j)=0;
		end
	end
end
deltaSquare1;
deltaSquare2;


fprintf('test module \n');%module is computeMultiGaussModule in tycfunctions 多变量正态分布
countSampleError=0;
for i=1:m2
	x=array_sample(i,2:n2-1);
	px1=computeMultiGaussModule(x,u1,deltaSquare1);
	px2=computeMultiGaussModule(x,u2,deltaSquare2);
	if (px1>px2)
		if (array_sample(i,5)==1)

		else
			%printf('error \n');
			countSampleError++;
		end
	else
		if (array_sample(i,5)==-1)

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
[imgRm,imgRn]=size(R)
tmpPixel=zeros(1,3);
px1=0;
px2=0;
for i=1:a

	for j=1:b
		tmpPixel(1,2)=R(i,j);
		tmpPixel(1,2)=G(i,j);
		tmpPixel(1,3)=B(i,j);

		if (sum(tmpPixel)>0)
			%tmpPixel;
			tmpPixel=double(tmpPixel)/255.0;
			px1=computeMultiGaussModule(tmpPixel,u1,deltaSquare1);
			px2=computeMultiGaussModule(tmpPixel,u2,deltaSquare2);
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