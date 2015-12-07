Analiza trga nafte:
===================

Temo sem izbiral na področju, ki ga imam željo podrobneje spoznati. Kapitalski trgi zaradi svoje kompleksnosti ponujajo veliko količino podatkov, kar mi bo koristilo pri projektu, kjer bom na podlagi le teh poskušal analizirati dogajanje.
Glede na to da gre tukaj za zelo obširno temo, sem se odločil, da se podrobneje posvetim le specifični novici, ki vpliva na tako na ceno nafte, kot tudi na določene valutne tečaje. 

Kakšen je cilj analize?
=======================


Glavni cilj analize je poiskati vzorce odzivanja trgov, ki se ponavljajo ob objavi novice. Poskušal bom poiskati povezave med razliko napovedi analitikov in objavljeno količino ter odzivnostjo trga. V kolikor bom zaznal vzorce, ki se bodo ponavljali jih bom natančneje analiziral.

Dodatni cilji:
--------------

Dodatne cilje bom skušal doseči le v primeru, da bom dosegel glavni cilj. Za stranske cilje sem si zadal iskanje tako imenovanih "arbitraž" med različnimi trgovalnimi instrumenti ter razviti trgovalno strategijo, ki bi te "arbitraže" lahko koristila.


Za katero novico gre?
=====================

 Ameriška uprava za energetske informacije (U.S. Energy Information Administration oz. EIA) je glavna agencija Zveznega statističnega sistema Združenih držav Amerike (Federal Statistical System of the United States). Glavne naloge agencije so zbiranje, analiziranje in razširjanje energetskih informacij za pospeševanje oblikovanja dobrih politik, učinkovitosti trgov in javnega razumevanja energije ter njene povezanosti z gospodarstvom in okoljem. Programi EIA zajemajo podatke o zalogah premoga, nafte, zemeljskega plina, obnovljivih virov, električne ter jedrske energije.
 
 EIA tedensko, ponavadi vsako sredo ob 16:30, objavlja spremembo števila sodčkov surove nafte (Crude Oil Inventories), ki jo hranijo ameriška podjetja. Nivo zalog vpliva na ceno naftnih izdelkov, posledično se odraža sprememba tudi na vrednotenjih valut. Tukaj imam v mislih predvsem države (njihove valute), ki so močno odvisne od izvoza/uvoza naftnih derivatov.
 Poleg omenjene novice, ob istem času objavi še spremembo zalog destiliranih naftnih produktov (Distillate Inventories), spremembo zalog bencina (Gasoline Inventories) in pa količino izkoriščenih rafinerij (Refinery Utilization).
 


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
