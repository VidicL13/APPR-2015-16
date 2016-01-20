# če bom potreboval imena
all_dates <- dir("podatki/timestamped")

poskusni_list <- list.dirs("podatki/timestamped")
# odstranim samega sebe
poskusni_list <- poskusni_list[2:388]
# odstranim še mape, ki držijo potrebne podatke. Ostanejo le še mape clcoil in usdcad
list_brez_svoje_mape <- poskusni_list[-seq(1,length(poskusni_list),3)]

# poberem imena kar z datumom skupaj, za boljšo preglednost in identifikacijo
proba <- list.files(path = list_brez_svoje_mape, pattern = ".html", full.names = TRUE)

ime <- gsub("^.*?/(\\d{2,4}.*?)\\/.*?(\\/.*?)\\.html","^.*?/\\1\\/.*?\\2",proba)
imena <- gsub("^.*?/(\\d{2,4}.*?)\\/.*?(\\/.*?)\\.html","\\1\\2",proba)

# izbrišem še podvojene
imena <- unique(imena)
ime <- unique(ime)

# samo za timer
ptm <- proc.time()

# ustvarim data.frame velikosti 9x149 oz. 9x148, kjer je prvi stolpec namenjen 
# datumu, 2:5 so namenjeni clcoil in 6:9 so namenjeni usdcad
for (i in 1){
  
  y <- ifelse(gsub(ime[i], "Pravilno", proba) == "Pravilno.html", TRUE, FALSE)
  y <- proba[y]
  
  if (file.info(y[1])$size>1 & file.info(y[2])$size>1){
    csv1 <- read.csv(y[1])
    csv2 <- read.csv(y[2])
    number_of_rows <- min(nrow(csv2),nrow(csv1))
    x <- data.frame(csv1[1:number_of_rows, c(1,2,4,5,3)],
                    csv2[1:number_of_rows, c(2,4,5,3)]^-1)
    names(x) <- c("Date", "OilOpen", "OilHigh", "OilLow",
                  "OilClose", "CadOpen", "CadHigh", "CadLow", "CadClose")
    assign(imena[i], x)
    rm(x,y,csv1,csv2)
  }
  else
    rm(y)
  
}
cat(proc.time()-ptm)
rm(i, ime, imena, list_brez_svoje_mape, poskusni_list, proba, number_of_rows, ptm)


