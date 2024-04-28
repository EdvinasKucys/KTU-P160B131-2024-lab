library(tidyverse)
library(ggplot2)
library(dplyr)
data<-read.csv("../data/471100.csv")

colnames(data) <- c("Nr.","code", "jarCode",
                    "name", "municipality", "ecoActCode",
                    "ecoActName", "month", "avgWage",
                    "numInsured", "avgWage2", "numInsured2", "tax")

# 2.1 užduotis: histograma vidutiniam atlyginimui

hist1 <- ggplot(data = data, aes(x = avgWage)) +
  geom_histogram(bins = 100, fill = "orange", color = "darkorange", size = 0.5) +
  labs(title = "Average wage histogram")

ggsave("../img/1_uzd.png", hist1, width = 3000,
                                           height = 1500, units = ("px"))

# 2.2 Užtuotis: įmoniu˛ vidutinio atlyginimo kitimo dinamiką metų eigoje

top5 = data %>%
  group_by(name) %>%
  summarise(salary = max(avgWage))%>%
  arrange(desc(salary))%>%
  head(5)

g2 = data%>%
  filter(name%in% top5$name) %>%
  mutate(Months=ym(month)) %>%
  ggplot(aes(x = Months, y = avgWage, color = name)) +
  geom_line()+ theme_classic() +
  labs(title = "Top 5 atlyginimo kitimas metų eigoje",
       color = "Įmonės pavadinimas") 


ggsave("../img/2_uzd.png", g2, width = 3000,
       height = 1500, units = ("px"))

# 2.3 užduotis: apdraustų darbuotojų skaičius

TopInsured = data %>%
  filter(name %in% top5$name) %>%
  group_by(name)%>%
  summarise(Insured=max(numInsured))%>%
  arrange(desc(Insured))


TopInsured$name = 
  factor(TopInsured$name,
         levels = TopInsured$name[order(TopInsured$Insured, decreasing = T)])

Graph3 = TopInsured%>%
  ggplot(aes(x = name, y = Insured, fill = name)) + geom_col() + theme_classic() +
  labs(title = "Top 5 įmonių apdraustųjų skaičius", fill = "Įmonės pavadinimas")

ggsave("../img/3_uzd.png", Graph3, width = 6000, height = 3000, units = ("px"))


