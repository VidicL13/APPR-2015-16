# Naložimo potrebne knjižnice, če še niso za delo na projektu
packages <- c("ggplot2", "dplyr", "quantmod", "gtable", "grid", "gridExtra", "rvest")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}