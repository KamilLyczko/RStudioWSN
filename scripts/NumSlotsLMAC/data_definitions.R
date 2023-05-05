slots_nums <- seq(8, 64, 4)
num_slots_LMAC_N10_stats <- calculate_stats_for_slots_nums(
  "data_sheets/NumSlotsLMAC/NumSlotsLMAC_N10.csv",
  slots_nums,
  "data_sheets/NumSlotsLMAC/results/NumSlotsLMAC_N10.csv")

