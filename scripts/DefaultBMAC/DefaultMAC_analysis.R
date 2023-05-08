# -----------------------------------------------------------------------------------------------
# obliczanie statystyk


# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu BMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 10 do 100 (krok 10)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/BMAC/up_to_100/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/BMAC/DefaultBMAC_results.csv"
file_name_prefix <- "DefaultBMAC_N"
network_sizes <- seq(10, 100, 10)

DefaultBMAC_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu BMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 50 (krok 5)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/BMAC/up_to_50/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/BMAC/DefaultBMAC_medium_results.csv"
file_name_prefix <- "DefaultBMAC_N"
file_suffix <- "_medium"
network_sizes <- seq(5, 50, 5)

DefaultBMAC_medium_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes, 
  input_file_suffix = file_suffix
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu XMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 10 do 100 (krok 10)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/XMAC/up_to_100/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/XMAC/DefaultXMAC_results.csv"
file_name_prefix <- "DefaultXMAC_N"
network_sizes <- seq(10, 100, 10)

DefaultXMAC_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu XMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 50 (krok 5)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/XMAC/up_to_50/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/XMAC/DefaultXMAC_medium_results.csv"
file_name_prefix <- "DefaultXMAC_N"
file_suffix <- "_medium"
network_sizes <- seq(5, 50, 5)

DefaultXMAC_medium_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes, 
  input_file_suffix = file_suffix
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu LMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 10 do 100 (krok 10)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/LMAC/up_to_100/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/LMAC/DefaultLMAC_results.csv"
file_name_prefix <- "DefaultLMAC_N"
network_sizes <- seq(10, 100, 10)

DefaultLMAC_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu LMAC o domyślnych parametrach
#   w sieciach z liczbą sensorów od 5 do 50 (krok 5)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/LMAC/up_to_50/"
output_file_path <- "data_sheets/1_DefaultParamsValues/results/LMAC/DefaultLMAC_medium_results.csv"
file_name_prefix <- "DefaultLMAC_N"
file_suffix <- "_medium"
network_sizes <- seq(5, 50, 5)

DefaultLMAC_medium_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes, 
  input_file_suffix = file_suffix
)

# obliczenie statystyk dla danych o ruchu sieciowym dla protokołu LMAC o domyślnej wartości
#   parametru określającego długość szczeliny czasowej oraz liczbach szczelin zależnych od 
#       rozmiaru sieci w sieciach z liczbą sensorów od 5 do 50 (krok 5)
input_file_dir <- "data_sheets/1_DefaultParamsValues/data/LMAC_differentSlotsNums/"
output_file_path <- 
  "data_sheets/1_DefaultParamsValues/results/LMAC/LMAC_defaultSD_differentNS_medium_results.csv"
file_name_prefix <- "LMAC_defaultSD_differentNS_N"
file_suffix <- "_medium"
network_sizes <- seq(5, 50, 5)

LMAC_defaultSD_differentNS_medium_stats <- calculate_stats_multiple_files_simple(
  input_file_dir, output_file_path, file_name_prefix, network_sizes, 
  input_file_suffix = file_suffix
)


# -----------------------------------------------------------------------------------------------
# wizualizacje

DefaultBMAC_plots <- create_stats_visualizations(DefaultBMAC_stats, "- domyślny BMAC")
display_plots(DefaultBMAC_plots)

DefaultXMAC_plots <- create_stats_visualizations(DefaultXMAC_stats, "- domyślny XMAC")
display_plots(DefaultXMAC_plots)

DefaultLMAC_plots <- create_stats_visualizations(DefaultLMAC_stats, "- domyślny LMAC")
display_plots(DefaultLMAC_plots)

DefaultBMAC_medium_plots <- create_stats_visualizations(DefaultBMAC_medium_stats, "- domyślny BMAC")
display_plots(DefaultBMAC_medium_plots)

DefaultXMAC_medium_plots <- create_stats_visualizations(DefaultXMAC_medium_stats, "- domyślny XMAC")
display_plots(DefaultXMAC_medium_plots)

DefaultLMAC_medium_plots <- create_stats_visualizations(DefaultLMAC_medium_stats, "- domyślny LMAC")
display_plots(DefaultLMAC_medium_plots)

LMAC_defaultSD_differentNS_medium_plots <-
  create_stats_visualizations(LMAC_defaultSD_differentNS_medium_stats,
                              "- LMAC z liczbą szczelin czasowych zależną od rozmiaru sieci")
display_plots(LMAC_defaultSD_differentNS_medium_plots)
                                                 
