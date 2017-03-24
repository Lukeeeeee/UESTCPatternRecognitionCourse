function [mean_new, standard_deviation_new] = computeSingleGaussGradient(X, y, label, mean, standard_deviation)
  
  like_mean = 0.0;
  like_standard_deviation = 0.0;
  m = size(label);
  count = 0;
  for i=1:m
    x = X(i, 1);
    if(y==label)
      like_mean += x;
      count ++;
     end
  endfor
  mean = mean / count;
  for i=1:m
    x = X(i, 1);
    like_standard_deviation += (x - mean) * (x - mean);
   endfor
  like_standard_deviation /= count;
  
  mean_new = like_mean;
  standard_deviation_new = like_standard_deviation
