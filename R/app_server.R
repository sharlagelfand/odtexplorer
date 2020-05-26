#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  callModule(mod_explore_server, "explore")
  callModule(mod_metrics_server, "metrics")
}
