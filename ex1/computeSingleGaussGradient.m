function [mean_new, standard_deviation_new] = computeSingleGaussGradient(X, label, y, mean, standard_deviation)
  
  like_mean = 0.0;
  like_standard_deviation = 0.0;
  m = size(label);
  count = 0;
  for i=1:m
    x = X(i, 1);
    if(y==label(i))
      like_mean += x;
      count ++;
     end
  endfor
  if (count == 0)
    mean_new = mean;
    standard_deviation_new = standard_deviation;
  else
    like_mean = like_mean / count;
    for i=1:m
      x = X(i, 1);
      if(y==label(i))
        like_standard_deviation += (x - like_mean) * (x - like_mean);
       end
     endfor
    like_standard_deviation /= count;
    mean_new = like_mean;
    standard_deviation_new = like_standard_deviation;
    end