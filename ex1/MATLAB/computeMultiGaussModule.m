function PX=computeMultiGaussModule(x,u,deltaSquare)

%delta=sqrt(deltaSquare);
deltaAbstract=sum(sum(deltaSquare));
PX=(1/sqrt(2*pi))^3;
PX=PX*(1/deltaAbstract^0.5);
deltaSquareReverse=1./deltaSquare;
[rowD,colD]=size(deltaSquare);
for i=1:colD
	for j=1:colD
		if(i!=j)
			deltaSquareReverse(i,j)=0;
			deltaSquareReverse(i,j)=0;
		end
	end
end

E=exp(-1/2*(x-u)*deltaSquareReverse*(x-u)');
PX=PX*E;