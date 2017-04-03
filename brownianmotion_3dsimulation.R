library("plotrix")
N=10000; R=(11.4+5)/10;accept=0;vals=rep(1,N); accept2=0;p=0;vals2=rep(1,N); success=0;error=0;j=0
thetao=0;xo=-.2;yo=-.2; #starting position
theta2o=0;x2o=.2;y2o=.2; #starting position of 2nd particle
xdis = rnorm(N,0,.01); ydis = rnorm(N,0,.01);  theta=rnorm(N,0,2*pi); #randomly move from Nor
xdis2 = rnorm(N,0,.01); ydis2 = rnorm(N,0,.01);  theta2=rnorm(N,0,2*pi);
xdis1 = rep(1,N); ydis1 = rep (1,N);theta1=rep(1,N); #displacement vectors
xdis21 = rep(1,N); ydis21 = rep (1,N);theta21=rep(1,N);
xdis1[1] = xo; ydis1[1] = yo;theta1[1]=thetao;# displacement
xdis21[1] = x2o; ydis21[1] = y2o;theta21[1]=theta2o;
for(i in 1:(N-1)){
  ### Limit Theta 0<T<360 ###
  if (theta1[i]+theta[i+1]>360){
    theta1[i+1]=360;
  }
  else if (theta1[i]+theta[i+1]<(-360)){
    theta1[i+1]=-360;
  }
  else {
    theta1[i+1]=theta1[i]+theta[i];
  }
  if (theta21[i]+theta2[i+1]>360){
    theta21[i+1]=360;
  }
  else if (theta21[i]+theta2[i+1]<(-360)){
    theta21[i+1]=-360;
  }
  else {
    theta21[i+1]=theta21[i]+theta2[i];
  }
  if(abs(xdis1[i]+xdis[i])^2*cos(theta1[i+1])^2+abs(ydis1[i]+ydis[i])^2*sin(theta1[i+1])^2 > R^2){ #xdis1[i] + xdis[i+1] > ub(theta1[i+1])){
    accept=accept+1;
    vals[i]=abs(xdis1[i]+xdis[i])^2*cos(theta1[i+1])^2+abs(ydis1[i]+ydis[i])^2*sin(theta1[i+1])^2
    i=i-1
  }
  else {
    xdis1[i+1] = xdis1[i] + xdis[i];
    ydis1[i+1] = ydis1[i] + ydis[i];
  }
  #### SECOND PARTICLE ####
  if(abs(xdis21[i]+xdis2[i])^2*cos(theta21[i+1])^2+abs(ydis21[i]+ydis2[i])^2*sin(theta21[i+1])^2 > R^2){ 
    accept2=accept2+1;
    vals2[i]=abs(xdis21[i]+xdis2[i])^2+abs(ydis21[i]+ydis2[i])^2
    i=i-1
    return
  }
  else {
    xdis21[i+1] = xdis21[i] + xdis2[i];
    ydis21[i+1] = ydis21[i] + ydis2[i];
  }
  #### COMPARE PARTICLES ###
  #position of the particle : (xdis1[i+1],ydis1[i+1])
  #size of particle: r = .5; diameter = 1
  #compare centers: centers cant be closer than 1 apart 
  #(x,y) + (x,y) >= 1
  c1=c(xdis1[i+1],ydis1[i+1]);c2=c(xdis21[i+1],ydis21[i+1]); #position of centers
  dist=c(abs(c1[1]-c2[1]),abs(c1[2]-c2[2]));
  if ((dist[1]>.9 && dist[1]<1.1) | (dist[2]>.9 && dist[2]<1.1)){ #contact
    error=error+1;
    r=runif(1,0,1);
    if (r<=0.25){
      success=success+1;
    }
  }
  else if (dist[1]<.9 | dist[2]<.9){
    i=i-1
  }
  j=j+1
}
#success ratio
success/error
success
plot(xdis1, ydis1, ylim=c(-(R+2),R+2),xlim=c(-(R+2),R+2),type="l",main="Brownian Motion of two particles of radius .45 in a sphere")#, xlab="displacement",ylab="time")
lines(xdis21, ydis21, col='blue',type="l")
draw.circle(0,0,R)
