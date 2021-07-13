# - [] - Fixing up energy_data ----

remove = c('53_kW_mean','53_kW_max','71_kW_mean','71_kW_max','71A_kW_mean','71A_kW_max','83_kW_mean','83_kW_max','totalkW_max','totalkW_d-1','totalkW_w-1','totalkW_d/1','totalkW_w/1' , '71_71AkW_mean','71_71AkW_max','Month','Year','Day','WD','53_kW_time_max','71_kW_time_max','71A_kW_time_max','83_kW_time_max','71_71AkW_time_max','totalkW_time_max','CDD_15','HDD_25', 'NWD','temp_max','insolation','temp_mean', 'RH')
energy_data = energy_data[, !colnames(energy_data) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 
energy_data[['timestamp']] <- as.Date(energy_data[['timestamp']], tryFormats = '%d/%m/%Y')

# - [] - Subsetting Stuff ----

remove = c("open (USD)", "high (USD)", 'low (USD)', 'volume', 'market cap (USD)')
BTC_data = BTC_data[, !colnames(BTC_data) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 
colnames(BTC_data) <- c('timestamp', 'BTC_Close')

ETH_data = ETH_data[, !colnames(ETH_data) %in% c(remove)] # conditionally select the variables to remove from the dataframe. 
colnames(ETH_data) <- c('timestamp', 'ETH_Close')

data0 = ETH_data %>% inner_join(BTC_data, by="timestamp")
print(head(data0))

colnames(inflation_data) <- c('timestamp', 'breakeven_inflation')
# - Fixing up breakeven inflation values ----

inflation_data[['breakeven_inflation']] <- as.numeric(inflation_data[['breakeven_inflation']])

data1 = data0 %>% inner_join(inflation_data, by= 'timestamp')

colnames(energy_data) <- c('timestamp', 'totalkW_mean')

data = data1 %>% inner_join(energy_data, by= 'timestamp')
print(head(data))

write.csv(data, "data/data.csv")