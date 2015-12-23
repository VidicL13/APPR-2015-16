library(rvest)
library(dplyr)
library(gsubfn)
library(httr)
naslov <- "http://www.fasteconomicnews.com/fx_calendar.aspx"

prebrano <- read_html(naslov, encoding = "UTF-8")
html_tabela <- prebrano %>% html_node(xpath = '//*[@id="fcc1_dgrC"]')
tabela <- html_tabela %>% html_table(header = TRUE)
Oil <- grep("^.*DOE Crude.*$",tabela[,4])
Oil <- 72

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

tabela2 <- tabela2[c(-105),]

for (i in 1:(floor(length(tabela2[,1])/4))){
  z <- 4*(i-1)+1
  tabela2[z,1] <- tabela2[z,1]
  tabela2[z+1,1] <- tabela2[z,1]
  tabela2[z+2,1] <- tabela2[z,1]
  tabela2[z+3,1] <- tabela2[z,1]
}

# tabela2[,1] <- t















