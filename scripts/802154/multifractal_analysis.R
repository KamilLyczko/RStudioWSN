test <- MFDFA(app2_ts_dfs[[1]]$total_packets_size, scale = c(8,16,32,64,128,256), 
              q=c(-11,-9,-7,-5,-3,-1,1,3,5,7,9,11))
plot(test$spec$hq, test$spec$Dq, type="l")
