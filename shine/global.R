#Load libraries
library(readr)
library(methods)
library(fields)
library(ggplot2)
library(maps)
library(devtools)
library(shiny)
library(Cairo)
library(colorspace)
library(usethis)
library(gridExtra)

#Read in data for each five yar period
df1<-read.csv("TOAR_sfc_ozone_summer_global_1995-1999_aggregated.csv",quote = "", header = T, sep = ';', skip = 79, fill=T)
df2<-read.csv("TOAR_sfc_ozone_summer_global_2000-2004_aggregated.csv",quote = "", header = T, sep = ';', skip = 79, fill=T)
df3<-read.csv("TOAR_sfc_ozone_summer_global_2005-2009_aggregated.csv",quote = "", header = T, sep = ';', skip = 79, fill=T)
df4<-read.csv("TOAR_sfc_ozone_summer_global_2010-2014_aggregated.csv",quote = "", header = T, sep = ';', skip = 79, fill=T)

#Define yeargroup for interactive tool that allows users to filter based on year
df1$yeargroup="1995-1999"
df2$yeargroup="2000-2004"
df3$yeargroup="2005-2009"
df4$yeargroup="2010-2014"

#combine data frames
df<-rbind(df1,df2,df3,df4)

#remove negative data points
df$nvgt070[df$nvgt070 < 0] <- NA
df$avgdma8epax[df$avgdma8epax < 0] <- NA
df<-df[complete.cases(df),]

###########################################################################################################
#only look at certian country: US,East Asia, or Europe

##############################################################################################################
#Define subset of North America
dfUS=subset(df,df$station_lat>24 & df$station_lat<75 & df$station_lon > -135 & df$station_lon < -60)

#break up into "0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"
dfUS$nvgt070cut <- cut(dfUS$nvgt070, 
                     breaks = c(-Inf, 1, 4, 7, 16, 24, Inf), 
                     labels = c("0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"), 
                     right = FALSE)

#break up ppb into "0-13", "14-26", "27-39", "40-52", "53-65", "66+"
dfUS$avgdma8epaxcut <- cut(dfUS$avgdma8epax, 
                        breaks = c(-Inf, 14, 27, 40, 53, 66, Inf), 
                        labels = c("0-13", "14-26", "27-39", "40-52", "53-65", "66+"), 
                        right = FALSE)


#Defines overlaying map with US and Canada
us = map_data('world', c("usa",'canada'))

######################################################################################################################
#Define subset of Europe
dfEU=subset(df,df$station_lat>35 & df$station_lat<70 & df$station_lon > -10 & df$station_lon < 50)

#break up into "0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"
dfEU$nvgt070cut <- cut(dfEU$nvgt070, 
                       breaks = c(-Inf, 1, 4, 7, 16, 24, Inf), 
                       labels = c("0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"), 
                       right = FALSE)

#break up ppb into "0-13", "14-26", "27-39", "40-52", "53-65", "66+"
dfEU$avgdma8epaxcut <- cut(dfEU$avgdma8epax, 
                           breaks = c(-Inf, 14, 27, 40, 53, 66, Inf), 
                           labels = c("0-13", "14-26", "27-39", "40-52", "53-65", "66+"), 
                           right = FALSE)


#Defines overlaying map of Europe
europe=map_data("world",c('Ireland','Bosnia','Kosovo','Montenegro','Macedonia','Albania','Belarus', 'Serbia','Turkey','Ukraine','Russia','Austria','Belgium','Bulgaria','Croatia','Cyprus','Czech Republic','Denmark','Estonia','Finland','France','Germany','Greece','Hungary','Ireland','Italy','Latvia','Lithuania','Luxembourg','Malta','Netherlands','Poland','Portugal','Romania','Slovakia','Slovenia','Spain','Sweden','UK','Norway'))

###############################################################################################################
#EastAsia
dfEA=subset(df,df$station_lat>20 & df$station_lat<80 & df$station_lon > 110 & df$station_lon < 200)

#break up into "0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"
dfEA$nvgt070cut <- cut(dfEA$nvgt070, 
                       breaks = c(-Inf, 1, 4, 7, 16, 24, Inf), 
                       labels = c("0 days", "1-3 days", "4-6 days", "7-15 days", "16-24 days", "25+ days"), 
                       right = FALSE)

#break up ppb into "0-13", "14-26", "27-39", "40-52", "53-65", "66+"
dfEA$avgdma8epaxcut <- cut(dfEA$avgdma8epax, 
                           breaks = c(-Inf, 14, 27, 40, 53, 66, Inf), 
                           labels = c("0-13", "14-26", "27-39", "40-52", "53-65", "66+"), 
                           right = FALSE)


#Defines overlaying map wof East Asia
eastasia=map_data('world',c('japan', 'china','south korea','north korea','taiwan'))

#############################################################################################################

#Uncomment lines 101-102 and run in console to republish the application 
# library(rsconnect)
# rsconnect::deployApp('shine')