#LESSON 7 THIJS OOSTERHUIS


library(rasta)
#preprocess tura
data(tura)
tura <- tura/10000
#select dates
dates <- substr(names(tura), 10, 16)
# format the date in the format yyyy-mm-dd
print(as.Date(dates, format="%Y%j"))
#extract layer names from the tura rasterBrick
sceneID <- names(tura)
# parse these names to extract scene information
sceneinfo <- getSceneinfo(sceneID)
#plot(tura, c[4])
sceneinfo$year <- factor(substr(sceneinfo$date, 1, 4), levels = c(1984:2013))
#first take mean of pictures per year
mean2000 <- calc(subset(tura,subset=which(sceneinfo$year==2000)), fun= mean,na.rm=T)
mean2005 <- calc(subset(tura,subset=which(sceneinfo$year==2005)), fun= mean,na.rm=T)
mean2010 <- calc(subset(tura,subset=which(sceneinfo$year==2010)), fun= mean,na.rm=T)
plot(mean2010)
#layerstack of means, then plot them 

vb <- stack(mean2000,mean2005,mean2010)
plot(vb, 1)

#make RGB of years (n1=2000(red), n2=2005(green), n3=2010(blue))

#?plotRGB
plotRGB(vb, r = 1, g=2, b=3, stretch='hist')


#select both extents

#e1 <- drawExtent()
#e2 <- drawExtent()
#?raster

#assign data from raster through extract
e1 <- extent(c(819682.6,820084.6,831424.5,831770.3)) 
e2 <- extent(c(822879.4,823187.9,830115.8,830508.4))
extract_e1 <- extract(tura,e1, fun=mean, na.rm=T)
extract_e2 <- extract(tura,e2, fun=mean, na.rm=T)
sceneinfo$NDVI1 <- extract_e1
sceneinfo$NDVI2 <- extract_e2

#ggplot2
ggplot(data=sceneinfo, aes(x=date, y=NDVI1)) +geom_point()
ggplot(data=sceneinfo, aes(x=date, y=NDVI2)) +geom_point()
