library(flightsbr)
library(dplyr)
library(lubridate)

memory.limit(24576)

ano_atual <- 2022
ano_inicial <- 2000

# Lista para armazenar os data frames de cada ano
data_frames <- list()

# Loop de ano_inicial a ano_atual para baixar os dados
for (year in ano_inicial:ano_atual) {
  df <- read_flights(date = year, showProgress = TRUE)
  data_frames[[as.character(year)]] <- df
}

# Data frame para armazenar os resultados de contagem de passageiros de todos os anos
combined_count <- data.frame()

# Loop para contar passageiros para cada ano
for (year in ano_inicial:ano_atual) {
  df <- data_frames[[as.character(year)]]
  count_result <- df |>
    mutate(dt_partida_real = as.Date(dt_partida_real)) |>
    group_by(dt_partida_real) |>
    summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))
  
  # Adicione os resultados ao data frame 'combined_count'
  combined_count <- bind_rows(combined_count, count_result)
}

passagens_aereas <- combined_count |> 
  filter(year(dt_partida_real) >= ano_inicial & year(dt_partida_real) <= ano_atual)


saveRDS(passagens_aereas, 'data/passagens_aereas19a22.rds')

