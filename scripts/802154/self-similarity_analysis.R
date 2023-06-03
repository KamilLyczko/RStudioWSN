# utworzenie list z odpowiednimi szeregami czasowymi (skumulowane rozmiary pakietów)
app1_ts_dfs <- create_ts_dfs(packet_received_app1_ts_dfs, 2, 4)
app2_ts_dfs <- create_ts_dfs(packet_received_app2_ts_dfs, 2, 4)
app3_ts_dfs <- create_ts_dfs(packet_received_app3_ts_dfs, 2, 4)
app4_ts_dfs <- create_ts_dfs(packet_received_app4_ts_dfs, 2, 4)
app5_ts_dfs <- create_ts_dfs(packet_received_app5_ts_dfs, 2, 4)

# aplikacja nr 1
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents_app1 <- calculate_hurst_exponents_for_ts_list(app1_ts_dfs, network_sizes)
hurst_empirical_app1 <- get_empirical_hurst_exps_for_ts_list(app1_ts_dfs, network_sizes)
mean_empirical_app1 <- get_mean_hurst_exps(hurst_empirical_app1)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst/hurst_exponents_app1.csv"
save_data(hurst_exponents_app1, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/empirical_hurst_exponents_app1.csv"
save_data(hurst_empirical_app1, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/mean_hurst_exponents_app1.csv"
save_data(mean_empirical_app1, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents_app1
col_names <- colnames(hurst_exponents_app1)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot_app1 <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp() - aplikacja nr 1",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot_app1)


mean_emp_plot_app1 <- create_line_plot_from_df(mean_empirical_app1,
                                               "Średnie wartości współczynnika Hurst'a - aplikacja nr 1",
                                               "liczba sensorów w seci",
                                               "wartość współczynnika Hurst'a")
plot(mean_emp_plot_app1)

# aplikacja nr 2
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents_app2 <- calculate_hurst_exponents_for_ts_list(app2_ts_dfs, network_sizes)
hurst_empirical_app2 <- get_empirical_hurst_exps_for_ts_list(app2_ts_dfs, network_sizes)
mean_empirical_app2 <- get_mean_hurst_exps(hurst_empirical_app2)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst/hurst_exponents_app2.csv"
save_data(hurst_exponents_app2, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/mean_hurst_exponents_app2.csv"
save_data(mean_empirical_app2, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents_app2
col_names <- colnames(hurst_exponents_app2)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot_app2 <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp() - aplikacja nr 2",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot_app2)

mean_emp_plot_app2 <- create_line_plot_from_df(mean_empirical_app2,
                                               "Średnie wartości współczynnika Hurst'a - aplikacja nr 2",
                                               "liczba sensorów w seci",
                                               "wartość współczynnika Hurst'a")
plot(mean_emp_plot_app2)

# aplikacja nr 3
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents_app3 <- calculate_hurst_exponents_for_ts_list(app3_ts_dfs, network_sizes)
hurst_empirical_app3 <- get_empirical_hurst_exps_for_ts_list(app3_ts_dfs, network_sizes)
mean_empirical_app3 <- get_mean_hurst_exps(hurst_empirical_app3)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst/hurst_exponents_app3.csv"
save_data(hurst_exponents_app3, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/mean_hurst_exponents_app3.csv"
save_data(mean_empirical_app3, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents_app3
col_names <- colnames(hurst_exponents_app3)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot_app3 <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp() - aplikacja nr 3",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot_app3)

mean_emp_plot_app3 <- create_line_plot_from_df(mean_empirical_app3,
                                               "Średnie wartości współczynnika Hurst'a - aplikacja nr 3",
                                               "liczba sensorów w seci",
                                               "wartość współczynnika Hurst'a")
plot(mean_emp_plot_app3)

# aplikacja nr 4
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents_app4 <- calculate_hurst_exponents_for_ts_list(app4_ts_dfs, network_sizes)
hurst_empirical_app4 <- get_empirical_hurst_exps_for_ts_list(app4_ts_dfs, network_sizes)
mean_empirical_app4 <- get_mean_hurst_exps(hurst_empirical_app4)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst/hurst_exponents_app4.csv"
save_data(hurst_exponents_app4, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/mean_hurst_exponents_app4.csv"
save_data(mean_empirical_app4, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents_app4
col_names <- colnames(hurst_exponents_app4)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot_app4 <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp() - aplikacja nr 4",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot_app4)

mean_emp_plot_app4 <- create_line_plot_from_df(mean_empirical_app4,
                                               "Średnie wartości współczynnika Hurst'a - aplikacja nr 4",
                                               "liczba sensorów w seci",
                                               "wartość współczynnika Hurst'a")
plot(mean_emp_plot_app4)

# aplikacja nr 5
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents_app5 <- calculate_hurst_exponents_for_ts_list(app5_ts_dfs, network_sizes)
hurst_empirical_app5 <- get_empirical_hurst_exps_for_ts_list(app5_ts_dfs, network_sizes)
mean_empirical_app5 <- get_mean_hurst_exps(hurst_empirical_app5)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst/hurst_exponents_app5.csv"
save_data(hurst_exponents_app5, output_file_path)
output_file_path <- "data_sheets/4_802154/results/hurst/mean_hurst_exponents_app5.csv"
save_data(mean_empirical_app5, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents_app5
col_names <- colnames(hurst_exponents_app5)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot_app5 <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp() - aplikacja nr 5",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot_app5)

mean_emp_plot_app5 <- create_line_plot_from_df(mean_empirical_app5,
                                               "Średnie wartości współczynnika Hurst'a - aplikacja nr 5",
                                               "liczba sensorów w seci",
                                               "wartość współczynnika Hurst'a")
plot(mean_emp_plot_app5)

# zestawienie wyników
hurst_comp_df <- data.frame(x = network_sizes,
                            "aplikacja nr 1" = hurst_exponents_app1$He,
                            "aplikacja nr 2" = hurst_exponents_app2$He,
                            "aplikacja nr 3" = hurst_exponents_app3$He,
                            "aplikacja nr 4" = hurst_exponents_app4$He,
                            "aplikacja nr 5" = hurst_exponents_app5$He,
                            check.names = FALSE
)

hurst_comp_plot <- create_multiple_line_plot_from_df(hurst_comp_df,
                                                      "Porównanie wartości współczynnika Hurst'a",
                                                      "liczba sensorów w sieci",
                                                      "wartość współczynnika Hurst'a"
)
plot(hurst_comp_plot)

hurst_comp_df2 <- data.frame(x = network_sizes,
                            "aplikacja nr 1" = mean_empirical_app1$mean_hurst,
                            "aplikacja nr 2" = mean_empirical_app2$mean_hurst,
                            "aplikacja nr 3" = mean_empirical_app3$mean_hurst,
                            "aplikacja nr 4" = mean_empirical_app4$mean_hurst,
                            "aplikacja nr 5" = mean_empirical_app5$mean_hurst,
                            check.names = FALSE
)

hurst_comp_plot2 <- create_multiple_line_plot_from_df(hurst_comp_df2,
                                                     "Porównanie średnich wartości współczynnika Hurst'a",
                                                     "liczba sensorów w sieci",
                                                     "wartość współczynnika Hurst'a",
                                                     "Rodzaj ruchu:"
)
plot(hurst_comp_plot2)

# czyszczenie środowiska
rm(network_sizes)
rm(output_file_path)
rm(df_for_plot)
rm(col_names)
rm(hurst_plot_app1)
rm(hurst_plot_app2)
rm(hurst_plot_app3)
rm(hurst_plot_app4)
rm(hurst_plot_app5)
rm(hurst_comp_df)
rm(hurst_comp_plot)