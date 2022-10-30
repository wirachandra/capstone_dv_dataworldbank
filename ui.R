dashboardPage(skin = "blue", 
  
  dashboardHeader(title = span(tagList(icon("book"), "World Economics"))),

  dashboardSidebar(
    
    sidebarMenu(
      menuItem(
        text= "Overview Trend per Country",
        tabName= "tab_1",
        icon= icon("globe")
      ),
      menuItem(
        text= "Ranking per Year",
        tabName= "tab_2",
        icon= icon("ranking-star")
      ),
      menuItem(
        text= "Data",
        tabName= "tab_3",
        icon= icon("book")
      ),
      menuItem("Source Code", icon = icon("code"), 
               href = "https://github.com/wirachandra")
    )  
  ),
    

  dashboardBody(
    tabItems(
      tabItem(tabName= "tab_1",
              
              fluidRow(
                infoBox(title= "Total Country ",
                        value= length(unique(unique(countrydata$Country_Name))),
                        icon= icon("globe"),
                        color= "blue"),
                infoBox(title= "Highest Population Country",
                        value= "China",
                        icon= icon("person"),
                        color= "navy"),
                infoBox(title= "Highest GDP Country",
                        value= "United States",
                        icon= icon("money-bill-1"),
                        color= "green"),
              ),
              fluidRow(
                box(width = 12, 
                    selectInput(inputId = "select_country",
                                label = "Choose a Country:",
                                choices = unique(country_population$Country_Name))
                )
              ),
                fluidRow(
                  box(width = 12,              
                    sliderInput(inputId="slider_year",
                                label="Select Range of Year",
                                min=5,
                                max=20,
                                value=10)
                  )
                ),
                fluidRow(
                  box(width = 12,
                      plotlyOutput(outputId = "plot_1")),
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_2")),
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_3")),
              ),
              ),
      tabItem(tabName = "tab_2",
              fluidRow(
                box(width = 12, 
                    selectInput(inputId = "select_year",
                                label = "Choose Period (in Year):",
                                choices = unique(country_population$Year))
                )
              ),
              fluidRow(
                box(width = 12,              
                    sliderInput(inputId="slider_rank",
                                label="Top n Country: ",
                                min=5,
                                max=20,
                                value=10)
                )
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_4")),
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_5")),
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_6")),
              ),
              fluidRow(
                box(width = 12,
                    plotlyOutput(outputId = "plot_7")),
              ),
      ),
      
      tabItem(tabName = "tab_3",
              dataTableOutput("table"),
              br(),
              br(),
              p(align = "left",
                "This dataset was from https://databank.worldbank.org/source/world-development-indicators#  which has been shaped and cleaned before I begin to process the data."),
              p(align = "left",
                "The detail process of the shaping/cleaning was stored in global.R"),
              br(),
              p(align = "left",
                "The N/A value data from databank-worldbank has been filled with 0 (zero) value.")
              )
      )
    )
  )
