# Analiza podatkov s programom R, 2015/16

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2015/16.

## Tematika

Izbrali si boste temo, s katero se bo vaš projekt ukvarjal. Tukaj boste
napisali, kje ste dobili podatke, ter kakšen je vaš cilj.

Tema, ki sem jo izbral, je analiza trga nafte ob tedenskem poročilu zaloge nafte v ZDA. 

 Ameriška uprava za energetske informacije (U.S. Energy Information Administration oz. EIA) je glavna agencija Zveznega statističnega sistema Združenih držav Amerike (Federal Statistical System of the United States). Glavne naloge agencije so zbiranje, analiziranje in razširjanje energetskih informacij za pospeševanje oblikovanja dobrih politik, učinkovitosti trgov in javnega razumevanja energije ter njeno povezanost z gospodarstvom in okoljem. Programi EIA zajemajo podatke o zalogah premoga, nafte, zemeljskega plina, obnovljivih virov, električne ter jedrske energije.
 
 EIA tedensko objavlja spremembo števila sodčkov surove nafte (Crude Oil Inventories), ki jo hranijo ameriška podjetja. Nivo zalog vpliva na ceno naftnih izdelkov, posledično se odraža sprememba tudi na inflaciji ter moči dolarja.
 

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Spletni vmesnik

Spletni vmesnik se nahaja v datotekah v mapi `shiny/`. Poženemo ga tako, da v
RStudiu odpremo datoteko `server.R` ali `ui.R` ter kliknemo na gumb *Run App*.
Alternativno ga lahko poženemo tudi tako, da poženemo program `shiny.r`.

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `httr` - za pobiranje spletnih strani
* `XML` - za branje spletnih strani
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
