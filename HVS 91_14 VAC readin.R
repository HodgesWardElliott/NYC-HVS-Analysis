###############################################
#
# Read in fixed width files using variable position readin tables 
# Select and rename columns of interest 
#
###############################################


library(dplyr)

setwd(gsub("NYC_HVS Analysis.*"
           ,"NYC_HVS Analysis"
           ,getwd()
           ))
setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/Git/NYC_HVS Analysis")

readin.list <- readRDS("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/variable position cleaned/vac_var_position_readinlist.rds")

abrv.yr <- substr(names(readin.list)
       ,start=nchar(names(readin.list))-1
       ,stop=nchar(names(readin.list))
       )

## get paths for available occ fixed width files
fwf.files <- list.files("vac_fwf_files", pattern=".txt")
fwf.files <- paste("vac_fwf_files",fwf.files[grepl("vac",fwf.files)],sep="/")

## years for each
fwf.yr <- gsub("[^[:digit:]]","",fwf.files)

df.list <- list()
for(i in 1:length(fwf.files)){
  
  ## select appropriate item in the readin table list
  readin.table <- as.data.frame(
    readin.list[which(abrv.yr==fwf.yr[i])]
    ,stringsAsFactors=F
    )

  ## there was some issue with the readintable colnames being screwy, not sure what happened to it
  ## this should be harmless if the column names are appropriate so leaving it in 
  colnames(readin.table) <- gsub(".*\\.","",colnames(readin.table))
  

  df <- read.fwf(fwf.files[i]
                 ,header=F
                 ,widths=readin.table[,"width"]
                 # ,col.names=readin.table[,""]
                 )
  colnames(df) <- readin.table[,"varname"]
  
  ## there's already a survey year column, but the format varies
  ## dropping in another to be on the safe side
  df[,"year"] <- fwf.yr[i]
  
  df.list[[i]] <- df
  
  cat(i,"\n")
}

## assigning names to list items
names(df.list) <- gsub(
  "vac_fwf_files/"
  ,""
  ,gsub(".txt","",fwf.files)
)

df.list.hold <- df.list

##
### Selecting and naming variables according to the layout documentation
##

## 1991
df.91 <- df.list$vac91 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_27
    
    ,UnitsBldg = V_29.30
    
    ,CondoCoopStat = V_43
    ,DurVac = V_44
    ,StatPriorVac = V_45
    ,CondoCoopStatPriorVac = V_46
    ,Status = V_47
    ,Reason = V_48.49

    ,DHCR.Flag = V_54
    ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_57.58
    ,Structure.Recode = V_59.60
    ,ScheduleCode = V_61.62
    ,SRO.Flag = V_63
    ,YearBuilt = V_64.65
    
    ,UnitCondition = V_70
    
    ,SubBorough = V_71.72
    ,SequenceNumber = V_73.78
    ,Household.Weight = V_79.87
    ,YearIdentifier = V_88.89
    ,LinkageIndicator = V_90
  ) %>% 
  select(-contains("V_"))


## 1993
df.93 <- df.list$vac93 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_27
    
    ,UnitsBldg = V_29.30
    
    ,CondoCoopStat = V_43
    ,DurVac = V_44
    ,StatPriorVac = V_45
    ,CondoCoopStatPriorVac = V_46
    ,Status = V_47
    ,Reason = V_48.49
    
    ,DHCR.Flag = V_54
    ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_57.58
    ,Structure.Recode = V_59.60
    ,ScheduleCode = V_61.62
    ,SRO.Flag = V_63
    ,YearBuilt = V_64.65
    
    ,UnitCondition = V_70
    
    ,SubBorough = V_71.72
    ,SequenceNumber = V_73.78
    ,Household.Weight = V_79.87
    ,YearIdentifier = V_88.89
    ,LinkageIndicator = V_90
  ) %>% 
  select(-contains("V_"))



## 1996
df.96 <- df.list$vac96 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_27
    
    ,UnitsBldg = V_29.30
    
    ,CondoCoopStat = V_43
    ,DurVac = V_44
    ,StatPriorVac = V_45
    ,CondoCoopStatPriorVac = V_46
    ,Status = V_47
    ,Reason = V_48.49
    
    ,DHCR.Flag = V_54
    ,ProgramStatus = V_55.56
    ,ControlStatus.Recode = V_57.58
    ,Structure.Recode = V_59.60
    ,ScheduleCode = V_61.62
    ,SRO.Flag = V_63
    ,YearBuilt = V_64.65
    
    ,UnitCondition = V_70
    
    ,SubBorough = V_71.72
    ,SequenceNumber = V_73.78
    ,Household.Weight = V_79.87
    
    ,YearIdentifier = V_110.111
    ,LinkageIndicator = V_112
  ) %>% 
  select(-contains("V_"))


## 1999 
df.99 <- df.list$vac99 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    ,ControlStatus.Recode = V_66.67
    ,Structure.Recode = V_68.69
    ,ScheduleCode = V_70.71
    ,SRO.Flag = V_72
    ,YearBuilt = V_73.74
    
    ,UnitCondition = V_80
    ,SubBorough = V_81.82
    ,SequenceNumber = V_83.88
    ,Household.Weight = V_89.97
    
    ,YearIdentifier = V_107.108
    ,LinkageIndicator = V_109
  ) %>% 
  select(-contains("V_"))



## 2002 
df.02 <- df.list$vac02 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    # ,ControlStatus.Recode = V_66.67
    ,Structure.Recode = V_68.69
    ,ScheduleCode = V_70.71
    ,SRO.Flag = V_72
    ,YearBuilt = V_73.74
    
    ,UnitCondition = V_80
    ,SubBorough = V_81.82
    ,SequenceNumber = V_83.88
    ,Household.Weight = V_89.97
    
    ,ControlStatus.Recode = V_98.99
    
    ,YearIdentifier = V_109.112
    ,LinkageIndicator = V_113
  ) %>% 
  select(-contains("V_"))


## 2005
df.05 <- df.list$vac05 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    # ,ControlStatus.Recode = V_66.67
    ,Structure.Recode = V_68.69
    ,ScheduleCode = V_70.71
    ,SRO.Flag = V_72
    ,YearBuilt = V_73.74
    
    ,UnitCondition = V_82
    ,SubBorough = V_83.84
    ,SequenceNumber = V_85.90
    ,Household.Weight = V_91.99
    
    ,ControlStatus.Recode = V_100.101
    
    ,YearIdentifier = V_108.111
    ,LinkageIndicator = V_112
  ) %>% 
  select(-contains("V_"))


## 2008
df.08 <- df.list$vac08 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    ,ControlStatus.Recode = V_68.69
    ,Structure.Recode = V_70.71
    ,ScheduleCode = V_72.73
    ,SRO.Flag = V_74
    ,YearBuilt = V_75.76
    
    ,UnitCondition = V_84
    ,SubBorough = V_85.86
    ,SequenceNumber = V_87.92
    ,Household.Weight = V_93.101
    
    # ,ControlStatus.Recode = V_100.101
    
    ,YearIdentifier = V_108.111
    ,LinkageIndicator = V_112
  ) %>% 
  select(-contains("V_"))


## 2011 
df.11 <- df.list$vac11 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    ,ControlStatus.Recode = V_68.69
    ,Structure.Recode = V_70.71
    ,ScheduleCode = V_72.73
    ,SRO.Flag = V_74
    ,YearBuilt = V_75.76
    
    ,UnitCondition = V_84
    ,SubBorough = V_85.86
    ,SequenceNumber = V_87.92
    ,Household.Weight = V_93.101
    
    # ,ControlStatus.Recode = V_100.101
    
    # ,YearIdentifier = V_108.111
    # ,LinkageIndicator = V_112
  ) %>% 
  select(-contains("V_"))

## 2014
df.14 <- df.list$vac14 %>% 
  rename(
    RecType = V_1
    ,Borough = V_2
    
    ,VacUnitRespond = V_31
    
    ,UnitsBldg = V_33.34
    
    ,CondoCoopStat = V_51
    ,DurVac = V_52
    ,StatPriorVac = V_53
    ,CondoCoopStatPriorVac = V_54
    ,Status = V_55
    ,Reason = V_56.57
    
    ,DHCR.Flag = V_63
    ,ProgramStatus = V_64.65
    ,ControlStatus.Recode = V_68.69
    ,Structure.Recode = V_70.71
    ,ScheduleCode = V_72.73
    ,SRO.Flag = V_74
    ,YearBuilt = V_75.76
    
    ,UnitCondition = V_84
    ,SubBorough = V_85.86
    ,SequenceNumber = V_87.92
    ,Household.Weight = V_93.101
    
    # ,ControlStatus.Recode = V_100.101
    
    # ,YearIdentifier = V_108.111
    # ,LinkageIndicator = V_112
  ) %>% 
  select(-contains("V_"))


df.list <- list(
  df.91
  ,df.93
  ,df.96
  ,df.99
  ,df.02
  ,df.05
  ,df.08
  ,df.11
  ,df.14
)

names(df.list) <- 
  c(
    "df.91"
    ,"df.93"
    ,"df.96"
    ,"df.99"
    ,"df.02"
    ,"df.05"
    ,"df.08"
    ,"df.11"
    ,"df.14"
  )

saveRDS(df.list,file=
          paste(
            "vac_df_1991_2014 "
            ,format(Sys.time()
                    ,"%Y%m%d_%H%M")
            ,".rds"
            ,sep=""
          )
        )

