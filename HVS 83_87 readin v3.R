
## script to read in 1980s NYC HVS data

library(dplyr)
options(scipen=999)


# 1987 --------------------------------------------------------------------


readin_vac.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_occ_1987.csv")
readin_vac.table <- readin_vac.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS87.txt"
               ,header=F
               ,widths=readin_vac.table[,"width"]
)
colnames(df) <- readin_vac.table[,"varname"]

## occupied portion 
occ_df.87 <- df %>% 
  filter(V_1 %in% 1) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,YrMovedIn = V_9.10
    ,MostRecLived6Mon = V_14.15
    # ,BefAftJul71 = V_39
    
    ,FirstOcc = V_13
    ,ReasMove = V_169.170
    
    ,CondoCoopStat = V_24
    ,Tenure_1 = V_25
    # ,Tenure_2 = V_51
    ,LivedAtConvers = V_94
    ,ConversNonEvictPlan = V_95
    ,RentFrmSponsor = V_96
    ,YrAcq = V_99.100
    ,UnitOccBeforeAcq = V_101
    ,CondoCoopBeforeAcq = V_102
    ,Price_1 = V_103.109
    # ,Price_2 = V_65
    
    ,MnthlyCondoCoopFee = V_138.139
    
    ,UnitsBldg = V_29.30
    
    ,StoriesBldg = V_32
    ,ElevBldg = V_33
    ,Rooms = V_34
    ,Bedrooms = V_35.36
    
    ,LeaseLen = V_90
    ,MnthlyCntrctRent = V_73.76
    ,RentRegStatus = V_80
    
    # ,PrevRented = V_162
    ,PrevTenure = V_177
    ,PrevMnthlyRent = V_178.181
    # ,DHCR.Flag = V_167
    # ,ProgramStatus = V_168.169
    ,ControlStatus.Recode = V_251.252
    ,Structure.Recode = V_253.254
    ,PubAssist = V_257.258
    ,ScheduleCode = V_6.7
    ,SRO.Flag = V_8
    ,YearBuilt = V_28
    ,UnitCondition = V_260
    # 
    # ,Tenure.Recode = V_186
    # 
    ,NumPersons.Recode = V_247.248
    # 
    ,MnthlyGrossRent = V_271.274
    # 
    ,BelowIncome.Recode = V_261
    ,TotalIncome = V_63.68
    # ,TotalIncomeTopcode.Flag = V_221
    # 
    ,SubBorough = V_301.302
    # 
    # ,TotalIncome.Recode = V_282.287
    # 
    ,Household.Weight = V_313.318
    ,Person.Weight = V_303.308
    ,SequenceNumber = V_319.324
    ,YearIdentifier = V_162
    ,LinkageIndicator = V_163.168
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>%
select(-contains("V_"))



## vacant portion 

readin_vac.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_vac_1987.csv")
readin_vac.table <- readin_vac.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS87.txt"
               ,header=F
               ,widths=readin_vac.table[,"width"]
)
colnames(df) <- readin_vac.table[,"varname"]


vac_df.87 <- df %>% 
  filter(V_1 %in% 2) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    ,ScheduleCode = V_6.7
    ,SRO.Flag = V_8
    ,YearBuilt = V_9
    # ,VacUnitRespond = V_27
    # 
    ,UnitsBldg = V_11.12
    
    ,StoriesBldg = V_16
    ,DurVac = V_24
    ,CondoCoopStat = V_27
    ,StatPriorVac = V_28
    ,CondoCoopStatPriorVac = V_29
    ,Status = V_30
    ,Reason = V_31
    # 
    # ,DHCR.Flag = V_54
    # ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_49.50
    ,Structure.Recode = V_53.54
    
    # 
    ,UnitCondition = V_55
    # 
    ,SubBorough = V_65.66
    ,SequenceNumber = V_79.84
    ,Household.Weight = V_73.78
    ,YearIdentifier = V_162
    ,LinkageIndicator = V_163.168
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>%
  select(-contains("V_"))


df.87 <- bind_rows(
  occ_df.87
  ,vac_df.87
)




# 1984 --------------------------------------------------------------------

## occupied portion - 1984
readin.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_occ_1984.csv")
readin.table <- readin.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS84.txt"
               ,header=F
               ,widths=readin.table[,"width"]
)
colnames(df) <- readin.table[,"varname"]

## NOTE tenure code changes pretty dramatically in 84, coop/condo is part of it now
## most recent lived variable changes to previous residence 5 years ago 
## condo coop status is droped, appears to be part of schedule code (V_6.7)
## previous tenure includes whether unit was coop or condo
occ_df.84 <- df %>% 
  filter(V_1 %in% 1) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    ,ScheduleCode = V_6.7
    # ,SRO.Flag = V_8
    ,YrMovedIn = V_12.13
    ,FirstOcc = V_16
    ,MostRecLived5Yr = V_17.18
    # ,CondoCoopStat = V_24
    ,Tenure_1 = V_24
    ,YearBuilt = V_25
    ,UnitsBldg = V_26.27
    ,StoriesBldg = V_29
    ,ElevBldg = V_31
    ,Rooms = V_33
    ,Bedrooms = V_34.35
    ,TotalIncome = V_76.81
    ,MnthlyCntrctRent = V_45.48
    
    ,RentRegStatus = V_70
    
    ,LeaseLen = V_177
    # ,LivedAtConvers = V_94
    # ,ConversNonEvictPlan = V_95
    # ,RentFrmSponsor = V_96
    # ,YrAcq = V_99.100
    # ,UnitOccBeforeAcq = V_101
    # ,CondoCoopBeforeAcq = V_102
    # ,Price_1 = V_103.109
    
    
    # ,MnthlyCondoCoopFee = V_138.139
    
    ,YearIdentifier = V_250
    ,LinkageIndicator = V_257.270
    ,ReasMove = V_154.155
    ,PrevTenure = V_163
    ,PrevMnthlyRent = V_165.168
    ,NumPersons.Recode = V_150.151
    ,ControlStatus.Recode = V_178.179
    ,Structure.Recode = V_181.182
    ,PubAssist = V_82
    
    # ,UnitCondition = V_260
    ,BelowIncome.Recode = V_185
    
    ,MnthlyGrossRent = V_196.199
    
    # ,SubBorough = V_301.302
    # 
    # ,TotalIncome.Recode = V_282.287
    # 
    ,Person.Weight = V_224.229
    ,Household.Weight = V_236.241
    ,SequenceNumber = V_242.247
    
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>% 
  select(-contains("V_"))



## vacant portion - 1984

readin_vac.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_vac_1984.csv")
readin_vac.table <- readin_vac.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS84.txt"
               ,header=F
               ,widths=readin_vac.table[,"width"]
)
colnames(df) <- readin_vac.table[,"varname"]


vac_df.84 <- df %>% 
  filter(V_1 %in% 2) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    ,ScheduleCode = V_6.7
    # ,SRO.Flag = V_8
    ,YearBuilt = V_12
    # # ,VacUnitRespond = V_27
    # # 
    ,UnitsBldg = V_14.15
    # 
    ,StoriesBldg = V_17
    ,DurVac = V_31
    # ,CondoCoopStat = V_27
    # ,StatPriorVac = V_28
    # ,CondoCoopStatPriorVac = V_29
    ,Status = V_32
    # ,Reason = V_31
    # # 
    # # ,DHCR.Flag = V_54
    # # ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_44.45
    ,Structure.Recode = V_46.47
    # 
    # # 
    ,UnitCondition = V_49
    # # 
    # ,SubBorough = V_65.66
    ,Household.Weight = V_61.66
    ,SequenceNumber = V_67.72
    ,YearIdentifier = V_250
    ,LinkageIndicator = V_257.270
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>%
  select(-contains("V_"))


df.84 <- bind_rows(
  occ_df.84
  ,vac_df.84
)



# 1981 --------------------------------------------------------------------



## occupied portion - 1981
readin.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_occ_1981.csv")
readin.table <- readin.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS81.txt"
               ,header=F
               ,widths=readin.table[,"width"]
)
colnames(df) <- readin.table[,"varname"]

## NOTE tenure code changes pretty dramatically in 84, coop/condo is part of it now
## most recent lived variable changes to previous residence 5 years ago 
## condo coop status is droped, appears to be part of schedule code (V_6.7)
## previous tenure includes whether unit was coop or condo
occ_df.81 <- df %>% 
  filter(V_1 %in% 2) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    ,ScheduleCode = V_6.7
    # ,SRO.Flag = V_8
    ,YrMovedIn = V_12.13
    ,FirstOcc = V_16
    ,MostRecLived5Yr = V_17.18
    # ,CondoCoopStat = V_24
    ,Tenure_1 = V_24
    ,YearBuilt = V_25
    ,UnitsBldg = V_26.27
    ,StoriesBldg = V_29
    ,ElevBldg = V_31
    ,Rooms = V_33
    ,Bedrooms = V_34.35
    ,MnthlyCntrctRent = V_45.48
    ,RentRegStatus = V_70
    
    
    ,TotalIncome = V_76.81
    ,PubAssist = V_82
    
    ,NumPersons.Recode = V_150.151
    ,ReasMove = V_154.155
    ,PrevTenure = V_163
    ,PrevMnthlyRent = V_165.168
    
    
    ,LeaseLen = V_177
    ,ControlStatus.Recode = V_178.179
    ,Structure.Recode = V_181.182
    ,BelowIncome.Recode = V_185
    
    ,MnthlyGrossRent = V_196.199
    
    # ,LivedAtConvers = V_94
    # ,ConversNonEvictPlan = V_95
    # ,RentFrmSponsor = V_96
    # ,YrAcq = V_99.100
    # ,UnitOccBeforeAcq = V_101
    # ,CondoCoopBeforeAcq = V_102
    # ,Price_1 = V_103.109
    
    
    # ,MnthlyCondoCoopFee = V_138.139
    
    ,Person.Weight = V_224.229
    ,Household.Weight = V_236.241
    ,SequenceNumber = V_242.247
    ,YearIdentifier = V_250
    ,LinkageIndicator = V_257.270
    
    
    
    
    # ,UnitCondition = V_260
    
    
    # ,SubBorough = V_301.302
    # 
    # ,TotalIncome.Recode = V_282.287
    # 
    
    
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>% 
  select(-contains("V_"))



## vacant portion - 1984

readin_vac.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_vac_1981.csv")
readin_vac.table <- readin_vac.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS81.txt"
               ,header=F
               ,widths=readin_vac.table[,"width"]
)
colnames(df) <- readin_vac.table[,"varname"]


vac_df.81 <- df %>% 
  filter(V_1 %in% 2) %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    ,ScheduleCode = V_6.7
    # ,SRO.Flag = V_8
    ,YearBuilt = V_12
    # # ,VacUnitRespond = V_27
    # # 
    ,UnitsBldg = V_14.15
    # 
    ,StoriesBldg = V_17
    ,DurVac = V_31
    # ,CondoCoopStat = V_27
    # ,StatPriorVac = V_28
    # ,CondoCoopStatPriorVac = V_29
    ,Status = V_32
    # ,Reason = V_31
    # # 
    # # ,DHCR.Flag = V_54
    # # ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_44.45
    ,Structure.Recode = V_46.47
    # 
    # # 
    ,UnitCondition = V_49
    # # 
    # ,SubBorough = V_65.66
    ,Household.Weight = V_61.66
    ,SequenceNumber = V_67.72
    ,YearIdentifier = V_250
    ,LinkageIndicator = V_251.256
  ) %>% 
  mutate(Household.Weight = Household.Weight * .01) %>%
  select(-contains("V_"))


df.81 <- bind_rows(
  occ_df.81
  ,vac_df.81
)

df.list.81_87 <- list(df.81,df.84,df.87)
names(df.list.81_87) <- c("df.81"
                          ,"df.84"
                          ,"df.87")



setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/Historical/Census Bureau 78_81_84_87")
save.image("NYCHVS_dataframes_81_84_87.RData")
saveRDS(df.list.81_87,"df.list.81_87.rds")

occ.list <- readRDS("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/df_list_occ.rds")
occ.list <- c(df.list.81_87,occ.list[4:length(occ.list)])

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
saveRDS(df.list, "NYCHVS_81_14_list_20170804.rds")


# saveRDS(df.list,
#   "/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Project Data/NYC HVS/NYCHVS_list_83_14_named.rds"
#   )