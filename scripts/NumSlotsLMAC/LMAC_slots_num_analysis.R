# wartości rozpatrywancych parametrów: różne liczby sensorów i szczelin czasowych dla protokołu LMAC
network_sizes <- seq(10, 100, 10)
slots_nums <- seq(8, 64, 8)


# obliczenie statystyk z podziałem na rozmiary sieci
input_data_dir <- "data_sheets/NumSlotsLMAC/data/"
output_data_dir <- "data_sheets/NumSlotsLMAC/results/network_size_breakdown/"
file_name_prefix <- "NumSlotsLMAC_N"
stats_for_networks <- calculate_LMAC_slots_nums_stats_networks_set(
  network_sizes,
  slots_nums,
  input_data_dir,
  output_data_dir,
  file_name_prefix
)

# obliczenie statystyk z podziałem na liczby szczelin czasowych
output_data_dir <- "data_sheets/NumSlotsLMAC/results/slots_num_breakdown/"
file_name_prefix <- "NumSlotsLMAC_NS"
stats_for_slots_nums <- get_stats_for_all_slots_nums(
  slots_nums,
  network_sizes,
  stats_for_networks,
  output_data_dir,
  file_name_prefix
)

# TODO: wizualizacje, 
# TODO: wybór najlepszej liczby szczelin - dającej najlepsze średnie wyniki dla wszystkich rozmiarów sieci
vec_x <- stats[[1]]$slots_number
vec_y <- stats[[1]]$packet_received_ratio * 100
title <- "Procent poprawnie dostarczonych pakietów"
x_label <- "Liczba szczelin czasowych"
y_label <- "Poprawnie dostarczone pakiety [%]"

plot_1 <- create_line_plot(
  x_vector = vec_x,
  y_vector = vec_y,
  #title = title,
  x_label = x_label,
  y_label = y_label
)
plot(plot_1)






