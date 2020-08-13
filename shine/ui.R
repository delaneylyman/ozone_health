library(ggplot2)
library(leaflet)
library(Cairo)

#Begin layout of page
shinyUI(fluidPage(
  
  #title 
  titlePanel("Ozone Health Metrics 1995-2014"),
  
  #create sidebar panel
  sidebarPanel(
    
    #create pull down menu for five year ranges
    h4("Select a five year range:"),
    selectizeInput("yearrange", label=NULL ,choices = df$yeargroup, selected="2000-2004"),
    
    #Create checkboxes for each region
    h4("Regions:"),
    checkboxInput("doea", "East Asia", value=T),
    checkboxInput("doeu","Europe", value = F),
    checkboxInput("dous", "North America", value=F),
    
    #Create radio/toggle buttons for health metrics
    radioButtons("metric", label = h4("Health Metric"),
                 choices = list("Days over 70 ppb" = 1, "Average Value of Daily Maximum 8-hour Average Ozone Mixing Ratios" = 2), 
                 selected = 1),
    
    #Create checkboxes for each population
    h4("Population Density"),
    checkboxInput("pop1", "0-5000", value=T),
    checkboxInput("pop2","5001-10000", value = F),
    checkboxInput("pop3", "10001-15000", value=F),
    checkboxInput("pop4", "15001-20000", value=F),
    checkboxInput("pop5", ">20001", value=F),
    
    #Create radio/toggle buttons for population density distance
    radioButtons("km", label = h4("Population Density Distance"),
                 choices = list("5 km" = 1, "25 km" = 2), 
                 selected = 1),
    
    #Define width of sidebar panel
    width =2
  ),
  
  #Begin main panel with plots
  mainPanel(plotOutput(outputId="plotgraph",height=500, width = 1050
  )),
  
  #Output lower panel with description of Ozone
  column(8,wellPanel(h4("About Ozone"),
         "Ozone that accumulates in the stratosphere creates a barrier from harmful UV 
         light and protects the globe. However, due to an increase in primary pollutants,
         ozone is also beginning to acquire in the troposphere, becoming harmful to human
         health. The National Ambient Air Quality Standard is 70 parts per billion (ppb).",
         "This application shows spatial plots for either the number
         of days at each site where the 4th highest daily maximum 8-hour ozone was above 70 ppb
         or the average value of daily maximum 8-hour average ozone mixing ratios. The data 
         used is from the Tropospheric Ozone Assessment Report where the values are averaged over the months of April
         through September."
  )),
  
  #Output legend
  column(2,imageOutput("legend"))
  
))