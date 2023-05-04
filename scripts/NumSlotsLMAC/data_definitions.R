num_slots_LMAC_N10_data <- read.csv("data_sheets/NumSlotsLMAC/NumSlotsLMAC_N10.csv", sep=";")
#num_slots_LMAC_N10_data <- num_slots_LMAC_N10_data[order(num_slots_LMAC_N10_data$run),]
run_name <- "NumSlotsLMAC-2-20230503-19:12:14-15424"
num_slots_LMAC_N10_scalars <- subset(num_slots_LMAC_N10_data, (run == run_name & type == "scalar"))
