setwd("/Users/christopherballenger/Documents/Data Science/MSDS 6306/Projects/CaseStudy1")

brew <- read.csv(file = "breweries.csv", header = TRUE, sep = ",", strip.white = TRUE)
beer <- read.csv(file = "beers.csv", header = TRUE, sep = ",", strip.white = TRUE)
brewbeer <- merge(brew, beer, by.x = "Brew_ID", by.y="Brewery_id")
names(brewbeer) <- c('Brewery_id','Brewery','City','State','Beer','Beer_ID','ABV','IBU','Style','Ounces')

# Provide descriptions of each variable
attr(brewbeer$ABV, "shortDescription") <-
    "Alcohol by Volume"

attr(brewbeer$IBU, "shortDescription") <-
    "International Bittering Units"

attr(brewbeer$Ounces, "shortDescription") <- 
    "Recommended Serving Size"

# Create the cookbook for descriptions
makeCodebook(brewbeer, replace=TRUE)