library(ggplot2)
library(gtable)
library(grid)

grid.newpage()

# first plot
aa <- `2013-05-15-10-30/15`
aa <- data.frame(Vrsta = index(aa), aa[,1:9])
aa$Width <- c(1)
aa$chg <- ifelse(aa$OilClose > aa$OilOpen, "up", "dn")
aa$flat_bar <- aa[, "OilHigh"] == aa[, "OilLow"]


graf <- ggplot(aa, aes(x = aa$Vrsta, alpha = 0.5)) +
  labs(title="Graf") +
  geom_linerange(aes(x = aa$Vrsta, ymin = aa$OilLow, ymax = aa$OilHigh)) + 
  geom_rect(aes(xmin = aa$Vrsta - aa$Width/2 * 0.8,
                xmax = aa$Vrsta + aa$Width/2*0.8,
                ymin = pmin(aa$OilOpen,aa$OilClose),
                ymax = pmax(aa$OilOpen,aa$OilClose),
                fill = aa$chg)) + 
  scale_x_discrete(labels = NULL) + #aa$Date[seq(0,length(aa$Date),5)], breaks = seq(0,length(aa$Date),5)
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  scale_fill_manual(values = c("dn" = "red", "up" = "green"))

# preveri še če je kje obdobje brez spremembe
if (any(aa$flat_bar)) graf <- graf + 
  geom_segment(aes(x = aa$Vrsta - aa$Width / 2 * 0.8,
                   y = aa$OilClose, yend = aa$OilClose,
                   xend = aa$Vrsta + aa$Width / 2 * 0.8))
p1 <- graf
rm(graf,aa)


# second plot
aa <- `2013-05-15-10-30/15`
aa <- data.frame(Vrsta = index(aa), aa[,1:9])
aa$Width <- c(1)
aa$chg <- ifelse(aa$CadClose > aa$CadOpen, "up", "dn")
aa$flat_bar <- aa[, "CadHigh"] == aa[, "CadLow"]


graf <- ggplot(aa, aes(x = aa$Vrsta, alpha=0.5)) +
  labs(title="Graf") +
  geom_linerange(aes(x = aa$Vrsta, ymin = aa$CadLow, ymax = aa$CadHigh)) + 
  geom_rect(aes(xmin = aa$Vrsta - aa$Width/2 * 0.8,
                xmax = aa$Vrsta + aa$Width/2*0.8,
                ymin = pmin(aa$CadOpen,aa$CadClose),
                ymax = pmax(aa$CadOpen,aa$CadClose),
                fill = aa$chg)) + 
  scale_x_discrete(labels = NULL) +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  scale_fill_manual(values = c("dn" = "darkred", "up" = "darkgreen"))

# preveri še če je kje obdobje brez spremembe
if (any(aa$flat_bar)) graf <- graf + 
  geom_segment(aes(x = aa$Vrsta - aa$Width / 2 * 0.8,
                   y = aa$CadClose, yend = aa$CadClose,
                   xend = aa$Vrsta + aa$Width / 2 * 0.8))
p2 <- graf


# two plots
p1 <- p1 + theme_bw()
p2 <- p2 + theme_bw() %+replace% 
  theme(panel.background = element_rect(fill = NA))

# extract gtable
g1 <- ggplot_gtable(ggplot_build(p1))
g2 <- ggplot_gtable(ggplot_build(p2))

# overlap the panel of 2nd plot on that of 1st plot
pp <- c(subset(g1$layout, name == "panel", se = t:r))
g <- gtable_add_grob(g1, g2$grobs[[which(g2$layout$name == "panel")]], pp$t, 
                     pp$l, pp$b, pp$l)

# axis tweaks
ia <- which(g2$layout$name == "axis-l")
ga <- g2$grobs[[ia]]
ax <- ga$children[[2]]
ax$widths <- rev(ax$widths)
ax$grobs <- rev(ax$grobs)
ax$grobs[[1]]$x <- ax$grobs[[1]]$x - unit(1, "npc") + unit(0.15, "cm")
g <- gtable_add_cols(g, g2$widths[g2$layout[ia, ]$l], length(g$widths) - 1)
g <- gtable_add_grob(g, ax, pp$t, length(g$widths) - 1, pp$b) 

# draw it
grid.draw(g)
rm(aa)
