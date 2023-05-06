# funkcja zwraca ramkę z danymi wczytanymi z pliku o podanej ścieżce
load_data <- function(input_file_path) {
  data_obj <- read.csv(input_file_path, sep=";")
  return(data_obj)
}

# funkcja zapisuje dane z podanej ramki do pliku o podanej ścieżce
save_data <- function(data_obj, output_file_path) {
  write.csv2(data_obj, output_file_path, row.names=FALSE)
}

# funkcja generuej wykres liniowy dla pojedynczej pary wektorów x i y
create_line_plot <- function(x_vector, y_vector, title="", x_label = "", y_label = "") {
  ggplot(data = data.frame(x = x_vector, y = y_vector), aes(x, y)) + 
    geom_line() + geom_point() +
    scale_x_continuous(breaks = x_vector) +
    labs(title = title, x = x_label, y = y_label)
}

# funkcja wyświetlająca wykresy
display_plots <- function(plots_list) {
  for (plot_object in plots_list) {
    plot(plot_object)
  }
}