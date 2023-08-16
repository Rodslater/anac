library(flightsbr)
library(dplyr)

# download flights data
df_2019 <- read_flights(date=2019, showProgress = TRUE)
df_2020 <- read_flights(date=2020, showProgress = TRUE)
df_2021 <- read_flights(date=2021, showProgress = TRUE)
df_2022 <- read_flights(date=2022, showProgress = TRUE)
df_2023 <- read_flights(date=2023, showProgress = TRUE)

# count daily passengers

count_2019 <- df_2019 |>
  mutate(dt_partida_real = as.Date(dt_partida_real)) |>
  group_by(dt_partida_real) |>
  summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))

count_2020 <- df_2020 |>
  mutate(dt_partida_real = as.Date(dt_partida_real)) |>
  group_by(dt_partida_real) |>
  summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))

count_2021 <- df_2021 |>
  mutate(dt_partida_real = as.Date(dt_partida_real)) |>
  group_by(dt_partida_real) |>
  summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))

count_2022 <- df_2022 |>
  mutate(dt_partida_real = as.Date(dt_partida_real)) |>
  group_by(dt_partida_real) |>
  summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))

count_2023 <- df_2023 |>
  mutate(dt_partida_real = as.Date(dt_partida_real)) |>
  group_by(dt_partida_real) |>
  summarise(total_pass = sum(as.numeric(nr_passag_pagos), na.rm = TRUE))


passagens_aereas <- rbind(count_2019, count_2020, count_2021, count_2022, count_2023)

saveRDS(passagens_aereas, 'data/passagens_aereas.rds')

