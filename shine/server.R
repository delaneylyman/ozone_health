
shinyServer(function(input, output, session) {

# pt1 is a reactive function that filters the data for East Asia based on the components
# a user selectsin order to produce the appropriate spatial plots
  pt1<-reactive({
   
    #Filter East Asia subset based on selected year range
    test3 <- dfEA[dfEA$yeargroup==input$yearrange,] 
    
    #Filter East Asia subset based on population density distance
    if(input$km==1){
      test3$station_population_density=test3$station_max_population_density_5km
    }
    else
      test3$station_population_density=test3$station_max_population_density_25km
    
    #Create subset data frames based on selected population densities
    if(input$pop1){
      p1<- test3[test3$station_population_density <= 5000,]
    }
    else
      p1<-NULL
    
    if(input$pop2){
      p2<- test3[test3$station_population_density > 5000 & test3$station_population_density<= 10000,]
    }
    else
      p2<-NULL
    if(input$pop3){
      p3<- test3[test3$station_population_density > 10000 & test3$station_population_density<= 15000,]
    }
    else
      p3<-NULL
    if(input$pop4){
      p4 <- test3[test3$station_population_density > 15000 & test3$station_population_density<= 20000,]
    }
    else
      p4<-NULL
    if(input$pop5){
      p5 <- test3[test3$station_population_density > 20000,]
    }
    else
      p5<-NULL
    
    #Combine all population density subsets to form final data frame for East Asia based on filters 
    test3<-rbind(p1,p2,p3,p4,p5)
    
    #Define map based on if Region is selected
    if(!input$doea) return(NULL)
    
    #Define latitude and longitude for East Asia
    slatEA<- test3$station_lat
    slngEA <- test3$station_lon
    
    #Change cut of spatial plot based on health metric selected
    if(input$metric==1){
      DaysEA<-test3$nvgt070cut}
    else
      DaysEA<-test3$avgdma8epaxcut
    
    #produce final plot of East Asia
    ggplot(test3,aes(x=slngEA,y=slatEA,group=DaysEA)) + 
      geom_polygon(data = eastasia, aes(x=long, y = lat, group = group), fill = 'white', color = "black") + 
      geom_point(aes(color=DaysEA),data=test3,size=1)+ 
      xlab('Longitude') + ylab('Latitude') +theme(plot.title = element_text(hjust = 0.5),legend.position="none") +
      scale_colour_manual(values = c("midnightblue", "darkgreen", "yellow2", "orange2", "orangered3", "firebrick4"),drop=FALSE)+
      coord_quickmap(xlim = c(115, 145.0),  ylim = c(20, 47))
  })

  # pt2 is a reactive function that filters the data for Europe based on the components
  # a user selectsin order to produce the appropriate spatial plots  
  pt2<-reactive({
    
    #Filter Europe subset based on selected year range
    test2 <- dfEU[dfEU$yeargroup==input$yearrange,] 
    
    #Filter Europe subset based on population density distance
    if(input$km==1){
      test2$station_population_density=test2$station_max_population_density_5km
    }
    else
      test2$station_population_density=test2$station_max_population_density_25km
    
    #Create subset data frames based on selected population densities
    if(input$pop1){
      b1<- test2[test2$station_population_density <= 5000,]
    }
    else
      b1<-NULL
    
    if(input$pop2){
      b2<- test2[test2$station_population_density > 5000 & test2$station_population_density<= 10000,]
    }
    else
      b2<-NULL
    if(input$pop3){
      b3<- test2[test2$station_population_density > 10000 & test2$station_population_density<= 15000,]
    }
    else
      b3<-NULL
    if(input$pop4){
      b4 <- test2[test2$station_population_density > 15000 & test2$station_population_density<= 20000,]
    }
    else
      b4<-NULL
    if(input$pop5){
      b5 <- test2[test2$station_population_density > 20000,]
    }
    else
      b5<-NULL
    
    #Combine all population density subsets to form final data frame for East Asia based on filters 
    test2<-rbind(b1,b2,b3,b4,b5)
    
    #Define map based on if Region is selected
    if(!input$doeu) return(NULL)
    
    #Define latitude and longitude for Europe
    slatEU<- test2$station_lat
    slngEU <- test2$station_lon
    
    #Change cut of spatial plot based on health metric selected
    if(input$metric==1){
      DaysEU<-test2$nvgt070cut}
    else
      DaysEU<-test2$avgdma8epaxcut
    
    #produce final plot of Europe    
    ggplot(test2,aes(x=slngEU,y=slatEU,group=DaysEU)) + 
      geom_polygon(data = europe, aes(x=long, y = lat, group = group), fill = 'white', color = "black") + 
      geom_point(aes(color=DaysEU),data=test2,size=1)+ 
      xlab('Longitude') + ylab('Latitude') +theme(plot.title = element_text(hjust = 0.5),legend.position="none") +
      scale_colour_manual(values = c("midnightblue", "darkgreen", "yellow2", "orange2", "orangered3", "firebrick4"),drop=FALSE)+
      coord_quickmap(xlim=c(-10,50),ylim=c(20,67))
  })

  # pt3 is a reactive function that filters the data for North America based on the components
  # a user selectsin order to produce the appropriate spatial plots  
  pt3<-reactive({
    
    #Filter North America subset based on selected year range
    test1 <- dfUS[dfUS$yeargroup==input$yearrange,] 
    
    #Filter North America subset based on population density distance
    if(input$km==1){
      test1$station_population_density=test1$station_max_population_density_5km
    }
    else
      test1$station_population_density=test1$station_max_population_density_25km
    
    #Create subset data frames based on selected population densities
    if(input$pop1){
      h1<- test1[test1$station_population_density <= 5000,]
    }
    else
      h1<-NULL
    
    if(input$pop2){
      h2<- test1[test1$station_population_density > 5000 & test1$station_population_density<= 10000,]
    }
    else
      h2<-NULL
    if(input$pop3){
      h3<- test1[test1$station_population_density > 10000 & test1$station_population_density<= 15000,]
    }
    else
      h3<-NULL
    if(input$pop4){
      h4 <- test1[test1$station_population_density > 15000 & test1$station_population_density<= 20000,]
    }
    else
      h4<-NULL
    if(input$pop5){
      h5 <- test1[test1$station_population_density > 20000,]
    }
    else
      h5<-NULL
    
    #Combine all population density subsets to form final data frame for East Asia based on filters 
    test1<-rbind(h1,h2,h3,h4,h5)
    
    #Define map based on if Region is selected
    if(!input$dous) return(NULL)
    
    #Define latitude and longitude for North America
    slatUS <- test1$station_lat
    slngUS <- test1$station_lon
    
    #Change cut of spatial plot based on health metric selected
    if(input$metric==1){
      DaysUS<-test1$nvgt070cut}
    else
      DaysUS<-test1$avgdma8epaxcut
    
    #produce final plot of North America 
    ggplot(test1,aes(x=slngUS,y=slatUS,group=DaysUS)) + 
      geom_polygon(data = us, aes(x=long, y = lat, group = group), fill = 'white', color = "black") + 
      geom_point(aes(color=DaysUS),data=test1,size=1)+ 
      xlab('Longitude') + ylab('Latitude') +theme(plot.title = element_text(hjust = 0.5),legend.position="none") +
      scale_colour_manual(values = c("midnightblue", "darkgreen", "yellow2", "orange2", "orangered3", "firebrick4"),drop=FALSE) +
      coord_quickmap(xlim = c(-135, -60),  ylim = c(20, 75))
  })
  
  #Filter plot output based on Regions selected
  output$plotgraph=renderPlot({
    if(is.null(pt2()) && is.null(pt3()) && !is.null(pt1())){
      grid.arrange(pt1(),ncol=1,widths=2)
    }
    else if(is.null(pt1()) && is.null(pt3()) && !is.null(pt2())){
      grid.arrange(pt2(),ncol=1)
    }
    else if(is.null(pt1()) && is.null(pt2()) && !is.null(pt3())){
      grid.arrange(pt3(),ncol=1)
    }
    else if(is.null(pt1()) && !is.null(pt3()) && !is.null(pt2())){
      grid.arrange(pt2(),pt3(),ncol=2,widths=c(1,1))
    }
    else if(!is.null(pt1()) && is.null(pt3()) && !is.null(pt2())){
      grid.arrange(pt1(),pt2(),ncol=2,widths=c(1,1))
    }    
    else if(!is.null(pt1()) && !is.null(pt3()) && is.null(pt2())){
      grid.arrange(pt1(),pt3(),ncol=2,widths=c(1,1))
    }
    else if(!is.null(pt1()) && !is.null(pt3()) && !is.null(pt2())){
      grid.arrange(pt1(),pt2(),pt3(),ncol=3,widths=c(1,1,1))
    }
    else
      return(NULL)
  })
  
  #Filter legend output based on health metric selected
  output$legend<-renderImage({
    if(input$metric==1)
      return(list(
        src = "images/legend.PNG",
        contentType = "image/PNG",
        alt = "legend1"
      ))
    else
      return(list(
        src = "images/legendavgdma8epax.PNG",
        contentType = "image/PNG",
        alt = "legend2"
      ))
  },deleteFile = FALSE)


})