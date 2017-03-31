function p = GMM(x, mean, standard_deviation, a)
  
  p = 0.0;
  k = size(mean, 1);
  for i=1:k
    p = p + a .* computeSingleGaussModule(x(:i), mean(:i), standard_deviation(:i) * standard_deviation(:i));
  endfor

  