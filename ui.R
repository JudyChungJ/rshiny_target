
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
              sliderInput('map_year', 'Year',
                    min = 1962,
                    max = 2017,
                    value = 2017,
                    sep=""),
                h1('hi there')
      ),
      tabItem(tabName = 'gstate',
              h1('some stuff'),
              # barchart
              plotOutput('capbar'),
              
              # scatterplots
              plotOutput('scatter'),
              radioButtons('axis','Select Parameter:',
                           choices=list("Population in Millions"="st_pop_1m",
                                        "Per Capita Income USD" = "st_percap_income_usd",
                                        "Education Bachelors Level" = 'st_bach_p',
                                        "Percent Poverty" = 'st_pov_p'
                                        )
              )
              ),
      tabItem(tabName = 'mba',
              h1('market basket analysis')
              
              )

    )
  )
)

