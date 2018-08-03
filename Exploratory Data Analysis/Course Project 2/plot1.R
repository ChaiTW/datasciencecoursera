## Question 1

## te for total Emissions

te <- aggregate(Emissions ~ year, NEIdata, sum)

barplot(
  (te$Emissions)/10^6, names.arg=te$year, xlab="Year", 
   ylab="PM2.5 Emissions (million Tons)", main="Total PM2.5 Emissions From All US Sources"
)

#dev.copy(png,"plot1.png")
#dev.off()
