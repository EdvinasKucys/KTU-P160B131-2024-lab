library(tidyverse)
library(dplyr)

cat("Darbinė direktorija:", getwd())
download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.csv.zip", "../data/temp")
unzip("../data/temp",  exdir = "../data/")


data = read.csv2("../data/monthly-2023.csv")

data%>%
  filter(data$Ekonominės.veiklos.rūšies.kodas.ecoActCode. == 471100)%>%
  write.csv("../data/471100.csv")


file.remove("../data/temp")
file.remove("../data/monthly-2023.csv")

