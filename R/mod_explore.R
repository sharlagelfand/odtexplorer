#' Explore Available Data UI Function
#'
#' @description A shiny module for the Explore Available Data page.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom shinyWidgets pickerInput
mod_explore_ui <- function(id) {
  ns <- NS(id)

  tabItem(
    "explore",

    fluidRow(
      shinydashboard::box(
        title = "Dataset Filters",
        width = 12,
        column(
          width = 6,
          pickerInput(ns("topics"),
            label = "Topic",
            choices = topics,
            multiple = TRUE,
            options = list(`actions-box` = TRUE)
          )
        ),
        column(
          width = 6,
          pickerInput(ns("civic_issues"),
            label = "Civic Issues",
            choices = civic_issues,
            multiple = TRUE,
            options = list(`actions-box` = TRUE)
          )
        )
      ),
      shinydashboard::box(
        title = "Datasets",
        width = 12,
        DT::DTOutput(ns("datasets"))
      )
    )
  )
}

#' Explore Available Data Server Function
#'
#' @noRd
mod_explore_server <- function(input, output, session) {
  ns <- session$ns

  output$datasets <- DT::renderDT(
    {
      packages_f <- packages

      if (!is.null(input$topics)) {
        packages_f <- packages_f %>%
          dplyr::filter(topics_long %in% input$topics)
      }

      if (!is.null(input$civic_issues)) {
        packages_f <- packages_f %>%
          dplyr::filter(civic_issues_long %in% input$civic_issues)
      }

      packages_f %>%
        dplyr::distinct(title, topics, civic_issues, excerpt, refresh_rate, last_refreshed) %>%
        dplyr::rename(Title = title, Topics = topics, `Civic Issues` = civic_issues, Excerpt = excerpt, `Refresh Rate` = refresh_rate, `Last Refreshed` = last_refreshed)
    },
    rownames = FALSE,
    selection = "single"
  )
}

## To be copied in the UI
# mod_explore_ui("explore")

## To be copied in the server
# callModule(mod_explore_server, "explore_ui_1")
