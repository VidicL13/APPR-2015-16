tab <- tabela2
tab1 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "time" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab2 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "time" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab3 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "time" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab4 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "time" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
for (i in 1:floor(length(tab[,1])/4)){
  z <- 4*(i-1)+1
  tab1[i,] <- tab[z,]
  tab2[i,] <- tab[z+1,]
  tab3[i,] <- tab[z+2,]
  tab4[i,] <- tab[z+3,]
}