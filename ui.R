
dashboardPage(skin='red',     
            
  dashboardHeader(title = 'Target Analysis'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Map', tabName = 'map', icon = icon('map')),
      menuItem('State-level Analyses', tabName = "gstate", icon = icon('chart-bar')),
      menuItem('What to Include', tabName = 'mba', icon = icon('question')),
      menuItem('Table', tabName = 'data', icon = icon('table')),
      menuItem('About Judy', tabName = "judy", icon = icon('id-badge'))
    )
  ),
  dashboardBody(
 
    tabItems(
      tabItem(tabName = 'map',
              # ggplot map
              h1('Target Location Analytics'),
              plotOutput('tmap'),
              fluidRow(
                column(6,
                       sliderInput('map_year', 'Year:',
                                   min = 1962,
                                   max = 2017,
                                   value = 2017,
                                   sep="")
                       ),
                column(6,
                       h5('Map shows locations of all Target stores opened in the 
                          continental US up to 2017. Move the slider to adjust the 
                          year to see the growth over time.'))
              ),
              
              h3('Introduction:'),
              h4("Target is the 8th largest retailer in the US. In 2017 it's revenue
                 topped $69 million with 1,802 store nationwide. This study's main goal
                 is to reveal key insights in location analytics from a retail powerhouse.")
      ),
      tabItem(tabName = 'gstate',
              fluidRow(
                column(5,
                       h2('Store Per Capita'),
                       # barchart
                       plotOutput('capbar'),
                ),
                column(7,
                       h2('Demographic Scatterplots'),
                       # scatterplots
                       plotOutput('scatter'),
                       fluidRow(
                         column(6,
                                radioButtons('axis','Select Parameter:',
                                             choices=list("Population in Millions"="st_pop_1m",
                                                          "Per Capita Income USD" = "st_percap_income_usd",
                                                          "Education Bachelors Level" = 'st_bach_p',
                                                          "Percent Poverty" = 'st_pov_p'
                                             )
                                )
                         ),
                         column(6,
                           h5('Select the demographic information to see it plotted against 
                              store numbers on the graph above.'),
                           h5( 'The data are state level and from the
                               Bureau of Economic Analysis (2016). Correlation coefficient and p_values
                               are included on the graph.')
                         )
                       )

                )
              )

      ),
      tabItem(tabName = 'mba',
              h1('Market Basket Analysis'),
              h3('Relative Capability Frequency'),
              plotOutput('market'),
              h3('Network Plot'),
              visNetworkOutput('network')
            
                
      ),
      tabItem(tabName = 'data',
              DT::dataTableOutput('table')
      ),
      tabItem(tabName = 'judy',
              fluidRow(
                column(4,
                       img(src='profile.jpg',width='100%')),
                column(7,
                       h2("Judy Chung"),
                       h5('judychung.j@gmail.com'),
                       tags$a(
                         href="https://www.linkedin.com/in/judy-chung-366abb143/",
                         'LinkedIn'
                         ),
                       br(),
                       tags$a(
                         href="https://github.com/JudyChungJ",
                         'GitHub'
                       ),
                      h5('I graduated from UC Berkeley with a Bachelors in
                         Biology and have since then conducted research on insect control, 
                         fire ecology, and soil microbiology.
                         I have always been driven by my questions. I enjoy the process of 
                         observing complex systems and feel compelled to conduct experiments to 
                         derive useful insights. Being a data scientist is a part of this 
                         exciting journey of exploring this complicated yet wonderful world.
                         Thank you for taking the time to explore my shiny app!')
                  )
              )
        
      )
      

    )
  )
)

