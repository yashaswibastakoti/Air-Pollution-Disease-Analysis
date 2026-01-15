install.packages("tidyverse")
library(tidyverse)
library(lubridate)
library(ggplot2)

#load the clean dataset
data <- read.csv("data/processed/cleaned_pollution.csv")
glimpse(data)
summary(data)

#EDA
#lets create time variables (Year, Month)
data <- data %>%
  mutate(
    year = year(Date.Local),
    month = month(Date.Local, label = TRUE)
  )

#lets check national pollution trends over time now
#NO2 trend
no2_yearly <- data %>%
  group_by(year) %>%
  summarise(mean_no2 = mean(NO2.Mean, na.rm = TRUE))

#ggplot
p_no2<- ggplot(no2_yearly, aes(x= year, y = mean_no2))+
  geom_line()+
  labs(
    title = "Average NO2 levels in the U.S. over time",
    x= "Year",
    y = "NO2 Mean(ppb)"
  )
p_no2

#saving it to visuals folder
ggsave(
  filename= "visuals/timeseries/no2_trend_us.png",
  plot= p_no2,
  width = 8,
  height = 5,
  dpi= 300
)

#O3 trend
o3_yearly <- data %>%
  group_by(year) %>%
  summarise(mean_o3 = mean(O3.Mean, na.rm = TRUE))

#ggplot
p_o3 <- ggplot(o3_yearly, aes(x = year, y = mean_o3)) +
  geom_line(color = "darkgreen") +
  labs(
    title = "Average Ozone (O3) Levels in the U.S. Over Time",
    x = "Year",
    y = "O3 Mean (ppm)"
  )
p_o3


#saving it to visuals folder
ggsave(
  filename = "visuals/timeseries/o3_trend_us.png",
  plot = p_o3,
  width = 8,
  height = 5,
  dpi = 300
)

#SO2 trend
so2_yearly <- data %>%
  group_by(year) %>%
  summarise(mean_so2 = mean(SO2.Mean, na.rm = TRUE))

#ggplot
p_so2 <- ggplot(so2_yearly, aes(x = year, y = mean_so2)) +
  geom_line(color = "purple") +
  labs(
    title = "Average SO2 Levels in the U.S. Over Time",
    x = "Year",
    y = "SO2 Mean (ppb)"
  )

#display
p_so2

#saving to visuals folder
ggsave(
  filename = "visuals/timeseries/so2_trend_us.png",
  plot = p_so2,
  width = 8,
  height = 5,
  dpi = 300
)

#CO trend
co_yearly <- data %>%
  group_by(year) %>%
  summarise(mean_co = mean(CO.Mean, na.rm = TRUE))

#ggplot
p_co <- ggplot(co_yearly, aes(x = year, y = mean_co)) +
  geom_line(color = "orange") +
  labs(
    title = "Average CO Levels in the U.S. Over Time",
    x = "Year",
    y = "CO Mean (ppm)"
  )

#display
p_co

#saving to visuals folder
ggsave(
  filename = "visuals/timeseries/co_trend_us.png",
  plot = p_co,
  width = 8,
  height = 5,
  dpi = 300
)


# Combine all pollutants into one dataframe for plotting
pollutants_yearly <- data.frame(
  year = no2_yearly$year,
  NO2 = no2_yearly$mean_no2,
  O3  = o3_yearly$mean_o3,
  SO2 = so2_yearly$mean_so2,
  CO  = co_yearly$mean_co
)

# Convert to long format for ggplot
pollutants_long <- pollutants_yearly %>%
  pivot_longer(cols = -year, names_to = "Pollutant", values_to = "Mean")

# Multi-line plot
p_combined <- ggplot(pollutants_long, aes(x = year, y = Mean, color = Pollutant)) +
  geom_line(size = 1) +
  labs(
    title = "Average Pollution Levels in the U.S. Over Time",
    x = "Year",
    y = "Mean Concentration",
    color = "Pollutant"
  ) +
  theme_minimal() +
  scale_color_manual(values = c("NO2" = "blue", "O3" = "darkgreen", "SO2" = "purple", "CO" = "orange"))

# Display
p_combined

# Save combined plot
ggsave(
  filename = "visuals/timeseries/combined_pollutants_us.png",
  plot = p_combined,
  width = 10,
  height = 6,
  dpi = 300
)

#now lets see state-level trends
#lets start by creating yearly averages of pollutants per state
# Aggregate data by State and Year
state_pollution <- data %>%
  group_by(State, year) %>%
  summarise(
    mean_no2 = mean(NO2.Mean, na.rm = TRUE),
    mean_o3  = mean(O3.Mean, na.rm = TRUE),
    mean_so2 = mean(SO2.Mean, na.rm = TRUE),
    mean_co  = mean(CO.Mean, na.rm = TRUE)
  ) %>%
  ungroup()

# Check the first few rows
head(state_pollution)

#saving state pollution dataset/aggregated data for future analyses
write.csv(state_pollution, "data/processed/state_pollution.csv", row.names = FALSE)

#NO2 trend by state
p_no2_state <- ggplot(state_pollution, aes(x = year, y = mean_no2, color = State)) +
  geom_line() +
  labs(
    title = "State-wise Average NO2 Levels in the U.S.",
    x = "Year",
    y = "NO2 Mean (ppb)"
  ) +
  theme(legend.position = "bottom")

# Display
p_no2_state

# Save
ggsave(
  filename = "visuals/timeseries/no2_trend_states.png",
  plot = p_no2_state,
  width = 10,
  height = 6,
  dpi = 300
)
#O3 trend by state
p_o3_state <- ggplot(state_pollution, aes(x = year, y = mean_o3, color = State)) +
  geom_line() +
  labs(
    title = "State-wise Average O3 Levels in the U.S.",
    x = "Year",
    y = "O3 Mean (ppm)"
  ) +
  theme(legend.position = "bottom")

p_o3_state

ggsave(
  filename = "visuals/timeseries/o3_trend_states.png",
  plot = p_o3_state,
  width = 10,
  height = 6,
  dpi = 300
)

# SO2 trend by state
p_so2_state <- ggplot(state_pollution, aes(x = year, y = mean_so2, color = State)) +
  geom_line() +
  labs(
    title = "State-wise Average SO2 Levels in the U.S.",
    x = "Year",
    y = "SO2 Mean (ppb)"
  ) +
  theme(legend.position = "bottom")

p_so2_state

ggsave(
  filename = "visuals/timeseries/so2_trend_states.png",
  plot = p_so2_state,
  width = 10,
  height = 6,
  dpi = 300
)

# CO trend by state

p_co_state <- ggplot(state_pollution, aes(x = year, y = mean_co, color = State)) +
  geom_line() +
  labs(
    title = "State-wise Average CO Levels in the U.S.",
    x = "Year",
    y = "CO Mean (ppm)"
  ) +
  theme(legend.position = "bottom")

p_co_state

ggsave(
  filename = "visuals/timeseries/co_trend_states.png",
  plot = p_co_state,
  width = 10,
  height = 6,
  dpi = 300
)


