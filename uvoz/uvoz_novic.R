library(rvest)
library(dplyr)
library(gsubfn)
library(httr)
naslov <- "http://www.fasteconomicnews.com/fx_calendar.aspx"

prebrano <- read_html(naslov, encoding = "UTF-8")
html_tabela <- prebrano %>% html_node(xpath = '//*[@id="fcc1_dgrC"]')
tabela <- html_tabela %>% html_table(header = TRUE)
Oil <- grep("^.*DOE Crude.*$",tabela[,4])
Oil <- Oil+1

# prebrano <- read_html(naslov, encoding = "UTF-8")
# html_tabela <- prebrano %>% html_node(xpath = '//*[@id="fcc1_dgrC"]')
# tabela <- html_tabela %>% html_table(header = TRUE)


viewstate <- prebrano %>%
  html_node(xpath = '//input[@id="__VIEWSTATE"]/@value') %>%
  html_text()
viewstategen <- prebrano %>%
  html_node(xpath = '//input[@id="__VIEWSTATEGENERATOR"]/@value') %>%
  html_text()
validation <- prebrano %>%
  html_node(xpath = '//input[@id="__EVENTVALIDATION"]/@value') %>%
  html_text()

povezave <- html_tabela %>%
  xml_nodes(xpath='.//a[@id]/@href') %>%
  html_text() %>% strapplyc("'([^']*)'")

podstran <- POST(naslov, body = list(
  "__EVENTTARGET" = povezave[[Oil]][1],
  "__EVENTARGUMENT" = povezave[[Oil]][2],
  "__LASTFOCUS" = "",
  "__VIEWSTATE" = viewstate,
  "__VIEWSTATEGENERATOR" = viewstategen,
  "__EVENTVALIDATION" = validation
), encode = "form") %>% read_html()

tabela2 <- podstran %>%
  html_node(xpath = '//*[@id="fcc1_dgrC"]') %>%
  html_table(header=TRUE)


#--------------------------------------------------------------------------------------------
# Sedaj pa še malo počistim in spremenim podatke
tabela2 <- tabela2[c(-3,-8,-9)]
mesec1 <- c("Dec", "Nov", "Oct", "Sep", "Aug", "Jul", "Jun", "May", "Apr", "Mar", "Feb", "Jan")
mesec2 <- c(12:10, "09", "08", "07", "06", "05", "04", "03", "02", "01")
for (i in 1:12){
  tabela2[,1] <- gsub(paste("^.{5}",mesec1[i],sep=""),mesec2[i],tabela2[,1])
}
tabela2[,1] <- gsub("^(\\d{2})\\s(\\d{2}),\\s(\\d{4})","\\3-\\1-\\2",tabela2[,1])
tabela2[,2] <- gsub(":","-", tabela2[,2])
tabela2[,3] <- gsub("^.*(Manufacturing)", TRUE, tabela2[,3])

for (i in 1:length(tabela2[,1])){
  if (paste(tabela2[i,3]) == "TRUE"){
    tabela2 <- tabela2[c(-i),]
  }
}


for (i in 1:(floor(length(tabela2[,1])/4))){
  z <- 4*(i-1)+1
  tabela2[z,1] <- tabela2[z,1]
  tabela2[z+1,1] <- tabela2[z,1]
  tabela2[z+2,1] <- tabela2[z,1]
  tabela2[z+3,1] <- tabela2[z,1]
}

tabela2[,1] <- paste(tabela2[,1],tabela2[,2], sep  = "-")
tabela2 <- tabela2[,c(-2)]
names(tabela2) <- c("date", "which news", "actual", "forcast", "neki")
tabela2 <- tabela2[c(-1,-2,-3,-4),]
tabela2 <- tabela2[,c(-5)]
tabela2$difference <- as.numeric(tabela2$actual) - as.numeric(tabela2$forcast)
tabela2$differenceprocent <- as.numeric(tabela2$actual)/as.numeric(tabela2$forcast)*100

tab <- tabela2
tab1 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab2 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab3 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
                   "which news" = rep(NA,floor(length(tab[,1])/4)),
                   "actual" = rep(NA,floor(length(tab[,1])/4)),
                   "forcast" = rep(NA,floor(length(tab[,1])/4)),
                   "difference" = rep(NA,floor(length(tab[,1])/4)))
tab4 <- data.frame("date" = rep(NA,floor(length(tab[,1])/4)),
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

DistillateInventories <- tab1
CrudeOilInventories <- tab2
GasolineInventories <- tab3
RefineryUtilization <- tab4
rm(tab4, tab3, tab2, tab1, tab, tabela, tabela2, i, mesec1, mesec2, Oil, number_of_rows,
   naslov, podstran, povezave, prebrano, validation, viewstate, viewstategen, z, html_tabela)

write.csv(DistillateInventories, file = "podatki/DistillateInventories.csv")
write.csv(CrudeOilInventories, file = "podatki/CrudeOilInventories.csv")
write.csv(GasolineInventories, file = "podatki/GasolineInventories.csv")
write.csv(RefineryUtilization, file = "podatki/RefineryUtilization.csv")










