# preoblikoval bom v xts obliko

aa <- data.frame(Date = index(aa), aa[,2:5])
aa$Width <- c(1)
aa$chg <- ifelse(aa$Close > aa$Open, "up", "dn")
aa$flat_bar <- aa[, "High"] == aa[, "Low"]


graf <- ggplot(aa, aes(x = aa$Date, alpha = 0.7)) +
  geom_linerange(aes(x = aa$Date, ymin = aa$Low, ymax = aa$High)) + 
  geom_rect(aes(xmin = aa$Date - aa$Width/2 * 0.8, xmax = aa$Date + aa$Width/2*0.8,
                ymin = pmin(aa$Open,aa$Close), ymax = pmax(aa$Open,aa$Close), fill = aa$chg)) + 
  scale_fill_manual(values = c("dn" = "darkred", "up" = "darkgreen"))

# preveri še če je kje obdobje brez spremembe
if (any(aa$flat_bar)) graf <- graf + geom_segment(aes(x = aa$Date - aa$Width / 2 * 0.8, y = aa$Close, yend = aa$Close, xend = aa$Date + aa$Width / 2 * 0.8))

