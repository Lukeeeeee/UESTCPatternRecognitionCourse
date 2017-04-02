function PX=computeSingleGaussModule(x,u,deltaSquare)

delta=sqrt(deltaSquare);
PX=1/sqrt(2*pi*delta)*exp(-(x-u)^2/deltaSquare);