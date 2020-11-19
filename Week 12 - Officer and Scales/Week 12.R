library(tidyverse)
library(lubridate)
houses <- read_csv("~/Documents/BYU/Week 11 - Density and Non Standard/cleaned_parcels.csv")

houses <- houses %>%
  select(parcel_number, property_add, market_value, year_built) %>%
  separate(property_add, c("address", "city"), sep = ",") %>%
  mutate(city = trimws(city)) %>%
  filter(market_value > 0,
         market_value < 1000000,
         year_built > 0,
         year_built < 2019,
         city %in% c("WOODLAND", "STRAWBERRY", "MIDWAY", "KAMAS", "HEBER"))
# officer -----------------------------------------------------------------
library(officer)

# Helper functions
annotate_base(path = "BYU/Week 1 - PowerPoint/Template.pptx", output_file = "~/Desktop/annotated_base.pptx") 

# Read in your template
my_pres <- read_pptx("BYU/Week 1 - PowerPoint/Template.pptx")

# Add a slide
my_pres <- my_pres %>%
  add_slide(layout ="Title Slide", master = "2_Office Theme")

# Add placeholders to your slide with content
my_pres <- my_pres %>%
  ph_with(value = "Example Presentation", location = ph_location_label(ph_label = "Title 1"))

my_plot <- ggplot(houses) +
  geom_histogram(aes(x = year_built)) +
  labs(title = "Overall") + 
  ggthemes::theme_wsj()

my_plot
my_pres <- my_pres %>%
  add_slide(layout ="Center Content", master = "2_Office Theme") %>%
  ph_with(value = my_plot, location = ph_location_label(ph_label = "Chart Placeholder 5"))

# Repeat as needed

cities <- unique(houses$city)

for(i in 1:length(cities)) {
  my_plot <- houses %>%
    filter(city == cities[i]) %>%
    ggplot() +
    geom_histogram(aes(x = year_built)) +
    labs(title = cities[i])
  
  my_pres <- my_pres %>%
    add_slide(layout ="Center Content", master = "2_Office Theme") %>%
    ph_with(value = my_plot, location = ph_location_label(ph_label = "Chart Placeholder 5"))
}


# Install xquartz if on Mac (https://www.xquartz.org/) and you have Cairo errors

# Save your PowerPoint
print(my_pres, "~/Desktop/example.pptx")


# scales ------------------------------------------------------------------

# library(scales) # Don't load the scales library for better autocompletion

# Before
ggplot(houses) + 
  geom_point(aes(y = market_value, x = year_built, color = city), alpha = 0.3)

# After
ggplot(houses) + 
  geom_point(aes(y = market_value, x = year_built, color = city), alpha = 0.3) +
  scale_y_continuous(labels = scales::dollar_format(), n.breaks = 10) +
  scale_x_continuous(limits = c(1980, 2018))
  
# Before
ggplot(diamonds) + 
  geom_point(aes(y = price, x = carat, color = color)) 

# After
ggplot(diamonds) + 
  geom_point(aes(y = price, x = carat, color = color)) + 
  scale_y_continuous(labels = scales::label_number_si())

?scales::label_number_si()

ggplot(diamonds) + 
  geom_point(aes(y = price/1000, x = carat, color = color)) + 
  scale_y_continuous(labels = scales::label_comma(accuracy = 2, suffix = "K"))
  
?scales::label_comma
# Before
economics %>% 
  filter(date < ymd("1970-01-01")) %>% 
  ggplot(aes(date, pce)) + 
  geom_line()

# After
economics %>% 
  filter(date < ymd("1970-01-01")) %>% 
  ggplot(aes(date, pce)) + 
  geom_line() + 
  scale_x_date(NULL,
               breaks = scales::breaks_width("3 months"), 
               labels = scales::label_date_short()
  ) + 
  scale_y_continuous("Personal consumption expenditures",
                     breaks = scales::breaks_extended(8),
                     labels = scales::label_dollar()  
  )

