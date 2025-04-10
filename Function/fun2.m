function flag=fun2(region)
sd=std2(region);
m=mean2(region);
flag = (sd > 5) & (m > 0) & (m < 125);





