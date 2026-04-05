library(dplyr)

# See all available projects and their latest dates
projectDates <- allData %>%
  group_by(ProjectName) %>%
  summarise(
    latestDate = as.Date(as.POSIXct(max(timestamp), origin="1970-01-01")),
    earliestDate = as.Date(as.POSIXct(min(timestamp), origin="1970-01-01")),
    totalBuilds = n(),
    lastCoverage = last(CoverageNow),
    firstCoverage = first(CoverageNow),
    language = first(lang)
  ) %>%
  arrange(latestDate)

print(projectDates, n = 47)