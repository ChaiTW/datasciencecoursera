## Question 2

## nbc for NEIdata of Baltimore
## tebc for totalEmission of Baltimore

nbc<-subset(NEIdata, fips == "24510")
tebc <- aggregate(Emissions ~ year, nbc, sum)

barplot(
  (tebc$Emissions)/10^6, names.arg=tebc$year, xlab="Year",
  ylab="PM2.5 Emissions (million Tons)", main="Total PM2.5 Emissions From All Baltimore City Sources"
)

#dev.copy(png,"plot2.png")
#dev.off()
