###############################################
#
# Script to read in single column csvs containing fwf
# variable positions in NYCHVS microdata
#
###############################################

library(stringr)



setwd("/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/variable position csvs")
varpos.files <- list.files(pattern=".csv")
varpos.files <- varpos.files[grepl("vac_",varpos.files)]

readin.list <- list()
# x <- 2
for(x in 1:length(varpos.files)){
  # target.file <- "/Users/billbachrach/Dropbox (hodgeswardelliott)/hodgeswardelliott Team Folder/Teams/Data/Bill Bachrach/Data Sources/HVS/converted excel files/variable position csvs/HVS_varpos_vac_1991_b.csv"
  target.file <- varpos.files[x]
  
  readin_test.vec <- read.csv(target.file
                              ,stringsAsFactors=F
                              ,header=F)
  
  # ?grepl
  empty <- !grepl("[^[:blank:]]",readin_test.vec[,1])
  readin_test.vec[empty,1] <- readin_test.vec[empty,2]
  readin_test.vec <- readin_test.vec[,1]


  ## remove all instances where there is an alpha character or is not a digit character
  drops <- grepl("=",readin_test.vec) | 
    grepl("[[:alpha:]]",readin_test.vec) | 
    grepl("\\|",readin_test.vec) |
    !grepl("[[:digit:]]", readin_test.vec)
  
  readin_test.vec <- readin_test.vec[!drops]
  
  ## remainder should be in the format <start digit>-<end digit> or <digit>
  ## splitting on "-" and creating matrix with start digit and end digit
  readin.93 <- as.data.frame(
    str_split_fixed(readin_test.vec,"-",n=2)
    ,stringsAsFactors=F)
  colnames(readin.93) <- c("start","stop")
  
  ## if end digit cell is empty, replace with start digit
  restr <- !grepl("[[:digit:]]",readin.93[,2])
  readin.93[restr,2] <- readin.93[restr,1]
  
  ## make both numeric
  readin.93[,1] <- as.numeric(readin.93[,1])
  readin.93[,2] <- suppressWarnings(as.numeric(readin.93[,2]))
  
  ## there will be instances of NA coercion in the second column, removing those observations
  drops <- is.na(readin.93[,1]) | is.na(readin.93[,2])
  readin.93 <- readin.93[!drops,]
  
  ## creating width variable
  ## using instances where width is NA or is less than one as a sense check, deleting those observations
  readin.93[,"width"] <- readin.93[,"stop"] - readin.93[,"start"] + 1
  drops <- is.na(readin.93[,"width"]) | readin.93[,"width"] < 1
  readin.93 <- readin.93[!drops,]
  
  
  ## last sense check. each end digit should be less than the start digit after it
  # drops <- c(FALSE,
  #            unlist(
  #              lapply(2:nrow(readin.93), function(x){
  #                readin.93[x,1] <= readin.93[x-1,2]
  #              })
  #            )
  # )
  # 
  # drops <- which(
  #   c(FALSE,
  #     unlist(
  #       lapply(2:nrow(readin.93), function(x){
  #         readin.93[x,1] <= readin.93[x-1,2]
  #       })
  #     )
  #   )
  # )
  
  i <- 2
  while(i <= nrow(readin.93)){
    if(readin.93[i,1] <= readin.93[i-1,2]){
      readin.93 <- readin.93[-i,]
      cat("found one\n")
      i <- i
    } else { 
      i <- i + 1
    }
    cat(i,"\n")
  }

  #   for(i in 2:nrow(readin.93)){
  #     if(readin.93[i,1] <= readin.93[i-1,2]){
  #       readin.93 <- readin.93[-i,]
  #       cat("found one\n")
  #     }
  #     cat(i,"\n")
  #   }
  # 
  # for(i in 2:nrow(readin.93)){
  #   if(readin.93[i,1] <= readin.93[i-1,2]){
  #     readin.93 <- readin.93[-i,]
  #     cat("found one\n")
  #   }
  #   cat(i,"\n")
  # }
  # 
  # for(i in 2:nrow(readin.93)){
  #   if(readin.93[i,1] <= readin.93[i-1,2]){
  #     readin.93 <- readin.93[-i,]
  #     cat("found one\n")
  #   }
  #   cat(i,"\n")
  # }
   

  
  # readin.93 <- lessthan_clean(readin.93)
  
  # readin.93 <- readin.93[!drops,]
  
  ## combining into dataframe. if record type variable isn't present, inserting it
  if(readin.93[1,1] != 1){
    readin.93 <- as.data.frame(
      rbind(
        c(1
          ,readin.93[1,1] - 1
          ,readin.93[1,1] - 1
          )
        ,readin.93
      )
                               ,stringsAsFactors=F
      )
    
    colnames(readin.93) <= c("start","stop","width")
  }
  
  ## creating variable names consisting of start digit and end digit
  varnames <- ifelse(readin.93[,1]==readin.93[,2],
                     readin.93[,1]
                     ,paste(readin.93[,1]
                            ,readin.93[,2]
                            ,sep="."))
  readin.93[,"varname"] <- paste("V_",varnames,sep="")

  readin.list[[x]] <- readin.93
  cat(x,"\n")
}

## assigning list names
names(readin.list) <- gsub(".csv",""
                           ,varpos.files
)

# do.call("rbind",
#         lapply(readin.list, function(x)
#           cbind(
#             x[nrow(x),2] 
#             ,sum(x[,"width"])
#           )
#         )
# )
# 
# readin.list[[2]]

## check resulting dataframes 
# View(readin.list[[1]])
# Sys.sleep(.25)
# View(readin.list[[2]])
# Sys.sleep(.25)
# View(readin.list[[3]])
# Sys.sleep(.25)
# View(readin.list[[4]])
# Sys.sleep(.25)
# View(readin.list[[5]])
# Sys.sleep(.25)
# View(readin.list[[6]])
# Sys.sleep(.25)
# View(readin.list[[7]])
# Sys.sleep(.25)
# View(readin.list[[8]])
# Sys.sleep(.25)
# View(readin.list[[9]])

gsub("variable position csvs"
     ,"variable position cleaned"
     ,getwd()
)

setwd(
  gsub("variable position csvs"
           ,"variable position cleaned"
           ,getwd()
)
)

## writing csvs and saving rds list
for(i in 1:length(readin.list)){
  write.csv(readin.list[[i]], file=
              paste("vac_"
                ,gsub("vac_","",names(readin.list)[i])
                    ,".csv"
                    ,sep="")
            )
}

saveRDS(readin.list,"vac_var_position_readinlist.rds")
