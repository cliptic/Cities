
# install.packages('ClusterR')
# library(ClusterR)


# KMdata <- read.csv("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/KMdata/CFDATA20180506.csv")
KMdata <- CFDATA
KMdata$CAPITAL_CI <- as.numeric(as.character(KMdata$CAPITAL_CI))
KMdata$CITY_IN_KE <- as.numeric(as.character(KMdata$CITY_IN_KE))

# KMdata$URAU_CODE <- NULL
KMdata$FUA_CODE <- NULL
KMdata$CNTR_CODE <- NULL
# KMdata$URAU_NAME <- NULL
KMdata$NUTS3_2010 <- NULL
KMdata$NUTS3_2006 <- NULL
KMdata$POPcity2006 <- NULL
KMdata$POPfua2006 <- NULL
KMdata$POPcity2009 <- NULL
KMdata$POPproportioninCITY2006 <- NULL
KMdata$NoUMZinCITYarea <- NULL
KMdata$NoUMZinFUAarea <- NULL
KMdata$City_A <- NULL
KMdata$Trans2012c <- NULL 
KMdata$X <- NULL
KMdata$CommuteIn <- NULL
KMdata$CommuteOut <- NULL
KMdata$LengthBicycleNetwork <- NULL
KMdata$FootJourn2011 <- NULL
KMdata$Carjourneyshare2011 <- NULL
KMdata$PubTrShare2011 <- NULL
KMdata$BicJourn2011 <- NULL
KMdata$Commute <- NULL

KMdata <- KMdata[!KMdata$URAU_CODE == "ES514C1", ]

KMdataset <- na.omit(KMdata)

################################# K Means ##################################3
KM <- KMdataset



KM$URAU_CODE <- NULL
KM$URAU_NAME <- NULL

###################
# STANDARDIZATION #
###################

# function center_scale form an R package "ClusterR" for Z-scores
KMst <- center_scale(KM, mean_center = TRUE, sd_scale = TRUE)
# write.csv(KM3, "KM3.csv")

####################
# OPTIMAL NUMBER K #
####################

# KM4 <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/KMdata/KM4.xls")
# KM4$X__1 <- NULL

# KM5 <- read.csv("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/KMdata/KM5.csv")
# KM5$X <- NULL
# KM5 <- na.omit(KM5)
# KM5st <- center_scale(KM3, mean_center = TRUE, sd_scale = TRUE)
# F-values with variance_explained in a function Optimal_Clusters_KMeans 

####
#define data set

dataset <- KM
datasetST <- as.data.frame(KMst )


 FvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "variance_explained", num_init = 10, max_iters = 100, plot_clusters = TRUE)
FvaluesNOofCLUSTERS

FvaluesNOofCLUSTERS_st <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "variance_explained", num_init = 10, max_iters = 100, plot_clusters = TRUE)
FvaluesNOofCLUSTERS_st

# WCSSE in the function Optimal_Clusters_KMeans 
WCSSEvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "WCSSE", num_init = 10, max_iters = 100, plot_clusters = TRUE)
WCSSEvaluesNOofCLUSTERS

WCSSEvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "WCSSE", num_init = 10, max_iters = 100, plot_clusters = TRUE)
WCSSEvaluesNOofCLUSTERS

# Optimal_Clusters_KMeans has this criterion incorporated as dissimilarity
DISSvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "dissimilarity", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISSvaluesNOofCLUSTERS

DISSvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "dissimilarity", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISSvaluesNOofCLUSTERS
# Function criterion silhouette in a function Optimal_Clusters_KMeans

SILvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "silhouette", num_init = 10, max_iters = 100, plot_clusters = TRUE)
SILvaluesNOofCLUSTERS

SILvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "silhouette", num_init = 10, max_iters = 100, plot_clusters = TRUE)
SILvaluesNOofCLUSTERS
# distribution_fK in a function Optimal_Clusters_KMeans 

DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "distortion_fK", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "distortion_fK", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

# AIC, 
DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "AIC", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "AIC", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

# BIC and 
DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "BIC", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "BIC", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS
# Adjusted_Rsquared
DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(dataset, max_clusters = 30, criterion = "Adjusted_Rsquared", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

DISTvaluesNOofCLUSTERS <- Optimal_Clusters_KMeans(datasetST, max_clusters = 30, criterion = "Adjusted_Rsquared", num_init = 10, max_iters = 100, plot_clusters = TRUE)
DISTvaluesNOofCLUSTERS

##### CLUSTER KMEANS

KMresults <- KMeans_rcpp(KMst, 8, num_init = 5, max_iters = 100, initializer = "optimal_init", fuzzy = FALSE)

#####

??KMeans_arma
#  "ClusterR" predict_KMeans can take information of an additional point and define a cluster that the new data point belongs to
KMdatasetST <- datasetST
KMdatasetST$cluster <- KMresults$clusters



### 

KMresults[6]


KMst_res_means <- as.data.frame( KMresults[2], integer.as.numeric = TRUE)
write.csv(KMst_res_means, "KM_res_meansST02.csv")

KMdataset$cluster <- KMresults$clusters
write.csv(KMdataset, "originaldataset.csv")


write.csv(KM, "KMdataset02.csv")
write.csv(KMdataset, "KMdatasetST02.csv")

write.csv(KMdataset, "KMdataset03cl.csv")
#