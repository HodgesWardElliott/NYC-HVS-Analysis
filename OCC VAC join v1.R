## script combining the vacant surveys with occupied surveys
## note that HVS prior to 1991 already have vacant responses in them 

library(dplyr)
options(scipen=999)

occ.list <- readRDS("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/df_list_occ.rds")
vac.list <- readRDS("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/Git/NYC_HVS Analysis/vac_df_1991_2014 20170601_1228.rds")

## adjust household weights for vacant list
for(i in 1:length(vac.list)){
  vac.list[[i]][,"Household.Weight"] <- vac.list[[i]][,"Household.Weight"]*.00001
}

## combine
df.list <- lapply(1:length(vac.list), function(x) bind_rows(
  occ.list[[x+3]]
  ,vac.list[[x]]
)
)

df.list <- c(occ.list[1:3],df.list)

names(df.list) <- gsub("occ","df.",names(occ.list))

setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/RData")
saveRDS(df.list, "NYCHVS_83_14_list_20170803.rds")

