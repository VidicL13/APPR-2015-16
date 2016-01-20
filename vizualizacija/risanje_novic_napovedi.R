diference <- data.frame(Date = DistillateInventories$date,
                        DistillateInventories = DistillateInventories$difference, 
                        CrudeOilInventories = CrudeOilInventories$difference,
                        GasolineInventories = GasolineInventories$difference,
                        RefineryUtilization = RefineryUtilization$difference)
plot1 <- ggplot(diference, aes(x = reorder(Date, DistillateInventories), y = DistillateInventories)) +
  geom_bar(stat = "identity", aes(colour = DistillateInventories)) +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), panel.background = element_rect(fill = "gray")) + 
  scale_x_discrete(name="") +
  scale_y_continuous(name="Difference in Distillate Inventories")

plot2 <- ggplot(diference, aes(x = reorder(Date, CrudeOilInventories), y = CrudeOilInventories)) +
  geom_bar(stat = "identity", aes(colour = CrudeOilInventories)) +
  scale_colour_gradient(low = "white", high = "black") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), panel.background = element_rect(fill = "gray")) + 
  scale_x_discrete(name="") +
  scale_y_continuous(name="Difference in Crude Oil Inventories")

plot3 <- ggplot(diference, aes(x = reorder(Date, GasolineInventories), y = GasolineInventories)) +
  geom_bar(stat = "identity", aes(colour = GasolineInventories)) +
  scale_colour_gradient(low = "darkgreen", high = "gray") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), panel.background = element_rect(fill = "gray")) + 
  scale_x_discrete(name="") +
  scale_y_continuous(name="Difference in Gasoline Inventories")

plot4 <- ggplot(diference, aes(x = reorder(Date, RefineryUtilization), y = RefineryUtilization)) +
  geom_bar(stat = "identity", aes(colour = RefineryUtilization)) +
  scale_colour_gradient(low = "red", high = "darkred") +
  theme(axis.ticks = element_blank(), axis.text.x = element_blank(), panel.background = element_rect(fill = "gray")) + 
  scale_x_discrete(name="") +
  scale_y_continuous(name="Difference in Refinery Utilization")

grid.arrange(plot1, plot2, plot3, plot4)