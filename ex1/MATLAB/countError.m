function error = countError(px1, px2, graySample)
error = 0;
if (px1>px2)
  if (graySample==-1)
    error = 1;
    end
  else
   if (graySample==+1)
    error =1;
    end
end