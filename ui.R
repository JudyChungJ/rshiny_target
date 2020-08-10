
dashboardPage(skin='red',     
            
  dashboardHeader(title = 'Target Location Analytics'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Map', tabName = 'map', icon = icon('map')),
      menuItem('State-level Analyses', tabName = "gstate", icon = icon('chart-bar')),
      menuItem('What to Build', tabName = 'mba', icon = icon('question')),
      menuItem('Data', tabName = 'data', icon = icon('database')),
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
                       h2('Store Per Capita')
                ),
                column(7,
                       h2('Demographic Scatterplots')
                )
              ),
              fluidRow(
                column(5,
                       # barchart
                       plotOutput('capbar'),
                ),
                column(7,
                       # scatterplots
                       plotOutput('scatter'),
                       radioButtons('axis','Select Parameter:',
                                    choices=list("Population in Millions"="st_pop_1m",
                                                 "Per Capita Income USD" = "st_percap_income_usd",
                                                 "Education Bachelors Level" = 'st_bach_p',
                                                 "Percent Poverty" = 'st_pov_p'
                                    )
                       )                 
                )
              )

      ),
      tabItem(tabName = 'mba',
              h1('market basket analysis'),
              plotOutput('market'),
              h1('Network Graph'),
              plotOutput('network')
            
                
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
                         'linkedin'
                         ),
                       br(),
                       tags$a(
                         href="https://github.com/JudyChungJ",
                         'github'
                       ),
                      h5('I graduated from UC Berkeley with a Bachelors in
                         Biology and have since worked many systems including 
                         insect control, fire ecology, and soil microbiology
                         with a focus on fungi. I have always been driven by research
                         and deriving insights from complex systems and improving
                         . Data science is
                         that next step in the wider world of data ')
                  )
              )
        
      )
      

    )
  )
)

