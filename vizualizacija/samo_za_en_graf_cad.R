# pod "aa" shraniš željene podatke za graf
# preoblikoval bom v xts obliko
library(quantmod)
library(ggplot2)

aa <- data.frame(Vrsta = index(aa), aa[,1:9])
aa$Width <- c(1)
aa$chg <- ifelse(aa$CadClose > aa$CadOpen, "up", "dn")
aa$flat_bar <- aa[, "CadHigh"] == aa[, "CadLow"]


graf <- ggplot(aa, aes(x = aa$Vrsta)) +
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
if (any(aa$flat_bar)) graf <- graf + 
  geom_segment(aes(x = aa$Vrsta - aa$Width / 2 * 0.8,
                   y = aa$CadClose, yend = aa$CadClose,
                   xend = aa$Vrsta + aa$Width / 2 * 0.8))
print(graf)




