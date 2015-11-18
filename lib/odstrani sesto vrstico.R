odstrani.6.vrstico <- function(a) 
{
  OK.stolpci <- apply(a,2,function(x){!any(is.na(x))})
  a <- a[,OK.stolpci]
  #preimenuje in odstrani 6 vrstico
  attach(a)
  a <- data.frame(Date=V1, Open=V2, Close=V3, High=V4, Low=V5)
  detach(a)
  return(a)
}
