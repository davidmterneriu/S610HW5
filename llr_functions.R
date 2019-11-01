#llr_functions.R
llr = function(x, y, z, omega) {
  fits = sapply(z, compute_f_hat, x, y, omega)
  return(fits)
}
compute_f_hat = function(z, x, y, omega) {
  #browser()
  Wz = make_weight_matrix(z, x, omega)
  X = make_predictor_matrix(x)
  #version1
  #f_hat = c(1, z) %*% solve(t(X) %*% Wz %*% X) %*% t(X) %*% Wz %*% y
  #verison2.1
  #f_hat = c(1, z) %*% solve(t(X) %*% apply(X,2,function(x)(x*Wz))) %*% t(X) %*%(Wz*y)
  #version2.2
  #f_hat = c(1, z) %*% solve(t(X) %*% apply(X,2,function(x)(x*Wz))) %*% t(X) %*%mapply(FUN="*",y,Wz)
  #version3.1
  f_hat = c(1, z) %*% solve(t(X) %*% sweep(X,1,Wz,"*",check.margin=FALSE)) %*% t(X) %*%(Wz*y)
  return(f_hat)
}
make_weight_matrix=function(z, x, omega){
  n=length(x)
  r=abs(x-z)/omega
  #Wz=diag(ifelse(abs(r)<1,(1-abs(r)^3)^3,0),n,n)
  Wz=ifelse(abs(r)<1,(1-abs(r)^3)^3,0)
  return(Wz)
}
make_predictor_matrix=function(x){
  X=cbind(1,x)
  return(X)
}

#Writing this line after the first commit. I had tried out speeding up my code before using github/git.


