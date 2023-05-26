# utworzenie wykresów skumulownej wariancji (testowanie stacjonarności):
plot(cvar(packet_received_app1_ts_dfs[[1]]$total_packets_size), type="l",
     main = "Aplikacja nr 1 - 5 sensorów w sieci",
     ylab="wariancja")
plot(cvar(packet_received_app1_ts_dfs[[16]]$total_packets_size), type="l",
     main = "Aplikacja nr 1 - 20 sensorów w sieci",
     ylab="wariancja")

plot(cvar(packet_received_app2_ts_dfs[[1]]$total_packets_size), type="l",
     main = "Aplikacja nr 2 - 5 sensorów w sieci",
     ylab="wariancja")
plot(cvar(packet_received_app2_ts_dfs[[16]]$total_packets_size), type="l",
     main = "Aplikacja nr 2 - 20 sensorów w sieci",
     ylab="wariancja")

plot(cvar(packet_received_app3_ts_dfs[[1]]$total_packets_size), type="l",
     main = "Aplikacja nr 3 - 5 sensorów w sieci",
     ylab="wariancja")
plot(cvar(packet_received_app3_ts_dfs[[16]]$total_packets_size), type="l",
     main = "Aplikacja nr 3 - 20 sensorów w sieci",
     ylab="wariancja")

plot(cvar(packet_received_app4_ts_dfs[[1]]$total_packets_size), type="l",
     main = "Aplikacja nr 4 - 5 sensorów w sieci",
     ylab="wariancja")
plot(cvar(packet_received_app4_ts_dfs[[16]]$total_packets_size), type="l",
     main = "Aplikacja nr 4 - 20 sensorów w sieci",
     ylab="wariancja")

#wariancja ma zmienny charakter dla początku szeregów czasowych, dlatego badane szeregi zostaną
#   skrócone - pominięcie pierwszych 300 obserwacji w celu lepszej stabilizacji wariancji

app1_ts_dfs <- create_ts_dfs(packet_received_app1_ts_dfs, 2, 4)
app2_ts_dfs <- create_ts_dfs(packet_received_app2_ts_dfs, 2, 4)
app3_ts_dfs <- create_ts_dfs(packet_received_app3_ts_dfs, 2, 4)
app4_ts_dfs <- create_ts_dfs(packet_received_app4_ts_dfs, 2, 4)

app1_ts_dfs_short <- get_multiple_ts_window(app1_ts_dfs, 301, 3600)
app2_ts_dfs_short <- get_multiple_ts_window(app2_ts_dfs, 301, 3600)
app3_ts_dfs_short <- get_multiple_ts_window(app3_ts_dfs, 301, 3600)
app4_ts_dfs_short <- get_multiple_ts_window(app4_ts_dfs, 301, 3600)

# ponowne utworzenie wykresów skumulownej wariancji:
plot(cvar(diff(app1_ts_dfs[[1]]$total_packets_size)), type="l",
     main = "Aplikacja nr 1 - 5 sensorów w sieci",
     ylab="wariancja")
plot(cvar(app1_ts_dfs_short[[1]]$total_packets_size), type="l",
     main = "Aplikacja nr 1 short - 5 sensorów w sieci",
     ylab="wariancja")

# nie uzyskano znaczącej poprawy

