
function(input, output) {
  # lazy evaluation needs to be called

 
  map_yr_cap=reactive(maptarget %>% filter(open_year<=input$map_year))


  output$tmap=renderPlot(
    ggplot() + 
      geom_polygon(data = map_data("usa"), aes(x=long, y = lat, group = group),
                   fill = '#FFFFFF', color = '#959595') + 
      geom_polygon(data = map_data("state"),aes(x = long, y = lat, group = group),
                   fill ='#FFFFFF', color = '#959595',size=0.2) +
      coord_fixed(1.3) +
      geom_point(map_yr_cap(), mapping = aes(x=lon, y=lat),color='#CC0000',size=0.9) + 
      xlab("") +
      ylab("") +
      theme_bw() +
      coord_map() +
      ggtitle("Targets Across the US") + 
      theme(axis.text = element_blank(),
            axis.ticks = element_blank(),
            panel.border = element_blank(),
            panel.grid.major = element_blank(),
            plot.title = element_text(hjust = 0.5))

  )
}

