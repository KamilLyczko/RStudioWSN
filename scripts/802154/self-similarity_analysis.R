# aplikacja nr 1
# obliczenie wartości współczynników
network_sizes <- seq(5, 20, 1)

hurst_exponents <- calculate_hurst_exponents_for_list(packet_received_ts_dfs, network_sizes)

# zapis wyników do pliku
output_file_path <- "data_sheets/4_802154/results/hurst_exponents/hurst_exponents_app1.csv"
save_data(hurst_exponents, output_file_path)

# wizualizacja wyników
df_for_plot <- hurst_exponents
col_names <- colnames(hurst_exponents)
col_names[1] <- "x"
colnames(df_for_plot) <- col_names
hurst_plot <- create_multiple_line_plot_from_df(
  df_for_plot,
  "Porównanie wartości współczynnika Hurst'a wyznaczonych przez funkcję hurstexp()",
  "liczba sensorów w sieci",
  "wartość współczynnika Hurst'a",
  "Rodzaj współczynnika:")
plot(hurst_plot)


# czyszczenie środowiska
rm(network_sizes)
rm(output_file_path)
rm(df_for_plot)
rm(col_names)
rm(hurst_plot)