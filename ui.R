
dashboardPage(
  dashboardHeader(title = "Target Location Analytics"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Graphs by State", tabName = "gstate")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
              # ggplot map
              plotOutput('tmap'),
              sliderInput('map_year', 'Year',
              min = 1962,
              max = 2017,
              value = 2017,
              sep="")
      )

    )
  )
  
)
