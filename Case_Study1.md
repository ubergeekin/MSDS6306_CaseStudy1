---
title: "PMarquardt_CBallenger_BAKannan_CaseStudy1"
author: "Paul Marquardt"
date: "June 17, 2018"
output: 
  html_document:
    keep_md: true
---



### MSDS 6306: Case Study 1 Introduction
The following document represents a case study of craft breweries and the beers they produce across the United States. In this study we will make some general observations with the hope of providing information concerning details of the craft brewery market in the United States. This study does not represent an exhaustive list of craft breweries and their beers, but does contain general information about the overall craft beer market.Craft breweries are growing across the nation, as we can see in the following table.

Table 1: Contains a total count of the number of breweries by their respective state

```r
# Question 1. How many breweries are present in each state?
# Read the breweries.csv into a dataframe and assign the variable name brew
brew <- read.csv(file = "breweries.csv", header = TRUE, sep = ",", strip.white = TRUE)
# Load the plyr library
library(plyr)
# Assign the count function against the State column to the variable name st
st <- count(brew, "State")
# Display the st variable output
st
```

```
##    State freq
## 1     AK    7
## 2     AL    3
## 3     AR    2
## 4     AZ   11
## 5     CA   39
## 6     CO   47
## 7     CT    8
## 8     DC    1
## 9     DE    2
## 10    FL   15
## 11    GA    7
## 12    HI    4
## 13    IA    5
## 14    ID    5
## 15    IL   18
## 16    IN   22
## 17    KS    3
## 18    KY    4
## 19    LA    5
## 20    MA   23
## 21    MD    7
## 22    ME    9
## 23    MI   32
## 24    MN   12
## 25    MO    9
## 26    MS    2
## 27    MT    9
## 28    NC   19
## 29    ND    1
## 30    NE    5
## 31    NH    3
## 32    NJ    3
## 33    NM    4
## 34    NV    2
## 35    NY   16
## 36    OH   15
## 37    OK    6
## 38    OR   29
## 39    PA   25
## 40    RI    5
## 41    SC    4
## 42    SD    1
## 43    TN    3
## 44    TX   28
## 45    UT    4
## 46    VA   16
## 47    VT   10
## 48    WA   23
## 49    WI   20
## 50    WV    1
## 51    WY    4
```

There are numerous different types of beer styles. Each style of beer is created using differnt types of ingredients which include barley, malt, hops, and yeast. This also includes cider and lambic which is made from fruit juice. 

Table 2: Lists several different styles of beer and corresponding data including hard cider

```r
# Question 2. Merge beer data with the breweries data. Print the first 6 observations and the last six observations to check the merged file. 
# Read the beers.csv and assign it to the beer variable
beer <- read.csv(file = "beers.csv", header = TRUE, sep = ",", strip.white = TRUE)
# Merge the beers and brew data frames into the brewbeer variable
brewbeer <- merge(brew, beer, by.x = "Brew_ID", by.y="Brewery_id")
# Display the first 6 lines of the merged dataset
head(brewbeer)
```

```
##   Brew_ID            Name.x        City State        Name.y Beer_ID   ABV
## 1       1 NorthGate Brewing Minneapolis    MN       Pumpion    2689 0.060
## 2       1 NorthGate Brewing Minneapolis    MN    Stronghold    2688 0.060
## 3       1 NorthGate Brewing Minneapolis    MN   Parapet ESB    2687 0.056
## 4       1 NorthGate Brewing Minneapolis    MN  Get Together    2692 0.045
## 5       1 NorthGate Brewing Minneapolis    MN Maggie's Leap    2691 0.049
## 6       1 NorthGate Brewing Minneapolis    MN    Wall's End    2690 0.048
##   IBU                               Style Ounces
## 1  38                         Pumpkin Ale     16
## 2  25                     American Porter     16
## 3  47 Extra Special / Strong Bitter (ESB)     16
## 4  50                        American IPA     16
## 5  26                  Milk / Sweet Stout     16
## 6  19                   English Brown Ale     16
```

```r
# Display the last 6 lines of the merged dataset
tail(brewbeer)
```

```
##      Brew_ID                        Name.x          City State
## 2405     556         Ukiah Brewing Company         Ukiah    CA
## 2406     557       Butternuts Beer and Ale Garrattsville    NY
## 2407     557       Butternuts Beer and Ale Garrattsville    NY
## 2408     557       Butternuts Beer and Ale Garrattsville    NY
## 2409     557       Butternuts Beer and Ale Garrattsville    NY
## 2410     558 Sleeping Lady Brewing Company     Anchorage    AK
##                         Name.y Beer_ID   ABV IBU                   Style
## 2405             Pilsner Ukiah      98 0.055  NA         German Pilsener
## 2406         Porkslap Pale Ale      49 0.043  NA American Pale Ale (APA)
## 2407           Snapperhead IPA      51 0.068  NA            American IPA
## 2408         Moo Thunder Stout      50 0.049  NA      Milk / Sweet Stout
## 2409  Heinnieweisse Weissebier      52 0.049  NA              Hefeweizen
## 2410 Urban Wilderness Pale Ale      30 0.049  NA        English Pale Ale
##      Ounces
## 2405     12
## 2406     12
## 2407     12
## 2408     12
## 2409     12
## 2410     12
```

### Question 3. Report the number of NA's in each column. 
In order to determine how many NAs are in each column, we will use the sapply() function.  The function will allow us to sum all true values or 1 that are NA's.  Any values that do not have NA's will be returned as False or 0, thus not being included in the sum.

```r
sapply(brewbeer, function(y) sum( length( which( is.na( y ) ) ) ) )
```

```
## Brew_ID  Name.x    City   State  Name.y Beer_ID     ABV     IBU   Style 
##       0       0       0       0       0       0      62    1005       0 
##  Ounces 
##       0
```
Analyzing the data, we have a large gap in IBU's of 1005 missing values out of 2410 rows.  There is also missing values in ABV, but small enough to continue with our analysis.

### Question 4. Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare. 
Using the aggregate function, we are about to get the median value for ABV and IBU.  Due to the incomplete data for IBU and ABV, we are ignoring any NA values for the purpose of this study.

```r
median_abv_ibu <- aggregate( brewbeer[ , 7:8 ], list( brewbeer$State ), median, na.rm=TRUE )
```

Removing any possible NAs from the Median value of ABV.

```r
ggplot( median_abv_ibu[!is.na(median_abv_ibu$IBU),], aes( Group.1, ABV ) ) +
    geom_bar(stat="identity") +
    coord_flip()
```

![](Case_Study1_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Removing any possible NAs from the Median value of IBU.

```r
ggplot( median_abv_ibu[!is.na(median_abv_ibu$IBU),] , aes( Group.1, IBU ) ) +
    geom_bar(stat="identity") +
    coord_flip()
```

![](Case_Study1_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

### Question 5. Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer? 
In order to identify which state's beer has the most alcohol we need to performt he following steps
* Get the max ABV from each State and Merge it to the original data set
* Perform a logical function to compare the beer list's ABV to the Max ABV
* Sort by ABV to show the top ABV Beers.

```r
max_abv_ibu <- aggregate( brewbeer[ , 7:8 ], list( brewbeer$State ), max, na.rm=TRUE )
```

```
## Warning in FUN(X[[i]], ...): no non-missing arguments to max; returning -
## Inf
```

```r
names( max_abv_ibu ) <- c( 'max_State', 'max_abv', 'max_ibu')
# Merge Into Existing Data Set to do Logical Comparsons
brewbeer <- merge( brewbeer, max_abv_ibu, by.x = "State", by.y = "max_State" )
#Find the Beer that matches the max ABV by its State
highest_abv_by_state <- brewbeer[brewbeer$ABV >= brewbeer$max_abv,c( 1, 3, 5, 7, 9)]
#Filter our NAs
highest_abv_by_state <- highest_abv_by_state[which(!is.na(highest_abv_by_state$State)), ]
highest_abv_by_state[order(highest_abv_by_state$ABV, decreasing=TRUE),]
```

```
##      State                              Name.x
## 518     CO             Upslope Brewing Company
## 990     KY           Against the Grain Brewery
## 948     IN             Tin Man Brewing Company
## 1634    NY                 Sixpoint Craft Ales
## 96      CA                Hess Brewing Company
## 186     CA              21st Amendment Brewery
## 190     CA          The Dudes' Brewing Company
## 263     CA           Manzanita Brewing Company
## 710     ID             Sockeye Brewing Company
## 726     ID             Sockeye Brewing Company
## 1072    MA            Cape Ann Brewing Company
## 1147    ME      Marshall Wharf Brewing Company
## 1171    MI                      Brewery Vivant
## 1237    MI                      Brewery Vivant
## 1293    MI                      Brewery Vivant
## 1346    MN               Surly Brewing Company
## 1366    MN                    Big Wood Brewery
## 1499    NC Oskar Blues Brewery (North Carol...
## 1566    NJ              Carton Brewing Company
## 1585    NV            Buckbean Brewing Company
## 1670    OH                    Portside Brewery
## 1697    OH             Madtree Brewing Company
## 1864    PA                  Round Guys Brewing
## 2095    TX            Real Ale Brewing Company
## 2096    TX       Southern Star Brewing Company
## 2322    WI                Minhas Craft Brewery
## 1992    SC               COAST Brewing Company
## 771     IL                     Destihl Brewery
## 803     IL            Spiteful Brewing Company
## 811     IL            Spiteful Brewing Company
## 1549    NE          Blue Blood Brewing Company
## 2235    VT                       The Alchemist
## 52      AZ              SanTan Brewing Company
## 693     IA             Okoboji Brewing Company
## 33      AL         Good People Brewing Company
## 569     DC             DC Brau Brewing Company
## 539     CT         New England Brewing Company
## 543     CT         New England Brewing Company
## 2160    UT            Utah Brewers Cooperative
## 2171    UT            Utah Brewers Cooperative
## 1022    LA New Orleans Lager & Ale Brewing ...
## 1815    OR                 Fort George Brewery
## 2191    VA               Beach Brewing Company
## 1983    RI        Narragansett Brewing Company
## 966     KS           Tallgrass Brewing Company
## 973     KS           Tallgrass Brewing Company
## 1129    MD                 Union Craft Brewing
## 1723    OK              Anthem Brewing Company
## 2295    WA              7 Seas Brewing Company
## 662     HI             Hawai'i Nui Brewing Co.
## 606     FL          Cigar City Brewing Company
## 1410    MO              Weston Brewing Company
## 1421    MS Southern Prohibition Brewing Com...
## 1581    NM            Santa Fe Brewing Company
## 1438    MT            Wildwood Brewing Company
## 641     GA            Red Hare Brewing Company
## 2397    WY          Wind River Brewing Company
## 2007    SD           Crow Peak Brewing Company
## 6       AK         Kenai River Brewing Company
## 1527    ND               Fargo Brewing Company
## 2395    WV   Greenbrier Valley Brewing Company
## 1559    NH    Woodstock Inn, Station & Brewery
## 2014    TN            Wiseacre Brewing Company
## 39      AR   Core Brewing & Distilling Company
## 571     DE          Twin Lakes Brewing Company
##                                                    Name.y   ABV
## 518  Lee Hill Series Vol. 5 - Belgian Style Quadrupel Ale 0.128
## 990                                        London Balling 0.125
## 948                                                  Csar 0.120
## 1634                                               4Beans 0.100
## 96                           Ex Umbris Rye Imperial Stout 0.099
## 186                                         Lower De Boom 0.099
## 190                                          Double Trunk 0.099
## 263                                    Chaotic Double IPA 0.099
## 710               Barrel Aged Seven Devils Imperial Stout 0.099
## 726                                     Old Devil's Tooth 0.099
## 1072                               Imperial Pumpkin Stout 0.099
## 1147                                           Sexy Chaos 0.099
## 1171           Vivant Belgian Style Imperial Stout (2012) 0.099
## 1237                     Hubris Quadrupel Anniversary Ale 0.099
## 1293                                 Wizard Burial Ground 0.099
## 1346                                               BLAKKR 0.099
## 1366                      Forest Fire Imperial Smoked Rye 0.099
## 1499                                             Ten Fidy 0.099
## 1566                                              Epitome 0.099
## 1585                           Very Noddy Lager (Current) 0.099
## 1670                                 Big Chuck Barleywine 0.099
## 1697                                          Galaxy High 0.099
## 1864                                           Sanctified 0.099
## 2095                                               BLAKKR 0.099
## 2096                                 PRO-AM (2012) (2012) 0.099
## 2322                                 Axe Head Malt Liquor 0.099
## 1992                                             Boy King 0.097
## 771                                   Hoperation Overload 0.096
## 803                               Bitter Biker Double IPA 0.096
## 811                               Bitter Biker Double IPA 0.096
## 1549                                Pernicious Double IPA 0.096
## 2235                                          The Crusher 0.096
## 52                           Winter Warmer (Vault Series) 0.095
## 693                            The Hole in Hadrian's Wall 0.095
## 33                               Snake Handler Double IPA 0.093
## 569                            On the Wings of Armageddon 0.092
## 539                       668 Neighbor of the Beast12 oz. 0.090
## 543             668 Neighbor of the Beast (16 oz.) (2010) 0.090
## 2160               Squatters Hop Rising Double IPA (2014) 0.090
## 2171                      Squatters Hop Rising Double IPA 0.090
## 1022                                        MechaHopzilla 0.088
## 1815                                       Cavatica Stout 0.088
## 2191                                  Hoptopus Double IPA 0.088
## 1983                        Narragansett Bohemian Pilsner 0.086
## 966                                        Velvet Rooster 0.085
## 973                                        Wooden Rooster 0.085
## 1129                                       Double Duckpin 0.085
## 1723                                             Uroboros 0.085
## 2295                                Ballz Deep Double IPA 0.084
## 662                                        Southern Cross 0.083
## 606                                     Wandering Pelican 0.082
## 1410                             Rip Van Winkle (Current) 0.080
## 1421                                 Mississippi Fire Ant 0.080
## 1581                                  Imperial Java Stout 0.080
## 1438                                       Bodacious Bock 0.075
## 641                                   Watership Brown Ale 0.072
## 2397                                     Wyoming Pale Ale 0.072
## 2007                                   Pile O'Dirt Porter 0.069
## 6                                       Sunken Island IPA 0.068
## 1527                          Wood Chipper India Pale Ale 0.067
## 2395                                    Mothman Black IPA 0.067
## 1559                                      4000 Footer IPA 0.065
## 2014                                Ananda India Pale Ale 0.062
## 39                                               Core ESB 0.061
## 571                                   Greenville Pale Ale 0.055
##                                    Style
## 518                     Quadrupel (Quad)
## 990                   English Barleywine
## 948               Russian Imperial Stout
## 1634                       Baltic Porter
## 96      American Double / Imperial Stout
## 186                  American Barleywine
## 190       American Double / Imperial IPA
## 263       American Double / Imperial IPA
## 710     American Double / Imperial Stout
## 726                  American Barleywine
## 1072                         Pumpkin Ale
## 1147              Russian Imperial Stout
## 1171              Russian Imperial Stout
## 1237                    Quadrupel (Quad)
## 1293                    Quadrupel (Quad)
## 1346                  American Black Ale
## 1366                            Rye Beer
## 1499              Russian Imperial Stout
## 1566                  American Black Ale
## 1585                         Schwarzbier
## 1670                 American Barleywine
## 1697      American Double / Imperial IPA
## 1864             Belgian Strong Pale Ale
## 2095                  American Black Ale
## 2096      American Double / Imperial IPA
## 2322                American Malt Liquor
## 1992      American Double / Imperial IPA
## 771       American Double / Imperial IPA
## 803       American Double / Imperial IPA
## 811       American Double / Imperial IPA
## 1549      American Double / Imperial IPA
## 2235      American Double / Imperial IPA
## 52                         Winter Warmer
## 693                         Scottish Ale
## 33        American Double / Imperial IPA
## 569       American Double / Imperial IPA
## 539                     Belgian Pale Ale
## 543                     Belgian Pale Ale
## 2160      American Double / Imperial IPA
## 2171      American Double / Imperial IPA
## 1022      American Double / Imperial IPA
## 1815    American Double / Imperial Stout
## 2191      American Double / Imperial IPA
## 1983                     German Pilsener
## 966                               Tripel
## 973                               Tripel
## 1129      American Double / Imperial IPA
## 1723                      American Stout
## 2295      American Double / Imperial IPA
## 662                     Flanders Red Ale
## 606                   American Black Ale
## 1410                                Bock
## 1421            American Amber / Red Ale
## 1581              Russian Imperial Stout
## 1438                                Bock
## 641                   American Brown Ale
## 2397             American Pale Ale (APA)
## 2007                     American Porter
## 6                           American IPA
## 1527                        American IPA
## 2395                  American Black Ale
## 1559                        American IPA
## 2014                        American IPA
## 39   Extra Special / Strong Bitter (ESB)
## 571              American Pale Ale (APA)
```

Same process was done for IBU

```r
#Find the Beer that matches the max IBU by its State
highest_ibu_by_state <- brewbeer[brewbeer$IBU >= brewbeer$max_ibu,c( 1, 3, 5, 8, 9)]
#Filter our NAs
highest_ibu_by_state <- highest_ibu_by_state[which(!is.na(highest_ibu_by_state$State)), ]
highest_ibu_by_state[order(highest_ibu_by_state$IBU, decreasing=TRUE),]
```

```
##      State                              Name.x
## 1824    OR             Astoria Brewing Company
## 2203    VA          Wolf Hills Brewing Company
## 1056    MA            Cape Ann Brewing Company
## 1691    OH  Christian Moerlein Brewing Company
## 1339    MN               Surly Brewing Company
## 2213    VT                       The Alchemist
## 2214    VT                       The Alchemist
## 2035    TX       Buffalo Bayou Brewing Company
## 267     CA                   Modern Times Beer
## 569     DC             DC Brau Brewing Company
## 848     IN             Tin Man Brewing Company
## 952     IN                    Burn 'Em Brewing
## 1189    MI                     Atwater Brewery
## 1935    PA             Sly Fox Brewing Company
## 1654    NY                 Sixpoint Craft Ales
## 965     KS           Tallgrass Brewing Company
## 331     CO                  Big Choice Brewing
## 33      AL         Good People Brewing Company
## 708     ID             Sockeye Brewing Company
## 709     ID             Sockeye Brewing Company
## 718     ID             Sockeye Brewing Company
## 726     ID             Sockeye Brewing Company
## 736     IL          Wild Onion Brewing Company
## 764     IL          Wild Onion Brewing Company
## 775     IL          Wild Onion Brewing Company
## 1566    NJ              Carton Brewing Company
## 1576    NM           La Cumbre Brewing Company
## 1730    OK                      COOP Ale Works
## 80      AZ              SanTan Brewing Company
## 691     IA                 Great River Brewery
## 1499    NC Oskar Blues Brewery (North Carol...
## 1129    MD                 Union Craft Brewing
## 1592    NV        Joseph James Brewing Company
## 1415    MO              Weston Brewing Company
## 555     CT         New England Brewing Company
## 561     CT         New England Brewing Company
## 2154    UT               Uinta Brewing Company
## 2301    WA                     Wingman Brewers
## 591     FL                 3 Daughters Brewing
## 1559    NH    Woodstock Inn, Station & Brewery
## 990     KY           Against the Grain Brewery
## 1421    MS Southern Prohibition Brewing Com...
## 1466    MT             Bozeman Brewing Company
## 2313    WI           Milwaukee Brewing Company
## 2316    WI                     Capital Brewery
## 654     HI                  Mehana Brewing Co.
## 668     HI                  Mehana Brewing Co.
## 1969    RI     Coastal Extreme Brewing Company
## 2405    WY     The Black Tooth Brewing Company
## 21      AK              Denali Brewing Company
## 2395    WV   Greenbrier Valley Brewing Company
## 1148    ME            Glabrous Brewing Company
## 1527    ND               Fargo Brewing Company
## 643     GA                   Creature Comforts
## 1547    NE            Nebraska Brewing Company
## 1993    SC           Westbrook Brewing Company
## 2014    TN            Wiseacre Brewing Company
## 1025    LA            Tin Roof Brewing Company
## 571     DE          Twin Lakes Brewing Company
## 38      AR                  Ozark Beer Company
##                                      Name.y IBU
## 1824              Bitter Bitch Imperial IPA 138
## 2203                     Troopers Alley IPA 135
## 1056                          Dead-Eye DIPA 130
## 1691        Bay of Bengal Double IPA (2014) 126
## 1339                           Abrasive Ale 120
## 2213                           Heady Topper 120
## 2214                           Heady Topper 120
## 2035                           More Cowbell 118
## 267                           Blazing World 115
## 569              On the Wings of Armageddon 115
## 848                   Overlord Imperial IPA 115
## 952                        Hopkick Dropkick 115
## 1189                             Hop A-Peel 115
## 1935                                113 IPA 113
## 1654                                 Hi-Res 111
## 965                               Ethos IPA 110
## 331                      Hemlock Double IPA 104
## 33                 Snake Handler Double IPA 103
## 708                        Dagger Falls IPA 100
## 709                        Dagger Falls IPA 100
## 718                        Dagger Falls IPA 100
## 726                       Old Devil's Tooth 100
## 736                   Hop Slayer Double IPA 100
## 764            Hop Slayer Double IPA (2011) 100
## 775            Hop Slayer Double IPA (2011) 100
## 1566                                Epitome 100
## 1576                           Elevated IPA 100
## 1730                                 F5 IPA 100
## 80              Count Hopula (Vault Series)  99
## 691  Hop A Potamus Double Dark Rye Pale Ale  99
## 1499                               Ten Fidy  98
## 1129                         Double Duckpin  90
## 1592                   Hop Box Imperial IPA  90
## 1415                     Oâ\200\231Malleyâ\200\231s IPA  89
## 555   Gandhi-Bot Double IPA (16 oz.) (2010)  85
## 561          Gandhi-Bot Double IPA (12 oz.)  85
## 2154                           Hop Nosh IPA  83
## 2301                                Ace IPA  83
## 591                            Bimini Twist  82
## 1559                        4000 Footer IPA  82
## 990                          London Balling  80
## 1421                   Mississippi Fire Ant  80
## 1466                     Bozone HopZone IPA  80
## 2313                              Hop Freak  80
## 2316           Dark Voyage Black IPA (2013)  80
## 654                             Tsunami IPA  75
## 668                             Tsunami IPA  75
## 1969                      Newport Storm IPA  75
## 2405                  Indian Paintbrush IPA  75
## 21             Twister Creek India Pale Ale  71
## 2395                      Mothman Black IPA  71
## 1148                        Clean Shave IPA  70
## 1527            Wood Chipper India Pale Ale  70
## 643                              Tropicalia  65
## 1547                Nebraska India Pale Ale  65
## 1993                          Westbrook IPA  65
## 2014                  Ananda India Pale Ale  61
## 1025                         Juke Joint IPA  60
## 571                     Greenville Pale Ale  52
## 38                  Ozark American Pale Ale  39
##                               Style
## 1824 American Double / Imperial IPA
## 2203                   American IPA
## 1056 American Double / Imperial IPA
## 1691 American Double / Imperial IPA
## 1339 American Double / Imperial IPA
## 2213 American Double / Imperial IPA
## 2214 American Double / Imperial IPA
## 2035 American Double / Imperial IPA
## 267        American Amber / Red Ale
## 569  American Double / Imperial IPA
## 848  American Double / Imperial IPA
## 952  American Double / Imperial IPA
## 1189 American Double / Imperial IPA
## 1935                   American IPA
## 1654 American Double / Imperial IPA
## 965                    American IPA
## 331  American Double / Imperial IPA
## 33   American Double / Imperial IPA
## 708                    American IPA
## 709                    American IPA
## 718                    American IPA
## 726             American Barleywine
## 736  American Double / Imperial IPA
## 764  American Double / Imperial IPA
## 775  American Double / Imperial IPA
## 1566             American Black Ale
## 1576                   American IPA
## 1730                   American IPA
## 80   American Double / Imperial IPA
## 691                        Rye Beer
## 1499         Russian Imperial Stout
## 1129 American Double / Imperial IPA
## 1592 American Double / Imperial IPA
## 1415                   American IPA
## 555  American Double / Imperial IPA
## 561  American Double / Imperial IPA
## 2154                   American IPA
## 2301                   American IPA
## 591                    American IPA
## 1559                   American IPA
## 990              English Barleywine
## 1421       American Amber / Red Ale
## 1466                   American IPA
## 2313 American Double / Imperial IPA
## 2316             American Black Ale
## 654                    American IPA
## 668                    American IPA
## 1969                   American IPA
## 2405                   American IPA
## 21                     American IPA
## 2395             American Black Ale
## 1148                   American IPA
## 1527                   American IPA
## 643                    American IPA
## 1547                   American IPA
## 1993                   American IPA
## 2014                   American IPA
## 1025                   American IPA
## 571         American Pale Ale (APA)
## 38          American Pale Ale (APA)
```

Reviewing the data, we find that beers with the highest IBU is aligned with the same style accros all the states, IPA.  However, higher ABV beers have a wide variety of styles, but most being Imperial IPAs or Stours.

### Quetion 6. Summary statistics for the ABV variable. 

```r
summary(brewbeer$ABV)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00100 0.05000 0.05600 0.05977 0.06700 0.12800      62
```
### Question 7. Is there an apparent relationship between the bitterness of the beer and its alcoholic content? Draw a scatter plot. 

```r
plot(brewbeer$IBU, brewbeer$ABV, main="Scatterplot - Bitterness of the beer Vs Alcoholic content",xlab="International Bitterness Units (IBU)", ylab=" Alcohol By Volume (ABV)", pch=19)
```

![](Case_Study1_files/figure-html/unnamed-chunk-10-1.png)<!-- -->
You are welcome to use the ggplot2 library for graphs. Please ignore missing values in your analysis. Make your best judgment of a relationship and EXPLAIN your answer. 
 
