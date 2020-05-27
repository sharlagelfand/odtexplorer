#' The application user interface
#'
#' @param request Internal parameter for `{shiny}`.
#' @import shiny
#' @importFrom shinydashboard menuItem tabItems tabItem
#' @noRd
app_ui <- function(request) {
  tagList(
    golem_add_external_resources(),
    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(
        title = "Open Data Toronto Explorer",
        titleWidth = 300
      ),
      shinydashboard::dashboardSidebar(
        width = 300,
        shinydashboard::sidebarMenu(
          menuItem("Explore Available Data", tabName = "explore", icon = icon("search")),
          menuItem("Portal Metrics", tabName = "metrics", icon = icon("chart-bar")),
          menuItem("About", tabName = "about", icon = icon("info-circle"))
        )
      ),
      shinydashboard::dashboardBody(
        tabItems(
          mod_explore_ui("explore"),
          mod_metrics_ui("metrics"),
          mod_about_ui("about")
        )
      )
    )
  )
}
#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www", app_sys("app/www")
  )

  tags$head(
    favicon(ext = "png"),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "Open Data Toronto Explorer"
    )
  )
}
