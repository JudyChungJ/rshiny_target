
function(input, output) {


  # REACTIVE FUNCTION FOR TARGET LOCATION MAP
  map_yr_cap=reactive(maptarget %>% filter(open_year<=input$map_year))

  # STORE LOCATIONS MAP
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
    
  
  # PER CAPITA BAR CHARTS
  output$capbar=renderPlot(
    target %>% 
      filter(st_pop!=is.na(st_pop)) %>% 
      group_by(state) %>% 
      dplyr::summarise(st_pop_1m = st_pop/1000000,
                        st_nstore=n(),
                        st_percap=st_nstore/mean(st_pop_1m)) %>% 
      distinct() %>% 
      arrange(desc(st_percap)) %>% 
      head(.,20) %>% 
      ggplot(aes(x=reorder(state, st_percap),y=st_percap))+
      geom_col(fill= '#CC0000')+
      theme_bw()+
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            plot.title = element_text(hjust = 0.5))+
      ylab('Stores per Million People')+
      xlab('US States')+
      coord_flip()
  )
  
  # STORE NUMBER SCATTER PLOTS
  output$scatter=renderPlot(
    target%>% 
      filter(st_pop!=is.na(st_pop)) %>% 
      group_by(state) %>% 
      dplyr::mutate(st_pop_1m = st_pop/1000000,
                    st_nstore=n(),
                    st_percap=st_nstore/mean(st_pop)) %>%
      select(st_nstore, x=input$axis) %>% 
      ggplot(aes(x=x, y=st_nstore))+
      geom_point(color='#CC0000')+
      geom_smooth(method='lm', color='#000000', size=0.5)+
      stat_cor(method = 'pearson')+
      theme_bw()+
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            plot.title = element_text(hjust = 0.5))+
      ylab('Number of Stores')+
      xlab(ifelse(input$axis=='st_percap_income_usd', 
                  'Per Capita Income USD', 
                  ifelse(input$axis=='st_bach_p',
                         'Percent Population with Bachelors Degree',
                         ifelse(input$axis=='st_pov_p',
                                'Percent Population Under Poverty Threshold',
                  'Population in Millions')))
                           
                         )
  )
  
  # MARKET BASKET ITEM FREQUENCY BAR CHART
  output$market=renderPlot(
    itemFrequencyPlot(target_mba,topN = 20)
  )
  
  # APRIORI ALGORITHM
  rules = apriori(target_mba, parameter = list(supp=0.1, conf=0.8))
  rules = sort(rules, by='confidence', decreasing = TRUE)
  rules = rules[!is.redundant(rules)]
  subrules = head(sort(rules, by="lift"), 10)
  
  
  # MARKET BASKET NETWORK GRAPH
  output$network=renderVisNetwork(
    plot(subrules, method="graph",control=list(type="items",main=""),engine = "htmlwidget")
  )
  
  #engine = "htmlwidget"

  # DATA TABLE
  output$table = DT::renderDataTable({
    datatable(target, rownames=F)
  })
 
    
}