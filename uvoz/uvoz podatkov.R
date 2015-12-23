all_dates <- dir("podatki/timestamped")
poskusni_list <- list.dirs("podatki/timestamped")
poskusni_list <- poskusni_list[2:388]
list_brez_svoje_mape <- poskusni_list[-seq(1,length(poskusni_list),3)]


proba <- list.files(path = list_brez_svoje_mape, pattern = ".html", full.names = TRUE)
ime <- gsub("^.*?/(\\d{2,4}.*?)\\.html","\\1",proba)
for (i in 1:9){
  #length(proba)
  assign("x", data.frame( "Date" = read.csv(proba[i])[1], "Open" = read.csv(proba[i])[2],
                               "Close" = read.csv(proba[i])[3], "High" = read.csv(proba[i])[4],
                               "Low" = read.csv(proba[i])[5]))
  names(x) <- c("Date", "Open", "Close", "High", "Low")
  assign(ime[i], x)
  rm(x)
}
