network_sizes <- seq(5, 20, 1)

# aplikacja nr 1
app1_spectrums <- get_multifractal_spectrums_for_list(app1_ts_dfs)
app1_comp_plot <- create_multiple_multifractal_spectrum_plot(
  app1_spectrums,
  network_sizes,
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 1")
plot(app1_comp_plot)
app1_comp_plot_range1 <- create_multiple_multifractal_spectrum_plot(
  app1_spectrums[1:8],
  network_sizes[1:8],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 1")
plot(app1_comp_plot_range1)
app1_comp_plot_range2 <- create_multiple_multifractal_spectrum_plot(
  app1_spectrums[9:16],
  network_sizes[9:16],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 1")
plot(app1_comp_plot_range2)


# aplikacja nr 2
app2_spectrums <- get_multifractal_spectrums_for_list(app2_ts_dfs)
app2_comp_plot <- create_multiple_multifractal_spectrum_plot(
  app2_spectrums,
  network_sizes,
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 2")
plot(app2_comp_plot)
app2_comp_plot_range1 <- create_multiple_multifractal_spectrum_plot(
  app2_spectrums[1:8],
  network_sizes[1:8],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 2")
plot(app2_comp_plot_range1)
app2_comp_plot_range2 <- create_multiple_multifractal_spectrum_plot(
  app2_spectrums[9:16],
  network_sizes[9:16],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 2")
plot(app2_comp_plot_range2)

# aplikacja nr 3
app3_spectrums <- get_multifractal_spectrums_for_list(app3_ts_dfs)
app3_comp_plot <- create_multiple_multifractal_spectrum_plot(
  app3_spectrums,
  network_sizes,
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 3")
plot(app3_comp_plot)
app3_comp_plot_range1 <- create_multiple_multifractal_spectrum_plot(
  app3_spectrums[1:8],
  network_sizes[1:8],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 3")
plot(app3_comp_plot_range1)
app3_comp_plot_range2 <- create_multiple_multifractal_spectrum_plot(
  app3_spectrums[9:16],
  network_sizes[9:16],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 3")
plot(app3_comp_plot_range2)

# aplikacja nr 4
app4_spectrums <- get_multifractal_spectrums_for_list(app4_ts_dfs)
app4_comp_plot <- create_multiple_multifractal_spectrum_plot(
  app4_spectrums,
  network_sizes,
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 4")
plot(app4_comp_plot)
app4_comp_plot_range1 <- create_multiple_multifractal_spectrum_plot(
  app4_spectrums[1:8],
  network_sizes[1:8],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 4")
plot(app4_comp_plot_range1)
app4_comp_plot_range2 <- create_multiple_multifractal_spectrum_plot(
  app4_spectrums[9:16],
  network_sizes[9:16],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 4")
plot(app4_comp_plot_range2)

# aplikacja nr 5
app5_spectrums <- get_multifractal_spectrums_for_list(app5_ts_dfs)
app5_comp_plot <- create_multiple_multifractal_spectrum_plot(
  app5_spectrums,
  network_sizes,
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 5")
plot(app5_comp_plot)
app5_comp_plot_range1 <- create_multiple_multifractal_spectrum_plot(
  app5_spectrums[1:8],
  network_sizes[1:8],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 5")
plot(app5_comp_plot_range1)
app5_comp_plot_range2 <- create_multiple_multifractal_spectrum_plot(
  app5_spectrums[9:16],
  network_sizes[9:16],
  "Zestawienie widm multifraktalnych dla ruchu aplikacji nr 5")
plot(app5_comp_plot_range2)
