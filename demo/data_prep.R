source("config.R")

# Read in population data ####

population_data <- read_csv(
  here(
    "data",
    "MYE01T02.csv"
  )
)

# Table 1: Population by age ####
## Create data frame of population by age ####

table_1_df <- population_data |> 
  filter(Year == 2025) |> 
  group_by(`Five year age bands`) |> 
  summarise(Population = sum(VALUE, na.rm = TRUE))

## Totals seem very high perhaps there is double counting ####

table_1_df <- population_data |> 
  filter(Year == 2025,
         `Local Government District` != "Northern Ireland",
         Sex != "All") |> 
  group_by(`Five year age bands`) |> 
  summarise(Population = sum(VALUE, na.rm = TRUE))

## Note that the Five year age bands column is sorted out of order ####
## A better approach would be to use the 5yrage column from raw data

table_1_df <- population_data |> 
  filter(Year == 2025,
         `Local Government District` != "Northern Ireland",
         Sex != "All") |> 
  mutate(`Age group` = factor(
    `5yrage`,
    levels = unique(population_data$`5yrage`),
    labels = unique(population_data$`Five year age bands`)
    )) |> 
  group_by(`Age group`) |> 
  summarise(Population = sum(VALUE, na.rm = TRUE))

# Table 2a: Population by Local Government District ####
table_2a_df <- population_data |> 
  filter(Year == 2025,
         `5yrage` != "All",
         Sex != "All") |> 
  group_by(`Local Government District`) |> 
  summarise(Population = sum(VALUE, na.rm = TRUE))

# Table 2b: Population by Sex ####
table_2b_df <- population_data |> 
  filter(Year == 2025,
         `5yrage` != "All",
         `Local Government District` != "Northern Ireland") |>
  mutate(Sex = factor(
    Sex,
    levels = unique(population_data$Sex),
    labels = unique(population_data$`Sex Label`)
  )) |> 
  group_by(Sex) |> 
  summarise(Population = sum(VALUE, na.rm = TRUE))
