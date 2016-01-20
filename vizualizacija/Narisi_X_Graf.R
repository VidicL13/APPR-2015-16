library(quantmod)
Narisi_X_Graf_oil <- function(aa){
  aa <<- data.frame(Vrsta = index(aa), aa[,1:9])
  aa$Width <<- c(1)
  aa$chg <<- ifelse(aa$OilClose > aa$OilOpen, "up", "dn")
  aa$flat_bar <<- aa[, "OilHigh"] == aa[, "OilLow"]
  
  
  graf <<- ggplot(aa, aes(x = aa$Vrsta)) +
    labs(title="Graf") +
    geom_linerange(aes(x = aa$Vrsta, ymin = aa$OilLow, ymax = aa$OilHigh)) + 
    geom_rect(aes(xmin = aa$Vrsta - aa$Width/2 * 0.8,
                  xmax = aa$Vrsta + aa$Width/2*0.8,
                  ymin = pmin(aa$OilOpen,aa$OilClose),
                  ymax = pmax(aa$OilOpen,aa$OilClose),
                  fill = aa$chg)) + 
    scale_x_discrete(labels = aa$Date[seq(0,length(aa$Date),5)], breaks = seq(0,length(aa$Date),5)) +
    theme(axis.text.x = element_text(angle=45, hjust=1)) +
    scale_fill_manual(values = c("dn" = "darkred", "up" = "darkgreen"))
  
  # preveri še če je kje obdobje brez spremembe
  if (any(aa$flat_bar)) {graf <<- graf + 
    geom_segment(aes(x = aa$Vrsta - aa$Width / 2 * 0.8,
                     y = aa$OilClose, yend = aa$OilClose,
                     xend = aa$Vrsta + aa$Width / 2 * 0.8))}
  return(graf)
  
}

Narisi_X_Graf_cad <- function(aa){
  aa <<- data.frame(Vrsta = index(aa), aa[,1:9])
  aa$Width <<- c(1)
  aa$chg <<- ifelse(aa$CadClose > aa$CadOpen, "up", "dn")
  aa$flat_bar <<- aa[, "CadHigh"] == aa[, "CadLow"]
  
  graf <<- ggplot(aa, aes(x = aa$Vrsta)) +
    labs(title="Graf") +
    geom_linerange(aes(x = aa$Vrsta, ymin = aa$CadLow, ymax = aa$CadHigh)) + 
    geom_rect(aes(xmin = aa$Vrsta - aa$Width/2 * 0.8,
                  xmax = aa$Vrsta + aa$Width/2*0.8,
                  ymin = pmin(aa$CadOpen,aa$CadClose),
                  ymax = pmax(aa$CadOpen,aa$CadClose),
                  fill = aa$chg)) + 
    scale_x_discrete(labels = aa$Date[seq(0,length(aa$Date),5)], breaks = seq(0,length(aa$Date),5)) +
    theme(axis.text.x = element_text(angle=45, hjust=1)) +
    scale_fill_manual(values = c("dn" = "darkred", "up" = "darkgreen"))
  # preveri še če je kje obdobje brez spremembe
  if (any(aa$flat_bar)) graf <<- graf + 
    geom_segment(aes(x = aa$Vrsta - aa$Width / 2 * 0.8,
                     y = aa$CadClose, yend = aa$CadClose,
                     xend = aa$Vrsta + aa$Width / 2 * 0.8))
  return(graf)
  
}
Narisi_X_Graf_oba <- function(aa){
  graf1 <<- Narisi_X_Graf_cad(aa)
  graf2 <<- Narisi_X_Graf_oil(aa)
  grid.arrange(graf2, graf1, main = "GRAF", ncol = 2)
}