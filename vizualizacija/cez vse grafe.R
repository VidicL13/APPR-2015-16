# tu bo funkcija, ki bo risala grafe
for (i in ime[1:12]){
  assign(paste(i,"/plot",sep =""),ggplot(get(i),aes(get(i)$Date)) + 
           geom_rect(aes(xmin = get(i)$Date,
                         xmax = get(i)$Date,
                         ymin = ifelse(get(i)$Open<get(i)$Close,get(i)$Open,get(i)$Close),
                         ymax = ifelse(get(i)$Open>get(i)$Close,get(i)$Open,get(i)$Close)),
                         alpha = 0.5)) +
          geom_linerange(aes(x = get(i)$Date, ymin = get(i)$Low, ymax = get(i)$High))
  
}