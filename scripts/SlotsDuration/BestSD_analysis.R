# ---------------------------------------------------------------------------------------------------
# domyślne wartości parametrów

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu BMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/Default_small/BMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/Default_small/DefaultBMAC_small_results.csv"
file_name_prefix <- "DefaultBMAC_small_N"
network_sizes <- seq(5, 20, 1)

DefaultBMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu XMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/Default_small/XMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/Default_small/DefaultXMAC_small_results.csv"
file_name_prefix <- "DefaultXMAC_small_N"
network_sizes <- seq(5, 20, 1)

DefaultXMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu LMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/Default_small/LMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/Default_small/DefaultLMAC_small_results.csv"
file_name_prefix <- "DefaultLMAC_small_N"
network_sizes <- seq(5, 20, 1)

DefaultLMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# ---------------------------------------------------------------------------------------------------
# najlepsze długości szczelin czasowych

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu BMAC o SD=0.04s
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/BestSD/BMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/BestSD/BestSD_BMAC_small_results.csv"
file_name_prefix <- "BestSD_BMAC_small_N"
network_sizes <- seq(5, 20, 1)

BestSD_BMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu XMAC o SD=0.07s
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/BestSD/XMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/BestSD/BestSD_XMAC_small_results.csv"
file_name_prefix <- "BestSD_XMAC_small_N"
network_sizes <- seq(5, 20, 1)

BestSD_XMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu LMAC o SD=0.05s
#   w sieciach z liczbą sensorów od 5 do 20 (krok 1)
input_file_dir <- "data_sheets/3_SlotsDuration/data/summary/BestSD/LMAC/"
output_file_path <- "data_sheets/3_SlotsDuration/results/summary/BestSD/BestSD_LMAC_small_results.csv"
file_name_prefix <- "BestSD_LMAC_small_N"
network_sizes <- seq(5, 20, 1)

BestSD_LMAC_small_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# ------------------------------------------------------------------------------------------------
# wizualizacje - porównanie wyników dla domyślnej i najlepszej wartości parametru

# poprawność dostarczania pakietóW
network_sizes <- seq(5, 20, 1)

BMAC_SD_packets_received_summary <- data.frame(
  x = network_sizes,
  "B-MAC - domyślna szczelina czasowa 0.1s" = DefaultBMAC_small_stats$packet_received_ratio*100,
  "B-MAC - szczelina czasowa 0.04s" = BestSD_BMAC_small_stats$packet_received_ratio*100,
  check.names = FALSE)

XMAC_SD_packets_received_summary <- data.frame(
  x = network_sizes,
  "X-MAC - domyślna szczelina czasowa 1s" = DefaultXMAC_small_stats$packet_received_ratio*100,
  "X-MAC - szczelina czasowa 0.07s" = BestSD_XMAC_small_stats$packet_received_ratio*100,
  check.names = FALSE)

LMAC_SD_packets_received_summary <- data.frame(
  x = network_sizes,
  "LMAC - domyślna szczelina czasowa 0.1s" = DefaultLMAC_small_stats$packet_received_ratio*100,
  "LMAC - szczelina czasowa 0.05s" = BestSD_LMAC_small_stats$packet_received_ratio*100,
  check.names = FALSE)

DefaultSD_MAC_comparison_plots <- list()

DefaultSD_MAC_comparison_plots[[1]] <-
  create_multiple_line_plot_from_df(BMAC_SD_packets_received_summary,
                                    "Porównanie niezawodności sieci - szczeliny czasowe B-MAC",
                                    "liczba sensorów w sieci",
                                    "poprawnie dostarczone pakiety [%]",
                                    "Protokoły:")

DefaultSD_MAC_comparison_plots[[2]] <-
  create_multiple_line_plot_from_df(XMAC_SD_packets_received_summary,
                                    "Porównanie niezawodności sieci - szczeliny czasowe X-MAC",
                                    "liczba sensorów w sieci",
                                    "poprawnie dostarczone pakiety [%]",
                                    "Protokoły:")

DefaultSD_MAC_comparison_plots[[3]] <-
  create_multiple_line_plot_from_df(LMAC_SD_packets_received_summary,
                                    "Porównanie niezawodności sieci - szczeliny czasowe L-MAC",
                                    "liczba sensorów w sieci",
                                    "poprawnie dostarczone pakiety [%]",
                                    "Protokoły:")

display_plots(DefaultSD_MAC_comparison_plots)

#zużycie energii

BMAC_SD_energy_utilization_summary <- data.frame(
  x = network_sizes,
  "B-MAC - domyślna szczelina czasowa 0.1s" = DefaultBMAC_small_stats$total_energy_utilization,
  "B-MAC - szczelina czasowa 0.04s" = BestSD_BMAC_small_stats$total_energy_utilization,
  check.names = FALSE)

XMAC_SD_energy_utilization_summary <- data.frame(
  x = network_sizes,
  "X-MAC - domyślna szczelina czasowa 1s" = DefaultXMAC_small_stats$total_energy_utilization,
  "X-MAC - szczelina czasowa 0.07s" = BestSD_XMAC_small_stats$total_energy_utilization,
  check.names = FALSE)

LMAC_SD_energy_utilization_summary <- data.frame(
  x = network_sizes,
  "LMAC - domyślna szczelina czasowa 0.1s" = DefaultLMAC_small_stats$total_energy_utilization,
  "LMAC - szczelina czasowa 0.05s" = BestSD_LMAC_small_stats$total_energy_utilization,
  check.names = FALSE)

DefaultSD_MAC_energy_comparison_plots <- list()

DefaultSD_MAC_energy_comparison_plots[[1]] <-
  create_multiple_line_plot_from_df(BMAC_SD_energy_utilization_summary,
                                    "Porównanie zużycia energii - szczeliny czasowe B-MAC",
                                    "liczba sensorów w sieci",
                                    "całkowite zużycie energii [J]",
                                    "Protokoły:")

DefaultSD_MAC_energy_comparison_plots[[2]] <-
  create_multiple_line_plot_from_df(XMAC_SD_energy_utilization_summary,
                                    "Porównanie zużycia energii - szczeliny czasowe X-MAC",
                                    "liczba sensorów w sieci",
                                    "całkowite zużycie energii [J]",
                                    "Protokoły:")

DefaultSD_MAC_energy_comparison_plots[[3]] <-
  create_multiple_line_plot_from_df(LMAC_SD_energy_utilization_summary,
                                    "Porównanie zużycia energii - szczeliny czasowe L-MAC",
                                    "liczba sensorów w sieci",
                                    "poprawnie dostarczone pakiety [%]",
                                    "Protokoły:")

display_plots(DefaultSD_MAC_energy_comparison_plots)

# ------------------------------------------------------------------------------------------------
# wizualizacje - porównanie wyników niezawodności i zużycia zasobów energetycznych węzłów

network_sizes <- seq(5, 20, 1)

MAC_SD_packets_received_summary <- data.frame(
  x = network_sizes,
  "B-MAC - szczelina czasowa 0.04s" = BestSD_BMAC_small_stats$packet_received_ratio*100,
  "X-MAC - szczelina czasowa 0.07s" = BestSD_XMAC_small_stats$packet_received_ratio*100,
  "LMAC - szczelina czasowa 0.05s" = BestSD_LMAC_small_stats$packet_received_ratio*100,
  check.names = FALSE)

MAC_SD_energy_utilization_summary <- data.frame(
  x = network_sizes,
  "B-MAC - szczelina czasowa 0.04s" = BestSD_BMAC_small_stats$total_energy_utilization,
  "X-MAC - szczelina czasowa 0.07s" = BestSD_XMAC_small_stats$total_energy_utilization,
  "LMAC - szczelina czasowa 0.05s" = BestSD_LMAC_small_stats$total_energy_utilization,
  check.names = FALSE)

MAC_summary_plots <- list()

MAC_summary_plots[[1]] <-
  create_multiple_line_plot_from_df(MAC_SD_packets_received_summary,
                                    "Porównanie niezawodności sieci dla różnych protokołów MAC",
                                    "liczba sensorów w sieci",
                                    "poprawnie dostarczone pakiety [%]",
                                    "Protokoły:")

MAC_summary_plots[[2]] <-
  create_multiple_line_plot_from_df(MAC_SD_energy_utilization_summary,
                                    "Porównanie zużycia energii przez różne protokoły MAC",
                                    "liczba sensorów w sieci",
                                    "całkowite zużycie energii [J]",
                                    "Protokoły:")

display_plots(MAC_summary_plots)


#---------------------------------
mean_energy_utilization <- data.frame("B-MAC" = mean(BestSD_BMAC_small_stats$total_energy_utilization),
                                     "X-MAC" = mean(BestSD_XMAC_small_stats$total_energy_utilization),
                                     "LMAC" = mean(BestSD_LMAC_small_stats$total_energy_utilization),
                                     check.names = FALSE)

mean_energy_utilization_p <- data.frame("B-MAC" = mean_energy_utilization[[1]]/mean_energy_utilization[[1]]*100,
                                        "X-MAC" = mean_energy_utilization[[2]]/mean_energy_utilization[[1]]*100,
                                        "LMAC" = mean_energy_utilization[[3]]/mean_energy_utilization[[1]]*100,
                                        check.names = FALSE)

mean_ut_vec <- c(mean_energy_utilization_p[[1]], 
                 mean_energy_utilization_p[[2]],
                 mean_energy_utilization_p[[3]])
names <- c("B-MAC", "X-MAC", "LMAC")

energy_plot <- ggplot(data = data.frame(x=names, y=mean_ut_vec), aes(x,y)) + 
  geom_bar(stat="identity", width=0.3) + labs(title = "Zestawienie względnego średniego zużycia energii",
                                              x = "protokół",
                                              y = "średnie zużycie energii [%]")

plot(energy_plot)

