

###

UMZinFUA <- aggregate(UMZ_area_by_FUA$Area_ha, by=list(Category=UMZ_area_by_FUA$id_fua), FUN=sum)
names(UMZinFUA) <- sub("x", "UMZareainFUA", names(UMZinFUA))

UMZ_area_by_FUA <- NULL

FUAdata <- merge(FUA_MUA_shapefiles, UMZinFUA, by.x = c("id_fua"), by.y = c("Category"), all = TRUE)
FUAdata <- FUAdata[!is.na(FUAdata$id_mua),]

#change to 1 and 0
URAU_attributes_from_shp$CITY_IN_KE[is.na(URAU_attributes_from_shp$CITY_IN_KE)] <- 0
URAU_attributes_from_shp$CAPITAL_CI[!(URAU_attributes_from_shp$CAPITAL_CI==0)] <- 1

FUAdata <- merge(FUAdata, URAU_attributes_from_shp, by.x = c("code"), by.y = c("code"), all = TRUE)
