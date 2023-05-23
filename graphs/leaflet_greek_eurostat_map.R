library(plotly)
library(readxl)
library(leaflet)
library(stringr)
library(dplyr)
library(leaflet)
library(leaflet.extras)
library(eurostat)
library(countrycode)


eu_nuts0 <- get_eurostat_geospatial(resolution = 1,
                                    nuts_level = 3,
                                    year = 2021) %>% filter(CNTR_CODE == "EL")
eu_nuts0$CNTR_CODE <- ifelse(eu_nuts0$CNTR_CODE=="UK","GB",
                             ifelse(eu_nuts0$CNTR_CODE=="EL","GR",eu_nuts0$CNTR_CODE))
eu_nuts0$country <- countrycode(eu_nuts0$CNTR_CODE,origin = "iso2c",destination = "country.name")



leaflet(options = leafletOptions())%>%#doubleClickZoom= FALSE, zoomControl = FALSE, dragging = FALSE, minZoom = 4, maxZoom = 4)) %>%
  addProviderTiles(provider = providers$CartoDB.VoyagerNoLabels) %>%
  addPolygons(data = eu_nuts0,
              # fillColor = ~colors,
              color = "black",
              opacity = 0.2,
              layerId = ~NUTS_NAME,
              # label = labels,
              fillOpacity = 0.85,
              weight = 1.5,
              dashArray = '',
              smoothFactor = 1,
              highlight = highlightOptions( # Make highlight pop out
                weight = 3.5,
                color = '#666',
                dashArray = "",
                fillOpacity = 0.5,
                bringToFront = F),
              popup = ~NUTS_NAME,
              popupOptions = popupOptions(
                style = list('font-weight' = 'normal', padding = '3px 8px'),
                textsize = '15px',
                maxWidght = 300,
                maxHeight = 350,
                direction = 'auto')
  )