#' About UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_about_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    "about",
    fluidRow(
      shinydashboard::box(
        width = 12,
        includeMarkdown(app_sys("app/www/about.md"))
      )
    )
  )
}

#' About Server Function
#'
#' @noRd
mod_about_server <- function(input, output, session) {
  ns <- session$ns
}
