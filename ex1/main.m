fprintf("Before running the code, please read the README.md file.\n");

pkg install image-2.6.1.tar.gz;
pkg load image;

fprintf("The image pkg is installed. \n");

fprintf("Ready to run, press enter to continue.\n");
pause;
fprintf("Now running the GRAY image classfication.\n");

tyc;

fprintf("Then algorithm is finished, please check the image and data\n");

fprintf("Ready to run, press enter to continue.\n");
pause;
fprintf("Now running the RGB image classfication.\n");

tyc2;


fprintf("Then algorithm is finished, please check the image and data\n");

fprintf("Ready to run, press enter to continue.\n");
pause;
fprintf("Now running the EM with gray image.\nIteration is 30 epochs.\n");

EM;


fprintf("Then algorithm is finished, please check the image and data\n");
