library(opendatatoronto)
library(tidyr)
library(dplyr)

packages <- list_packages(limit = 500)

packages_topics_long <- packages %>%
  separate_rows(topics, sep = ",") %>%
  select(id, topics)

packages_civic_issues_long <- packages %>%
  separate_rows(civic_issues, sep = ",") %>%
  select(id, civic_issues)

packages <- packages %>%
  left_join(packages_topics_long, by = "id", suffix = c("", "_long")) %>%
  left_join(packages_civic_issues_long, by = "id", suffix = c("", "_long"))

usethis::use_data(packages, overwrite = TRUE)

topics <- packages_topics_long %>%
  pull(topics) %>%
  unique() %>%
  sort()

usethis::use_data(topics, overwrite = TRUE)

civic_issues <- packages_civic_issues_long %>%
  pull(civic_issues) %>%
  unique() %>%
  sort()

usethis::use_data(civic_issues, overwrite = TRUE)
