# --------- LOAD LIBRARIES
library(shiny)
library(shinydashboard)
library(DT) 
options(scipen = 99) 
library(tidyverse) 
library(plotly) 
library(glue) 
library(scales) 
library(ggplot2)
library(dplyr)

# --------- DATA PREPARATION
#Read CSV downloaded from https://databank.worldbank.org/source/world-development-indicators
dataworldbank <- read_csv("data_input/economy_data.csv")

#Rename Data Column
dataworldbank <- 
  rename(dataworldbank,
         'Country_Name' = 'Country Name',
         'Country_Code' = 'Country Code',
         'Series_Code' = 'Series Code',
         'Series_Name' = 'Series Name',
         '2002' = '2002 [YR2002]',
         '2003' = '2003 [YR2003]',
         '2004' = '2004 [YR2004]',
         '2005' = '2005 [YR2005]',
         '2006' = '2006 [YR2006]',
         '2007' = '2007 [YR2007]',
         '2008' = '2008 [YR2008]',
         '2009' = '2009 [YR2009]',
         '2010' = '2010 [YR2010]',
         '2011' = '2011 [YR2011]',
         '2012' = '2012 [YR2012]',
         '2013' = '2013 [YR2013]',
         '2014' = '2014 [YR2014]',
         '2015' = '2015 [YR2015]',
         '2016' = '2016 [YR2016]',
         '2017' = '2017 [YR2017]',
         '2018' = '2018 [YR2018]',
         '2019' = '2019 [YR2019]',
         '2020' = '2020 [YR2020]',
         '2021' = '2021 [YR2021]')

#Change Data Type
dataworldbank <- dataworldbank %>% 
  mutate(`Country_Name` = as.factor(`Country_Name`),
         `Country_Code` = as.factor(`Country_Code`),
         `Series_Name` = as.factor(`Series_Name`),
         `Series_Code` = as.factor(`Series_Code`),
         `2002` =  as.numeric(`2002`),
         `2003` =  as.numeric(`2003`),
         `2004` =  as.numeric(`2004`),
         `2005` =  as.numeric(`2005`),
         `2006` =  as.numeric(`2006`),
         `2007` =  as.numeric(`2007`),
         `2008` =  as.numeric(`2008`),
         `2009` =  as.numeric(`2009`),
         `2010` =  as.numeric(`2010`),
         `2011` =  as.numeric(`2011`),
         `2012` =  as.numeric(`2012`),
         `2013` =  as.numeric(`2013`),
         `2014` =  as.numeric(`2014`),
         `2015` =  as.numeric(`2015`),
         `2016` =  as.numeric(`2016`),
         `2017` =  as.numeric(`2017`),
         `2018` =  as.numeric(`2018`),
         `2019` =  as.numeric(`2019`),
         `2020` =  as.numeric(`2020`),
         `2021` =  as.numeric(`2021`))

#Shaping Data Frame
dataworldbank <- pivot_longer(data = dataworldbank, names_to = 'Year', values_to = 'value',
                              "2002":"2021")
dataworldbank <- 
  dataworldbank %>% 
  select('Country_Name','Country_Code','Year','Series_Name', 'value')

dataworldbank <- 
  dataworldbank %>% 
  group_by(Series_Name) %>%
  mutate(row = row_number()) %>%
  tidyr::pivot_wider(names_from = Series_Name, values_from = value) %>%
  select(-row)

#Drop NA Country Code
dataworldbank <- 
dataworldbank %>% drop_na(Country_Code)

#Change NA Value in dataframe to Zero 0
dataworldbank[is.na(dataworldbank)] <- 0
dataworldbank

#Only keep Country dataframe
countrydata <- 
  subset(dataworldbank, !Country_Name %in% c("Africa Eastern and Southern",
                                             "Africa Western and Central",
                                             "Arab World",
                                             "Caribbean small states",
                                             "Central Europe and the Baltics",
                                             "Early-demographic dividend",
                                             "East Asia & Pacific",
                                             "East Asia & Pacific (excluding high income)",
                                             "East Asia & Pacific (IDA & IBRD countries)",
                                             "Euro area",
                                             "Europe & Central Asia",
                                             "Europe & Central Asia (excluding high income)",
                                             "Europe & Central Asia (IDA & IBRD countries)",
                                             "European Union",
                                             "Fragile and conflict affected situations",
                                             "Heavily indebted poor countries (HIPC)",
                                             "High income",
                                             "IBRD only",
                                             "IDA & IBRD total",
                                             "IDA blend",
                                             "IDA only",
                                             "IDA total",
                                             "Late-demographic dividend",
                                             "Latin America & Caribbean",
                                             "Latin America & Caribbean (excluding high income)",
                                             "Latin America & the Caribbean (IDA & IBRD countries)",
                                             "Least developed countries: UN classification",
                                             "Low & middle income",
                                             "Low income",
                                             "Lower middle income",
                                             "Middle East & North Africa",
                                             "Middle East & North Africa (excluding high income)",
                                             "Middle East & North Africa (IDA & IBRD countries)",
                                             "Middle income",
                                             "North America",
                                             "Not classified",
                                             "OECD members",
                                             "Other small states",
                                             "Pacific island small states",
                                             "Post-demographic dividend",
                                             "Pre-demographic dividend",
                                             "Small states",
                                             "South Asia",
                                             "South Asia (IDA & IBRD)",
                                             "Sub-Saharan Africa",
                                             "Sub-Saharan Africa (excluding high income)",
                                             "Sub-Saharan Africa (IDA & IBRD countries)",
                                             "Upper middle income",
                                             "World"), )


country_population <- 
  countrydata %>% 
  select('Country_Name','Country_Code','Year','Population, total')
country_population <- 
  rename(country_population,
         'population_num' = 'Population, total')

country_gdp <- 
  countrydata %>% 
  select('Country_Name','Country_Code','Year','GDP (current US$)')
country_gdp <- 
  rename(country_gdp,
         'gdp_dollar' = 'GDP (current US$)')

country_inflation <- 
  countrydata %>% 
  select('Country_Name','Country_Code','Year','Inflation, consumer prices (annual %)')
country_inflation <- 
  rename(country_inflation,
         'inflation_rate' = 'Inflation, consumer prices (annual %)')




country_gdp_max1 <- 
  country_gdp %>% 
  arrange(desc(gdp_dollar)) %>% 
  head(1)
