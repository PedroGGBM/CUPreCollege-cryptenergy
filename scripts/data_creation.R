# - [] - Fixing up energy_data ----

BTC_energy[['Date']] <- as.Date(BTC_energy[['Date']], tryFormats = '%Y/%m/%d')
ETH_energy[['Date']] <- as.Date(ETH_energy[['Date']], tryFormats = '%Y/%m/%d')

remove = c("Minimum TWh per Year")
BTC_energy = BTC_energy[, !colnames(BTC_energy) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 

remove = c("Minimum TWh per Year")
ETH_energy = ETH_energy[, !colnames(ETH_energy) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 

# - [] - Subsetting Stuff ----

remove = c("open (USD)", "high (USD)", 'low (USD)', 'volume', 'market cap (USD)')
BTC_data = BTC_data[, !colnames(BTC_data) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 
colnames(BTC_data) <- c('timestamp', 'BTC_Close')

ETH_data = ETH_data[, !colnames(ETH_data) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 
colnames(ETH_data) <- c('timestamp', 'ETH_Close')

data0 = ETH_data %>% inner_join(BTC_data, by="timestamp")

colnames(inflation_data) <- c('timestamp', 'breakeven_inflation')
# - Fixing up breakeven inflation values ----

inflation_data[['breakeven_inflation']] <- as.numeric(inflation_data[['breakeven_inflation']])

data1 = data0 %>% inner_join(inflation_data, by= 'timestamp')

colnames(BTC_energy) <- c('timestamp', 'BTC_Energy')

data2 = data1 %>% inner_join(BTC_energy, by= 'timestamp')

colnames(ETH_energy) <- c('timestamp', 'ETH_Energy')

data = data2 %>% inner_join(ETH_energy, by= 'timestamp')

print('Made the following DataFrame:')
print(head(data))

write.csv(data, "data/data.csv")