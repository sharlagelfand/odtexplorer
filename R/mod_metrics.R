#' metrics UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_metrics_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    "metrics",

    fluidRow(
      shinydashboard::box(
        width = 12,
        fluidRow(
          column(
            width = 6,
            plotOutput(ns("topics"))
          ),
          column(
            width = 6,
            plotOutput(ns("civic_issues"))
          )
        ),
        fluidRow(
          column(
            width = 6,
            plotOutput(ns("refresh_rate"))
          ),
          column(
            width = 6,
            plotOutput(ns("last_refreshed"))
          )
        )
      )
    )
  )
}

#' metrics Server Function
#'
#' @noRd
mod_metrics_server <- function(input, output, session) {
  ns <- session$ns

  output$topics <- renderPlot(
    packages %>%
      dplyr::filter(!is.na(topics_long)) %>%
      dplyr::count(topics_long) %>%
      ggplot2::ggplot(ggplot2::aes(x = n, y = forcats::fct_reorder(topics_long, n))) +
      ggplot2::geom_col() +
      ggplot2::labs(x = NULL, y = NULL, title = "Topics") +
      ggplot2::theme_minimal(16) +
      ggplot2::theme(plot.title.position = "plot")
  )

  output$civic_issues <- renderPlot(
    packages %>%
      dplyr::filter(!is.na(civic_issues_long)) %>%
      dplyr::count(civic_issues_long) %>%
      ggplot2::ggplot(ggplot2::aes(x = n, y = forcats::fct_reorder(civic_issues_long, n))) +
      ggplot2::geom_col() +
      ggplot2::labs(x = NULL, y = NULL, title = "Civic Issues") +
      ggplot2::theme_minimal(16) +
      ggplot2::theme(plot.title.position = "plot")
  )

  output$refresh_rate <- renderPlot(
    packages %>%
      dplyr::filter(!is.na(refresh_rate)) %>%
      dplyr::count(refresh_rate) %>%
      ggplot2::ggplot(ggplot2::aes(x = n, y = forcats::fct_reorder(refresh_rate, n))) +
      ggplot2::geom_col() +
      ggplot2::labs(x = NULL, y = NULL, title = "Refresh Rates") +
      ggplot2::theme_minimal(16) +
      ggplot2::theme(plot.title.position = "plot")
  )

  output$last_refreshed <- renderPlot(
    packages %>%
      dplyr::filter(!is.na(last_refreshed)) %>%
      dplyr::count(last_refreshed) %>%
      ggplot2::ggplot(ggplot2::aes(x = last_refreshed, y = n)) +
      ggplot2::geom_line() +
      ggplot2::labs(x = NULL, y = NULL, title = "Last Refreshed") +
      ggplot2::theme_minimal(16) +
      ggplot2::theme(plot.title.position = "plot")
  )
}
