
function(input, output) {


  # reactive function for target location map
  map_yr_cap=reactive(maptarget %>% filter(open_year<=input$map_year))

  # target location map
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
    
  
  # per capita barchart
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
      ggplot(aes(x=reorder(state, -st_percap),y=st_percap))+
      geom_col(fill= '#CC0000')+
      theme_bw()+
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            plot.title = element_text(hjust = 0.5))+
      ylab('Stores per Million People')+
      xlab('US States')+
      ggtitle('Stores Per Capita')
  )
  
  # store number scatter plots
  # scatter_x_axis=reactive(
  #   target
  # )
  
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
  
  
  output$market=renderPlot(
    itemFrequencyPlot(target_mba,topN = 20)
  )
  rules = apriori(target_mba, parameter = list(supp=0.1, conf=0.8))
  rules = sort(rules, by='confidence', decreasing = TRUE)
  rules = rules[!is.redundant(rules)]
  subrules = head(sort(rules, by="lift"), 10)
  
  output$network=renderPlot(
    plot(subrules, method="graph",control=list(type="items",main=""))
  )
 
??arulesVis
    
}

# target = read.csv('/Users/judy/Desktop/rshiny/data/clean_join_target.csv')[,-1]
# library(arules)
# library(arulesViz)
# tagdf=select(temp1, capability)
# 
# into=c('v1','v2','v3','v4','v5','v6','v7','v8','v9','v10','v11','v12','v13','v14','v15','v16','v17')
# # separate capability to columns
# tagdf2=separate(tagdf,capability,into=into,sep=',')
# 
# head(tagdf2)
# # drop stores that have no tags
# tagdf2= filter(tagdf2,tagdf2$v1!="")
# 
# 
# 
# #write.csv(tagdf2, 'tag.csv',quote = FALSE, row.names = TRUE)
# 
# 
# # make transactions type
# trans = read.transactions('tag.csv', format = 'basket', sep=',')
# class(trans)
# summary(trans)
# # from summary
# 
# # check support levels to determine threshold
# arules::itemFrequencyPlot(trans, topN = 25)