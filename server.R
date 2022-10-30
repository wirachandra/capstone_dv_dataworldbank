shinyServer(function(input, output) {
  
  output$plot_1 <- renderPlotly({
    country_population_clean <- 
      country_population %>% 
      filter(Country_Name %in% input$select_country) %>% 
      group_by(Year) %>%  
      mutate(label = glue("Country: {Country_Name}
                      Population: {scales::comma(population_num, accuracy =0.01)}")) %>% 
      arrange(desc(Year))
    
    plot1 <- 
      ggplot(data = head(country_population_clean, input$slider_year),
             mapping = aes(x= Year,
                           y= population_num,
                           text= label))+
      geom_line(group=1, color="blue") +
      geom_point()+
      scale_y_continuous(labels = scales::comma) +
      labs(title = glue("Population Growth in ", input$select_country),
           x = "Year",
           y = "Population") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))

    
    
    ggplotly(plot1, tooltip= "text")
    
  })

  output$plot_2 <- renderPlotly({
    country_gdp_clean <- 
      country_gdp %>% 
      filter(Country_Name %in% input$select_country) %>% 
      group_by(Year) %>%  
      mutate(label = glue("Country: {Country_Name}
                      GDP (current US$): {scales::comma(gdp_dollar, accuracy =0.01)}")) %>% 
      arrange(desc(Year))
    
    plot2 <- 
      ggplot(data = head(country_gdp_clean, input$slider_year),
             mapping = aes(x= Year,
                           y= gdp_dollar,
                           text= label))+
      geom_bar(stat="identity" ,  fill="#05c60d") +
      scale_y_continuous(labels = scales::comma) +
      labs(title = glue("GDP Growth in ", input$select_country),
           x = "Year",
           y = "GDP") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot2, tooltip= "text")
  })  
  
  output$plot_3 <- renderPlotly({
    country_inflation_clean <- 
      country_inflation %>% 
      filter(Country_Name %in% input$select_country) %>% 
      group_by(Year) %>%  
      mutate(label = glue("Country: {Country_Name}
                      Inflation, consumer prices (annual %): {scales::number(inflation_rate, accuracy = .01)}")) %>% 
      arrange(desc(Year))
    
    plot3 <- 
      ggplot(data = head(country_inflation_clean, input$slider_year),
             mapping = aes(x= Year,
                           y= inflation_rate,
                           text= label)) +
      geom_line(group=2,color="red") + 
      geom_point() +
      labs(title = glue("Fluctuation in the Inflation rate of ", input$select_country),
           x = "Year",
           y = "Inflation Rate") +
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot3, tooltip= "text")
  })  
  
  output$plot_4 <- renderPlotly({
    country_population_clean2 <- 
      country_population %>% 
      filter(Year %in% input$select_year) %>% 
      group_by(Country_Name) %>%  
      mutate(label = glue("Country: {Country_Name}
                      Population: {scales::comma(population_num, accuracy =0.01)}")) %>% 
      arrange(desc(population_num))
    
    plot4 <- 
      ggplot(data = head(country_population_clean2, input$slider_rank),
             mapping = aes(x= population_num,
                           y= reorder(Country_Name, population_num),
                           text= label))+
      geom_col(fill = "blue")+
      
      labs(title = glue("Top ", input$slider_rank, " Population in the World on year ", input$select_year),
           x = "Population",
           y = "Country") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot4, tooltip= "text")
    
  })  
  
  output$plot_5 <- renderPlotly({
    country_gdp_clean2 <- 
      country_gdp %>% 
      filter(Year %in% input$select_year) %>% 
      group_by(Country_Name) %>%  
      mutate(label = glue("Country: {Country_Name}
                      GDP (current US$): {scales::comma(gdp_dollar, accuracy =0.01)}")) %>% 
      arrange(desc(gdp_dollar))
    
    plot5 <- 
      ggplot(data = head(country_gdp_clean2, input$slider_rank),
             mapping = aes(x= gdp_dollar,
                           y= reorder(Country_Name, gdp_dollar),
                           text= label))+
      geom_col(fill = "#05c60d")+
      
      labs(title = glue("Top ", input$slider_rank, " GDP in the World on year ", input$select_year),
           x = "GDP",
           y = "Country") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot5, tooltip= "text")
    
  })
  output$plot_6 <- renderPlotly({
    country_inflation_clean2 <- 
      country_inflation %>% 
      filter(Year %in% input$select_year) %>% 
      group_by(Country_Name) %>%  
      mutate(label = glue("Country: {Country_Name}
                      Inflation, consumer prices (annual %): {scales::number(inflation_rate, accuracy = .01)}")) %>% 
      arrange(desc(inflation_rate))
    
    plot6 <- 
      ggplot(data = head(country_inflation_clean2, input$slider_rank),
             mapping = aes(x= inflation_rate,
                           y= reorder(Country_Name, inflation_rate),
                           text= label))+
      geom_col(fill = "red")+
      
      labs(title = glue("Top ", input$slider_rank, "  Inflation in the World on year ", input$select_year),
           x = "Inflation",
           y = "Country") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot6, tooltip= "text")
    
  })
  output$plot_7 <- renderPlotly({
    country_inflation_clean2 <- 
      country_inflation %>% 
      filter(Year %in% input$select_year) %>% 
      group_by(Country_Name) %>%  
      mutate(label = glue("Country: {Country_Name}
                      Inflation, consumer prices (annual %): {scales::number(inflation_rate, accuracy = .01)}")) %>% 
      arrange(desc(inflation_rate))
    
    plot7 <- 
      ggplot(data = tail(country_inflation_clean2, input$slider_rank),
             mapping = aes(x= inflation_rate,
                           y= reorder(Country_Name, inflation_rate),
                           text= label))+
      geom_col(fill = "green")+
      
      labs(title = glue("Top ", input$slider_rank, "  Deflation in the World on year ", input$select_year),
           x = "Deflation",
           y = "Country") +
      theme_minimal()+
      theme(legend.position = "none",
            text = element_text(size = 6, face = "bold"))
    
    ggplotly(plot7, tooltip= "text")
    
  })
  output$table <- renderDataTable({
    datatable(countrydata,
              options = list(scrollX = TRUE))})  

  })
  

