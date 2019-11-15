# fixing an antivirus problem for pckg installation
# trace(utils:::unpackPkgZip, edit=TRUE)
# edit line 142: Sys.sleep(0.5) to Sys.sleep(2)

# install.packages("readxl")
# library(readxl)

###################################### URAU BASE ######################################


########################################       ########################################
########################################  UMZ  ########################################
########################################       ########################################

UMZURBAUdata <- read_excel("D:/DATA/PICKED/QGIS/UMZURBAUdata.xlsx", 
                           sheet = "Sheet3")
UMZURBAUdata2 <- read_excel("D:/DATA/PICKED/QGIS/UMZURBAUdata.xlsx", 
                            sheet = "Attributes")

DATA <- merge(UMZURBAUdata2, UMZURBAUdata, by.x = "URAU_CODE", by.y = "URAU_CODE", all.y = TRUE)

# deleting NA lines
# FUAdata <- FUAdata[!is.na(FUAdata$id_mua),]

#change to 1 and 0
DATA$CAPITAL_CI[is.na(DATA$CAPITAL_CI)] <- 0
DATA$CAPITAL_CI[!(DATA$CAPITAL_CI==0)] <- 1

DATA$CITY_IN_KE[is.na(DATA$CITY_IN_KE)] <- 0
DATA$CITY_IN_KE[!(DATA$CITY_IN_KE==0)] <- 1
DATA$URAU_CATG.y <- NULL

# Filter by NA 
# CityDATA <- DATA[!is.na(DATA$FUA_CODE),]

# Filter by variable meaning
CityDATA <- DATA[DATA$URAU_CATG.x == "C",]
CityDATA$URAU_CATG.x <- NULL
FuaDATA <- DATA[DATA$URAU_CATG.x == "F",]
FuaDATA$URAU_CATG.x <- NULL
FuaDATA$CNTR_CODE <- NULL
FuaDATA$CAPITAL_CI <- NULL
FuaDATA$URAU_NAME <- NULL
FuaDATA$FUA_CODE <- NULL
FuaDATA$CITY_IN_KE <- NULL
FuaDATA$NUTS3_2010 <- NULL
FuaDATA$NUTS3_2006 <- NULL

# change column names
names(CityDATA) <- sub("noUMZinL", "NoUMZinCITYarea", names(CityDATA))
names(CityDATA) <- sub("UMZareainside", "UMZareainCITY", names(CityDATA))
names(CityDATA) <- sub("AREA_SQM", "CityAREA", names(CityDATA))
names(FuaDATA) <- sub("noUMZinL", "NoUMZinFUAarea", names(FuaDATA))
names(FuaDATA) <- sub("UMZareainside", "UMZareainFUA", names(FuaDATA))
names(FuaDATA) <- sub("AREA_SQM", "FUAarea", names(FuaDATA))
# change ha to sqm
CityDATA$UMZareainCITY <- CityDATA$UMZareainCITY * 10000
FuaDATA$UMZareainFUA <- FuaDATA$UMZareainFUA * 10000
CityDATA$NoUMZinCITYarea <- NULL
FuaDATA$NoUMZinFUAarea <- NULL

########################################       ########################################
########################################  WUP  ########################################
########################################       ########################################

WUPcityDATA <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/WUPcityDATA.xls")
names(WUPcityDATA) <- sub("POP", "CityPOP2012", names(WUPcityDATA))
names(WUPcityDATA) <- sub("urban_area", "City_UA", names(WUPcityDATA))
names(WUPcityDATA) <- sub("unit_area", "City_A", names(WUPcityDATA))
names(WUPcityDATA) <- sub("PBA", "PBAcity", names(WUPcityDATA))
names(WUPcityDATA) <- sub("DIS", "DIScity", names(WUPcityDATA))
names(WUPcityDATA) <- sub("UP", "UPcity", names(WUPcityDATA))
names(WUPcityDATA) <- sub("UD", "UDcity", names(WUPcityDATA))
WUPcityDATA$TS <- NULL
WUPcityDATA$UDcity <- NULL

# START collecting CFDATA set
CFDATA <- merge(CityDATA, FuaDATA, by.x = "FUA_CODE", by.y = "URAU_CODE", sort = FALSE)
CFDATA <- merge(CFDATA, WUPcityDATA, by = "URAU_CODE", sort = FALSE)

###### POP

CITYpop <- read.csv("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/POPcityDATA.csv")
FUApop <- read.csv("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/POPfuaDATA.csv")
CITYpop$X <- NULL
FUApop$X <- NULL

CFDATA <- merge(CFDATA, CITYpop, by.x = "URAU_CODE", by.y = "Group.1", sort = FALSE)
CFDATA <- merge(CFDATA, FUApop, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)

CityAreainFUA <- aggregate(CFDATA$CityAREA, by = list(CFDATA$FUA_CODE), FUN = sum)
names(CityAreainFUA) <- sub("x", "CityAreainFUA", names(CityAreainFUA))
CFDATA <- merge(CFDATA, CityAreainFUA, by.x = 'FUA_CODE', by.y = 'Group.1')

CFDATA$CityAreainFUA <- CFDATA$CityAreainFUA / CFDATA$FUAarea * 100

CFDATA$POPproportioninCITY2006 <- CFDATA$POPcity2006 / CFDATA$POPfua2006 * 100
CFDATA$POPproportioninCITY2009 <- CFDATA$POPcity2009 / CFDATA$POPfua2009 * 100

CFDATA$POPch20062012 <- (CFDATA$CityPOP2012 - CFDATA$POPcity2006)/CFDATA$POPcity2006 * 100
CFDATA$chPROPORTION20062006 <- CFDATA$POPproportioninCITY2009 - CFDATA$POPproportioninCITY2006 

#########################################################
#######################################  green  #######################################

# change UMZ area to ratio with total unit area %
CFDATA$UMZtoCITYarea <- CFDATA$UMZareainCITY / CFDATA$CityAREA * 100
CFDATA$UMZtoFUAarea <- CFDATA$UMZareainFUA / CFDATA$FUAarea * 100
CFDATA$UMZareainCITY <- NULL
CFDATA$UMZareainFUA <- NULL
# CFDATA$NUTS3_2006 <- NULL
# CFDATA$NUTS3_2010 <- NULL

#####################################################################
####################### ENVIRONMENTAL DATA ##########################
#####################################################################

ENVdata <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/ENVdata.xlsx")

# merge to CFDATA
CFDATA <- merge(CFDATA, ENVdata, by.x = "URAU_CODE", by.y = "URAU_CODE", all.x = TRUE, sort = FALSE)
CFDATA$Rain <- CFDATA$Rain / 10
################################# CORINE #################################

#### FUA agricultural areas
Agriculture2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                         sheet = "Agriculture2012f")
Agriculture2012f <- aggregate(Agriculture2012f$AREA, by = list(Agriculture2012f$URAU_CODE), FUN = sum)
names(Agriculture2012f) <- sub("x", "Agriculture2012f", names(Agriculture2012f))

#### FUA Continuous urban fabric
ContUrb2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "ContUrb2012f")
ContUrb2012f <- aggregate(ContUrb2012f$Shape_Area, by =  list(ContUrb2012f$URAU_CODE), FUN = sum)
names(ContUrb2012f) <- sub("x", "ContUrb2012f", names(ContUrb2012f))

#### CITY Continuous urban fabric
ContUrb2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                           sheet = "ContUrb2012c")
ContUrb2012c <- aggregate(ContUrb2012c$Shape_Area, by =  list(ContUrb2012c$URAU_CODE), FUN = sum)
names(ContUrb2012c) <- sub("x", "ContUrb2012c", names(ContUrb2012c))

#### FUA discontinuous urban fabric
DiscontUrb2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                           sheet = "DiscontUrb2012f")
DiscontUrb2012f <- aggregate(DiscontUrb2012f$Shape_Area, by =  list(DiscontUrb2012f$URAU_CODE), FUN = sum)
names(DiscontUrb2012f) <- sub("x", "DiscontUrb2012f", names(DiscontUrb2012f))

#### CITY discontinuous urban fabric
DiscontUrb2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "DiscontUrb2012c")
DiscontUrb2012c <- aggregate(DiscontUrb2012c$Shape_Area, by =  list(DiscontUrb2012c$URAU_CODE), FUN = sum)
names(DiscontUrb2012c) <- sub("x", "DiscontUrb2012c", names(DiscontUrb2012c))

#### FUA Industrial and economic units
Industrial2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "Industrial2012f")
Industrial2012f <- aggregate(Industrial2012f$Shape_Area, by =  list(Industrial2012f$URAU_CODE), FUN = sum)
names(Industrial2012f) <- sub("x", "Industrial2012f", names(Industrial2012f))

#### CITY Industrial and economic units
Industrial2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "Industrial2012c")
Industrial2012c <- aggregate(Industrial2012c$Shape_Area, by =  list(Industrial2012c$URAU_CODE), FUN = sum)
names(Industrial2012c) <- sub("x", "Industrial2012c", names(Industrial2012c))

#### CITY Transport
Trans2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "Trans2012c")
Trans2012c <- aggregate(Trans2012c$Shape_Area, by =  list(Trans2012c$URAU_CODE), FUN = sum)
names(Trans2012c) <- sub("x", "Trans2012c", names(Trans2012c))

#### FUA Wetlands
wetlands2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                         sheet = "wetlands2012f")
wetlands2012f <- aggregate(wetlands2012f$Shape_Area, by =  list(wetlands2012f$URAU_CODE), FUN = sum)
names(wetlands2012f) <- sub("x", "wetlands2012f", names(wetlands2012f))

#### FUA Vegetation
Vegetation2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                            sheet = "Vegetation2012f")
Vegetation2012f <- aggregate(Vegetation2012f$Shape_Area, by =  list(Vegetation2012f$URAU_CODE), FUN = sum)
names(Vegetation2012f) <- sub("x", "Vegetation2012f", names(Vegetation2012f))

#### CITY Vegetation
Vegetation2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                          sheet = "Vegetation2012c")
Vegetation2012c <- aggregate(Vegetation2012c$Shape_Area, by =  list(Vegetation2012c$URAU_CODE), FUN = sum)
names(Vegetation2012c) <- sub("x", "Vegetation2012c", names(Vegetation2012c))

#### CITY Green Urban areas
GreenUrb2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                              sheet = "GreenUrb2012c")
GreenUrb2012c <- aggregate(GreenUrb2012c$Shape_Area, by =  list(GreenUrb2012c$URAU_CODE), FUN = sum)
names(GreenUrb2012c) <- sub("x", "GreenUrb2012c", names(GreenUrb2012c))

#### CITY bare lands
BARE2012c <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                            sheet = "BARE2012c")
BARE2012c <- aggregate(BARE2012c$Shape_Area, by =  list(BARE2012c$URAU_CODE), FUN = sum)
names(BARE2012c) <- sub("x", "BARE2012c", names(BARE2012c))

#### FUA bare lands
BARE2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                            sheet = "BARE2012f")
BARE2012f <- aggregate(BARE2012f$Shape_Area, by =  list(BARE2012f$URAU_CODE), FUN = sum)
names(BARE2012f) <- sub("x", "BARE2012f", names(BARE2012f))

#### FUA forest area
Forest2012f <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", 
                        sheet = "Forest2012f")
Forest2012f <- aggregate(Forest2012f$Shape_Area, by =  list(Forest2012f$URAU_CODE), FUN = sum)
names(Forest2012f) <- sub("x", "Forest2012f", names(Forest2012f))

#### merge to CFDATA
CFDATA <- merge(CFDATA, Agriculture2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Agriculture2012f <- CFDATA$Agriculture2012f / CFDATA$FUAarea * 100
CFDATA <- merge(CFDATA, ContUrb2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$ContUrb2012c <- CFDATA$ContUrb2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, ContUrb2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$ContUrb2012f <- CFDATA$ContUrb2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, DiscontUrb2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$DiscontUrb2012f <- CFDATA$DiscontUrb2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, DiscontUrb2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$DiscontUrb2012c <- CFDATA$DiscontUrb2012c / CFDATA$CityAREA * 100
CFDATA <- merge(CFDATA, Industrial2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Industrial2012c <- CFDATA$Industrial2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, Industrial2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Industrial2012f <- CFDATA$Industrial2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, Trans2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Trans2012c <- CFDATA$Trans2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, wetlands2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$wetlands2012f <- CFDATA$wetlands2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, Vegetation2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Vegetation2012f <- CFDATA$Vegetation2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, Vegetation2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Vegetation2012c <- CFDATA$Vegetation2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, GreenUrb2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$GreenUrb2012c <- CFDATA$GreenUrb2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, BARE2012c, by.x = "URAU_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$BARE2012c <- CFDATA$BARE2012c / CFDATA$CityAREA  * 100
CFDATA <- merge(CFDATA, BARE2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$BARE2012f <- CFDATA$BARE2012f / CFDATA$FUAarea  * 100
CFDATA <- merge(CFDATA, Forest2012f, by.x = "FUA_CODE", by.y = "Group.1", all.x = TRUE, sort = FALSE)
CFDATA$Forest2012f <- CFDATA$Forest2012f / CFDATA$FUAarea  * 100


CFDATA$Vegetation2012c[is.na(CFDATA$Vegetation2012c)] <- 0
CFDATA$Vegetation2012f[is.na(CFDATA$Vegetation2012f)] <- 0
CFDATA$Trans2012c[is.na(CFDATA$Trans2012c)] <- 0
CFDATA$ContUrb2012c[is.na(CFDATA$ContUrb2012c)] <- 0
CFDATA$ContUrb2012f[is.na(CFDATA$ContUrb2012f)] <- 0
CFDATA$DiscontUrb2012f[is.na(CFDATA$DiscontUrb2012f)] <- 0
CFDATA$DiscontUrb2012c[is.na(CFDATA$DiscontUrb2012c)] <- 0
CFDATA$Industrial2012c[is.na(CFDATA$Industrial2012c)] <- 0
CFDATA$Industrial2012f[is.na(CFDATA$Industrial2012f)] <- 0
CFDATA$wetlands2012f[is.na(CFDATA$wetlands2012f)] <- 0
CFDATA$GreenUrb2012c[is.na(CFDATA$GreenUrb2012c)] <- 0
CFDATA$BARE2012f[is.na(CFDATA$BARE2012f)] <- 0
CFDATA$BARE2012c[is.na(CFDATA$BARE2012c)] <- 0
CFDATA$Forest2012f[is.na(CFDATA$Forest2012f)] <- 0

#*
################################# SOVIET #################################

SOVIET <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/SOVIET.xlsx")
CFDATA <- merge(CFDATA, SOVIET, by.x = "URAU_CODE", by.y = "URAU_CODE", all.x = TRUE, sort = FALSE)
CFDATA$Soviet[is.na(CFDATA$Soviet)] <- 0

######################### MARINE coastline dummy #########################

MarineF <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Corine2012.xlsx", sheet = "MarineF")
CFDATA <- merge(CFDATA, MarineF, by.x = "FUA_CODE", by.y = "URAU_CODE", all.x = TRUE, sort = FALSE)
CFDATA$Coastal[is.na(CFDATA$Coastal)] <- 0

############################ HOUSEHOLD NUMBERS ###########################

urb_clivcon <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/urb_clivcon.xls")
CFDATA <- merge(CFDATA, urb_clivcon, by.x = "URAU_CODE", by.y = "CITIES/TIME",  sort = FALSE)
CFDATA$DWELLper100HH <- CFDATA$NoDwell2011/CFDATA$NoHH * 100

TransC2011 <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/TransC2011.xls")
CFDATA <- merge(CFDATA, TransC2011, by.x = "URAU_CODE", by.y = "CITIES/TIME",  sort = FALSE)
CFDATA$CarsPer1000_2011 <- CFDATA$CarsPer1000_2011 / 10
names(CFDATA) <- sub("CarsPer1000_2011", "CarsPer100pop", names(CFDATA))

CFDATA$Commute <- (CFDATA$CommuteIn + CFDATA$CommuteOut) / CFDATA$CityPOP2012 * 100
CFDATA$CommuteIn <- NULL
CFDATA$CommuteOut <- NULL

############################## POLYCENTICITY #############################

Polycntr <- read_excel("D:/Google Drive/studijos/MSc thesis 2018/RESEARCH PART/05_xls/Poly.xlsx")
CFDATA <- merge(CFDATA, Polycntr, by.x = "CNTR_CODE", by.y = "CNTR_CODE", all.x = TRUE, sort = FALSE)
CFDATA$Polycntr[is.na(CFDATA$Polycntr)] <- 0

################################## OMIT ##################################

CFDATA$City_A <- NULL
CFDATA$City_UA <- NULL

#### SCALE

# scale ha to sqkm
CFDATA$CityAREA <- CFDATA$CityAREA / 1000000
CFDATA$FUAarea <- CFDATA$FUAarea / 1000000
# scale City pop to 1000 inh
CFDATA$CityPOP2012 <- CFDATA$CityPOP2012 /1000
CFDATA$POPfua2006 <- CFDATA$POPfua2006 / 1000
CFDATA$POPfua2009 <- CFDATA$POPfua2009 / 1000
CFDATA$POPcity2006 <- CFDATA$POPcity2006 / 1000
CFDATA$POPcity2009 <- CFDATA$POPcity2009 / 1000
CFDATA$UPcity <- CFDATA$UPcity / 100000000
# scale per 1000
CFDATA$NoDwell2011 <- CFDATA$NoDwell2011 / 1000
CFDATA$NoHH <- CFDATA$NoHH / 1000

na.omit(CFDATA)
# write.csv(CFDATA, "CFDATA20180507.csv")
