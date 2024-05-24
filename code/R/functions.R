#' Plot Monthly Uses Synchronization
#'
#' This function creates a synchronized plot for monthly uses data.
#'
#' @param data A data frame containing the monthly uses data.
#' @param title A string for the title of the plot.
#' @param x_label A string for the x-axis label.
#' @param y_label A string for the y-axis label.
#' @param color A string specifying the color for the plot lines.
#'
#' @return A ggplot object representing the synchronized plot of monthly uses.
#' @export
#'
#' @examples
#' monthly_uses_syncplot(data, "Monthly Uses", "Month", "Usage", "blue")
monthly_uses_syncplot <- function(data, title, x_label, y_label, color){
  ggplot(data, aes(x = Month, y = Usage, group = 1)) +
    geom_line(color = color) +
    labs(title = title, x = x_label, y = y_label) +
    theme_minimal()
}

#' Plot Monthly Flow Synchronization by Station ID
#'
#' This function creates a synchronized plot for monthly flow data by station ID.
#'
#' @param data A data frame containing the monthly flow data.
#' @param station_id A string or numeric specifying the station ID.
#' @param title A string for the title of the plot.
#' @param x_label A string for the x-axis label.
#' @param y_label A string for the y-axis label.
#' @param color A string specifying the color for the plot lines.
#'
#' @return A ggplot object representing the synchronized plot of monthly flow data by station ID.
#' @export
#'
#' @examples
#' monthly_flow_syncplot_staid(data, "123456", "Monthly Flow", "Month", "Flow", "blue")
monthly_flow_syncplot_staid <- function(data, station_id, title, x_label, y_label, color){
  data_filtered <- data %>% filter(StationID == station_id)

  ggplot(data_filtered, aes(x = Month, y = Flow, group = 1)) +
    geom_line(color = color) +
    labs(title = title, x = x_label, y = y_label) +
    theme_minimal()
}
