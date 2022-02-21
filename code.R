# Packgaes
library(tidyverse)
library(googlesheets4)

# Reading in data
df = read_sheet(ss = "https://docs.google.com/spreadsheets/d/1-e0ADluxtDSxN80EcRdb1MjuUnQ-f-zwJ9UHRhSJhZo/edit?usp=sharing",
           sheet = "S10")
