
## Script to read in NYCHVS fwf files using the pre-compiled variable position csvs

library(dplyr)
library(lubridate)

## read in historical HVS data

## 1987
readin.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_1987.csv")
readin.table <- readin.table %>% 
  mutate(varname = ifelse(width==1
                          ,paste("V_",start,sep="")
                          ,paste("V_",start,".",stop,sep="")
  )
  )

df <- read.fwf("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/historical_fwf_files/NYCHVS87.txt"
               ,header=F
               ,widths=readin.table[,"width"]
)
colnames(df) <- readin.table[,"varname"]


# summary(df)
df.87 <- df %>% 
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
  mutate(Household.Weight = Household.Weight * .01
         ,YrMovedIn = paste(19
           ,ifelse(YrMovedIn<10
                ,as.character(paste(0,YrMovedIn,sep=""))
                ,as.character(YrMovedIn))
           ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1987,"Y!"))
  ) %>% 
  select(-contains("V_"))

# df.87[1:20,"YrMovedIn"]
# sum(is.na(df.87[,"YrMovedIn"]))
# summary(as.numeric(df.87[,"YrMovedIn"]))
# summary(length(df.87[,"YrMovedIn"]))



## 1984
readin.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_1984.csv")
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
df.84 <- df %>% 
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
  mutate(Household.Weight = Household.Weight * .01
         ,YrMovedIn = paste(19
                            ,ifelse(YrMovedIn<10
                                    ,as.character(paste(0,YrMovedIn,sep=""))
                                    ,as.character(YrMovedIn))
                            ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1984,"Y!"))
         ) %>% 
  select(-contains("V_"))


# df.84[1:20,"YrMovedIn"]
# sum(is.na(df.84[,"YrMovedIn"]))
# summary(as.numeric(df.84[,"YrMovedIn"]))
# summary(length(df.87[,"YrMovedIn"]))


## 1981
readin.table <- read.csv("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/historical variable position csvs cleaned/HVS_varpos_1981.csv")
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
df.81 <- df %>% 
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
  mutate(Household.Weight = Household.Weight * .01
         ,YrMovedIn = paste(19
                            ,ifelse(YrMovedIn<10
                                    ,as.character(paste(0,YrMovedIn,sep=""))
                                    ,as.character(YrMovedIn))
                            ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1981,"Y!")) 
         ) %>% 
  select(-contains("V_"))

setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/Historical/Census Bureau 78_81_84_87")
# save.image("NYCHVS_dataframes_81_84_87.RData")

df.list.81_87 <- list(df.81,df.84,df.87)
names(df.list.81_87) <- c("occ81"
                          ,"occ84"
                          ,"occ87")

saveRDS(df.list.81_87,"df.list.81_87.rds")


## read in current HVS data 


setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/occ_fwf_files")

readin.list <- readRDS(
  # file.choose()
  "/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/Git/NYC_HVS Analysis/variable position cleaned/occ_var_position_readinlist.rds"
)

abrv.yr <- substr(names(readin.list)
       ,start=nchar(names(readin.list))-1
       ,stop=nchar(names(readin.list))
       )

fwf.files <- list.files(pattern=".txt")
fwf.yr <- gsub("[^[:digit:]]","",fwf.files)

df.list <- list()
for(i in 1:length(fwf.files)){
  readin.table <- as.data.frame(
    readin.list[which(abrv.yr==fwf.yr[i])]
    ,stringsAsFactors=F
    )
  
  colnames(readin.table) <- gsub(".*\\.","",colnames(readin.table))
  

  df <- read.fwf(fwf.files[i]
                 ,header=F
                 ,widths=readin.table[,"width"]
                 # ,col.names=readin.table[,""]
                 )
  colnames(df) <- readin.table[,"varname"]
  
  df[,"year"] <- fwf.yr[i]
  
  df.list[[i]] <- df
  
  cat(i,"\n")
}

names(df.list) <- gsub(".txt","",fwf.files)

df.list.hold <- df.list
# df.list.hold2 <- df.list

saveRDS(df.list.hold,"/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/df_list_raw.91_14.rds")


## 1991
df.91 <- df.list$occ91 %>%
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_35.36
    ,YrMovedIn = V_37.38
    ,BefAftJul71 = V_39
    ,FirstOcc = V_40
    ,ReasMove = V_41.42
    
    ,CondoCoopStat = V_49
    ,Tenure_1 = V_50
    ,Tenure_2 = V_51
    ,LivedAtConvers = V_52
    ,ConversNonEvictPlan = V_53
    ,YrAcq = V_54.55
    ,UnitOccBeforeAcq = V_56
    ,CondoCoopBeforeAcq = V_57
    ,Price_1 = V_58.64
    ,Price_2 = V_65
    
    ,MnthlyCondoCoopFee = V_86.87
    
    ,UnitsBldg = V_98.99
    
    ,StoriesBldg = V_101.102
    ,ElevBldg = V_103
    ,Rooms = V_104
    ,Bedrooms = V_105.106
    
    ,LeaseLen = V_134
    ,MnthlyCntrctRent = V_135.139
    ,RentRegStatus = V_140
    
    ,PrevRented = V_162
    ,PrevMnthlyRent = V_163.166
    ,DHCR.Flag = V_167
    ,ProgramStatus = V_168.169
    ,ControlStatus.Recode = V_170.171
    ,Structure.Recode = V_172.173
    ,ScheduleCode = V_174.175
    ,SRO.Flag = V_176
    ,YearBuilt = V_177.178
    ,UnitCondition = V_179
    
    ,Tenure.Recode = V_186
    
    ,NumPersons.Recode = V_191.192
    
    ,MnthlyGrossRent = V_196.199
    
    ,BelowIncome.Recode = V_214
    ,TotalIncome = V_215.220
    ,TotalIncomeTopcode.Flag = V_221
    
    ,SubBorough = V_272.273
    
    ,TotalIncome.Recode = V_282.287
    
    ,Household.Weight = V_338.346
    ,Person.Weight = V_347.355
    ,SequenceNumber = V_356.361
    ,YearIdentifier = V_362.363
    ,LinkageIndicator = V_364
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = paste(19
                            ,ifelse(YrMovedIn<10
                                    ,as.character(paste(0,YrMovedIn,sep=""))
                                    ,as.character(YrMovedIn))
                            ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1991,"Y!"))
         ) %>% 
  select(-contains("V_"))


## 1993
df.93 <- df.list$occ93 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_35.36
    ,YrMovedIn = V_37.38
    ,BefAftJul71 = V_39
    ,FirstOcc = V_40
    ,ReasMove = V_41.42
    
    ,CondoCoopStat = V_49
    ,Tenure_1 = V_50
    ,Tenure_2 = V_51
    ,LivedAtConvers = V_52
    ,ConversNonEvictPlan = V_53
    ,YrAcq = V_54.55
    ,UnitOccBeforeAcq = V_56
    ,CondoCoopBeforeAcq = V_57
    ,Price_1 = V_58.64
    ,Price_2 = V_65
    
    ,MnthlyCondoCoopFee = V_86.87
    
    ,UnitsBldg = V_98.99
    
    ,StoriesBldg = V_101.102
    ,ElevBldg = V_103
    ,Rooms = V_104
    ,Bedrooms = V_105.106
    
    ,LeaseLen = V_134
    ,MnthlyCntrctRent = V_135.139
    ,RentRegStatus = V_140

    ,DHCR.Flag = V_167
    ,ProgramStatus = V_168.169
    ,ControlStatus.Recode = V_170.171
    ,Structure.Recode = V_172.173
    ,ScheduleCode = V_174.175
    ,SRO.Flag = V_176
    ,YearBuilt = V_177.178
    ,UnitCondition = V_179
    
    ,NumPersons.Recode = V_191.192
    ,MnthlyGrossRent = V_196.199
    
    ,BelowIncome.Recode = V_214

    ,SubBorough = V_272.273
    
    ,TotalIncome.Recode = V_215.220
    ,TotalIncomeTopcode.Recode.Flag = V_221
    
    ,Household.Weight = V_282.290
    ,Person.Weight = V_291.299
    ,SequenceNumber = V_300.305
    ,YearIdentifier = V_306.307
    ,LinkageIndicator = V_308
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = paste(19
                            ,ifelse(YrMovedIn<10
                                    ,as.character(paste(0,YrMovedIn,sep=""))
                                    ,as.character(YrMovedIn))
                            ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1993,"Y!"))
         ) %>% 
  select(-contains("V_"))

## 1996
df.96 <- df.list$occ96 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_35.36
    ,YrMovedIn = V_37.38
    ,BefAftJul71 = V_39
    ,FirstOcc = V_40
    ,ReasMove = V_41.42
    
    ,CondoCoopStat = V_49
    ,Tenure_1 = V_50
    ,Tenure_2 = V_51
    ,LivedAtConvers = V_52
    ,ConversNonEvictPlan = V_53
    ,YrAcq = V_54.55
    ,UnitOccBeforeAcq = V_56
    ,CondoCoopBeforeAcq = V_57
    ,Price_1 = V_58.64
    ,Price_2 = V_65
    
    ,MnthlyCondoCoopFee = V_86.87
    
    ,UnitsBldg = V_98.99
    
    ,StoriesBldg = V_101.102
    ,ElevBldg = V_103
    ,Rooms = V_104
    ,Bedrooms = V_105.106
    
    ,LeaseLen = V_134
    ,MnthlyCntrctRent = V_135.139
    ,RentRegStatus = V_140

    ,DHCR.Flag = V_167
    ,ProgramStatus = V_168.169
    ,ControlStatus.Recode = V_170.171
    ,Structure.Recode = V_172.173
    ,ScheduleCode = V_174.175
    ,SRO.Flag = V_176
    ,YearBuilt = V_177.178
    ,UnitCondition = V_179

    ,NumPersons.Recode = V_191.192
    ,MnthlyGrossRent = V_196.199
    
    ,BelowIncome.Recode = V_214

    ,SubBorough = V_272.273
    
    ,TotalIncome.Recode = V_215.220
    ,TotalIncomeTopcode.Recode.Flag = V_221
    
    ,Household.Weight = V_282.290
    ,Person.Weight = V_291.299
    ,SequenceNumber = V_300.305
    
    ,YearIdentifier = V_382.383
    ,LinkageIndicator = V_384
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = paste(19
                            ,ifelse(YrMovedIn<10
                                    ,as.character(paste(0,YrMovedIn,sep=""))
                                    ,as.character(YrMovedIn))
                            ,sep=""
         )
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1996,"Y!"))
         ) %>% 
  select(-contains("V_"))

## 1999 
df.99 <- df.list$occ99 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_41.42
    ,YrMovedIn = V_43.46
    ,BefAftJul71 = V_47
    ,FirstOcc = V_48
    ,ReasMove = V_49.50
    
    ,CondoCoopStat = V_57
    ,Tenure_1 = V_58
    ,Tenure_2 = V_59
    ,LivedAtConvers = V_60
    ,ConversNonEvictPlan = V_61
    ,YrAcq = V_62.65
    ,UnitOccBeforeAcq = V_66
    ,CondoCoopBeforeAcq = V_67
    ,Price_1 = V_68.74
    ,Price_2 = V_75
    
    ,MnthlyCondoCoopFee = V_96.97
    
    ,UnitsBldg = V_108.109
    
    ,StoriesBldg = V_111.112
    
    ,ElevBldg = V_115
    
    ,Rooms = V_118
    ,Bedrooms = V_119.120
    
    ,LeaseLen = V_148
    ,MnthlyCntrctRent = V_149.153
    ,RentRegStatus = V_154
    
    ,YrMoveNYC = V_201.204
    ,DHCR.Flag = V_205
    ,ProgramStatus = V_206.207
    ,ControlStatus.Recode = V_208.209
    ,Structure.Recode = V_210.211
    ,ScheduleCode = V_212.213
    ,SRO.Flag = V_214
    ,YearBuilt = V_215.216
    ,UnitCondition = V_217

    ,NumPersons.Recode = V_228.229
    
    ,MnthlyGrossRent = V_233.236
    
    ,BelowIncome.Recode = V_245
    
    ,SubBorough = V_302.303
    
    ,TotalIncome.Recode = V_246.251
    ,TotalIncomeTopcode.Recode.Flag = V_252
    
    ,Household.Weight = V_312.320
    ,Person.Weight = V_321.329
    ,SequenceNumber = V_330.335
    
    ,YearIdentifier = V_371.372
    ,LinkageIndicator = V_373
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(1999,"Y!"))
         ) %>% 
  select(-contains("V_"))



## 2002 
df.02 <- df.list$occ02 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_41.42
    ,YrMovedIn = V_43.46
    ,BefAftJul71 = V_47
    ,FirstOcc = V_48
    ,ReasMove = V_49.50
    
    ,CondoCoopStat = V_57
    ,Tenure_1 = V_58
    ,Tenure_2 = V_59
    ,LivedAtConvers = V_60
    ,ConversNonEvictPlan = V_61
    
    ,UnitOccBeforeAcq = V_66
    ,CondoCoopBeforeAcq = V_67
    
    ,MnthlyCondoCoopFee = V_96.97
    
    ,UnitsBldg = V_108.109
    
    ,StoriesBldg = V_111.112
    
    ,ElevBldg = V_115
    
    ,Rooms = V_118
    ,Bedrooms = V_119.120
    
    ,LeaseLen = V_148
    ,MnthlyCntrctRent = V_149.153
    ,RentRegStatus = V_154
    
    ,YrMoveNYC = V_206.209
    ,DHCR.Flag = V_210
    ,ProgramStatus = V_211.212
    ,ControlStatus.Recode = V_213.214
    ,Structure.Recode = V_215.216
    ,ScheduleCode = V_217.218
    ,SRO.Flag = V_219
    ,YearBuilt = V_220.221
    
    ,NumPersons.Recode = V_233.234
    
    ,MnthlyGrossRent = V_238.241
    
    ,BelowIncome.Recode = V_250
    
    ,SubBorough = V_315.316
    
    ,TotalIncome.Recode = V_251.257
    ,TotalIncomeTopcode.Recode.Flag = V_258
    
    ,Household.Weight = V_325.333
    ,Person.Weight = V_334.342
    ,SequenceNumber = V_343.348
    
    ,YearIdentifier = V_425.428
    ,LinkageIndicator = V_429
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(2002,"Y!"))
         ) %>% 
  select(-contains("V_"))


## 2005
df.05 <- df.list$occ05 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_61.62
    ,YrMovedIn = V_65.68
    ,BefAftJul71 = V_69
    ,FirstOcc = V_70
    ,ReasMove = V_71.72
    
    ,CondoCoopStat = V_79
    ,Tenure_1 = V_80
    ,Tenure_2 = V_81
    ,LivedAtConvers = V_82
    ,ConversNonEvictPlan = V_83
    
    ,UnitOccBeforeAcq = V_88
    ,CondoCoopBeforeAcq = V_89
    
    ,MnthlyCondoCoopFee = V_128.129
    
    ,UnitsBldg = V_140.141
    
    ,StoriesBldg = V_143.144
    
    ,ElevBldg = V_147
    
    ,Rooms = V_150
    ,Bedrooms = V_151.152
    
    ,LeaseLen = V_185
    ,MnthlyCntrctRent = V_186.190
    ,RentRegStatus = V_191
    
    ,YrMoveNYC = V_251.254
    ,DHCR.Flag = V_255
    ,ProgramStatus = V_256.257
    ,ControlStatus.Recode = V_260.261
    ,Structure.Recode = V_262.263
    ,ScheduleCode = V_264.265
    ,SRO.Flag = V_266
    ,YearBuilt = V_267.268
    
    ,NumPersons.Recode = V_283.284
    
    ,MnthlyGrossRent = V_288.291
    
    ,BelowIncome.Recode = V_300
    
    ,SubBorough = V_365.366
    
    ,TotalIncome.Recode = V_301.307
    ,TotalIncomeTopcode.Recode.Flag = V_308
    
    ,Household.Weight = V_377.385
    ,Person.Weight = V_386.394
    ,SequenceNumber = V_395.400
    
    ,YearIdentifier = V_429.432
    ,LinkageIndicator = V_433
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(2005,"Y!"))
         ) %>% 
  select(-contains("V_"))


## 2008
df.08 <- df.list$occ08 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_61.62
    ,YrMovedIn = V_65.68
    ,BefAftJul71 = V_69
    ,FirstOcc = V_70
    ,ReasMove = V_71.72
    
    ,CondoCoopStat = V_79
    ,Tenure_1 = V_80
    ,Tenure_2 = V_81
    ,LivedAtConvers = V_82
    ,ConversNonEvictPlan = V_83
    
    ,UnitOccBeforeAcq = V_88
    ,CondoCoopBeforeAcq = V_89
    
    ,MnthlyCondoCoopFee = V_128.129
    
    ,UnitsBldg = V_140.141
    
    ,StoriesBldg = V_143.144
    
    ,ElevBldg = V_147
    
    ,Rooms = V_150
    ,Bedrooms = V_151.152
    
    ,LeaseLen = V_185
    ,MnthlyCntrctRent = V_186.190
    
    ,YrMoveNYC = V_269.272
    
    ,DHCR.Flag = V_407
    ,ProgramStatus = V_408.409
    
    ,ControlStatus.Recode = V_412.413
    ,Structure.Recode = V_414.415
    ,ScheduleCode = V_416.417
    ,SRO.Flag = V_418
    ,YearBuilt = V_419.420
    
    ,NumPersons.Recode = V_440.441
    
    ,MnthlyGrossRent = V_445.448
    
    ,BelowIncome.Recode = V_457
    
    ,SubBorough = V_525.526
    
    ,TotalIncome.Recode = V_458.464
    ,TotalIncomeTopcode.Recode.Flag = V_465
    
    ,Household.Weight = V_538.546
    ,Person.Weight = V_547.555
    ,SequenceNumber = V_556.561
    
    ,YearIdentifier = V_599.603
    ,LinkageIndicator = V_604
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(2008,"Y!"))
         ) %>% 
  select(-contains("V_"))


## 2011 
df.11 <- df.list$occ11 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_61.62
    ,YrMovedIn = V_65.68
    ,BefAftJul71 = V_69
    ,FirstOcc = V_70
    ,ReasMove = V_71.72
    
    ,CondoCoopStat = V_79
    ,Tenure_1 = V_80
    ,Tenure_2 = V_81
    ,LivedAtConvers = V_82
    ,ConversNonEvictPlan = V_83
    
    ,UnitOccBeforeAcq = V_88
    ,CondoCoopBeforeAcq = V_89
    
    ,MnthlyCondoCoopFee = V_128.129
    
    ,UnitsBldg = V_140.141
    
    ,StoriesBldg = V_143.144
    
    ,ElevBldg = V_147
    
    ,Rooms = V_150
    ,Bedrooms = V_151.152
    
    ,LeaseLen = V_196
    ,MnthlyCntrctRent = V_191.195
    
    ,YrMoveNYC = V_276.279
    
    ,DHCR.Flag = V_407
    ,ProgramStatus = V_408.409
    
    ,ControlStatus.Recode = V_412.413
    ,Structure.Recode = V_414.415
    ,ScheduleCode = V_416.417
    
    ,YearBuilt = V_419.420
    
    ,NumPersons.Recode = V_440.441
    
    ,MnthlyGrossRent = V_445.449
    
    ,BelowIncome.Recode = V_458
    
    ,SubBorough = V_526.527
    
    ,TotalIncome.Recode = V_459.465
    ,TotalIncomeTopcode.Recode.Flag = V_466
    
    ,Household.Weight = V_538.546
    ,Person.Weight = V_547.555
    ,SequenceNumber = V_556.561
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,YrMovedIn = year(parse_date_time(YrMovedIn,"Y!"))
         ,SurveyYear = year(parse_date_time(2011,"Y!"))
         ) %>% 
  select(-contains("V_"))





## 2014
df.14 <- df.list$occ14 %>%
# df.14 <- df.list.hold2$occ14 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,MostRecLived6Mon = V_61.62
    ,YrMovedIn = V_65.68
    ,BefAftJul71 = V_69
    ,FirstOcc = V_70
    ,ReasMove = V_71.72
    ,PlaceBirth = V_73.74
    
    ,CondoCoopStat = V_79
    ,Tenure_1 = V_80
    ,Tenure_2 = V_81
    ,LivedAtConvers = V_82
    ,ConversNonEvictPlan = V_83
    
    ,UnitOccBeforeAcq = V_88
    ,CondoCoopBeforeAcq = V_89
    
    ,MnthlyCondoCoopFee = V_128.129
    
    ,UnitsBldg = V_140.141
    
    ,StoriesBldg = V_143.144
    
    ,ElevBldg = V_147
    
    ,Rooms = V_150
    ,Bedrooms = V_151.152
    
    ,LeaseLen = V_196
    ,MnthlyCntrctRent = V_191.195
    
    ,YrMoveNYC = V_276.279
    
    ,DHCR.Flag = V_407
    ,ProgramStatus = V_408.409
    
    ,ControlStatus.Recode = V_412.413
    ,Structure.Recode = V_414.415
    ,ScheduleCode = V_416.417
    
    ,YearBuilt = V_419.420
    
    ,NumPersons.Recode = V_440.441
    
    ,MnthlyGrossRent = V_445.449
    
    ,BelowIncome.Recode = V_458
    
    ,SubBorough = V_526.527
    
    ,TotalIncome.Recode = V_459.465
    ,TotalIncomeTopcode.Recode.Flag = V_466
    
    ,Household.Weight = V_538.546
    ,Person.Weight = V_547.555
    ,SequenceNumber = V_556.561
  ) %>% 
  mutate(Household.Weight = Household.Weight * .00001
         ,SurveyYear = year(parse_date_time(2014,"Y!"))
         ) %>% 
  select(-contains("V_"))


# df.list <- list(
#   df.91
#   ,df.93
#   ,df.96
#   ,df.99
#   ,df.02
#   ,df.05
#   ,df.08
#   ,df.11
#   ,df.14
# )



df.list <- list(
  df.list.81_87$occ81
  ,df.list.81_87$occ84
  ,df.list.81_87$occ87
  ,df.91
  ,df.93
  ,df.96
  ,df.99
  ,df.02
  ,df.05
  ,df.08
  ,df.11
  ,df.14
)

names(df.list) <- c(
  "occ81"
  ,"occ84"
  ,"occ87"
  ,"occ91"
  ,"occ93"
  ,"occ96"
  ,"occ99"
  ,"occ02"
  ,"occ05"
  ,"occ08"
  ,"occ11"
  ,"occ14"
)


getwd()
setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS")
saveRDS(df.list,"df_list_occ.rds")


# necc.cols <- c("Borough","CondoCoopStat","Tenure_1","Tenure_2","Household.Weight","Person.Weight","SequenceNumber","year")


# lapply(df.list, function(x) colnames(x))
# 
# lapply(df.list, function(x) 
#   sum(
#     !necc.cols %in% 
#       colnames(x)
#   )
# )


# df_small.list <- lapply(df.list, function(x)
#   x[,necc.cols]
#   )



