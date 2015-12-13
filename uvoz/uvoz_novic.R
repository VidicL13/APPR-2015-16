library(rvest)
library(dplyr)
library(gsubfn)
library(httr)
naslov <- "http://www.fasteconomicnews.com/fx_calendar.aspx"
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
  "__EVENTTARGET" = povezave[[76]][1],
  "__EVENTARGUMENT" = povezave[[76]][2],
  "__LASTFOCUS" = "",
  "__VIEWSTATE" = viewstate,
  "__VIEWSTATEGENERATOR" = viewstategen,
  "__EVENTVALIDATION" = validation
), encode = "form") %>% read_html()

tabela2 <- podstran %>%
  html_node(xpath = '//*[@id="fcc1_dgrC"]') %>%
  html_table(header=TRUE)
