updateDefaults <- function(gg, defaults) {
  LegendPosition <- NULL
  if (length(gg$theme$legend.position) > 1) {
    LegendPosition <- gg$theme$legend.position
    gg$theme$legend.position <- 'XY'
    gg$theme$legend.position.x <- LegendPosition[1]
    gg$theme$legend.position.y <- LegendPosition[2]
  }

  ThemeOptions <- unlist(gg$theme)

  # get common names
  NamesThemes <- names(ThemeOptions)
  NamesDefaults <- names(unlist(default))
  CommonNames <- NamesThemes[NamesThemes %in% NamesDefaults]

  CommonNames <- CommonNames[!CommonNames %in% c('legend.position.x', 'legend.position.y')]

  # have to get rid of the for loop later

  for (i in CommonNames) {
    anchor <- gsub(pattern = '\\.[a-z]*$', '', i)
    element <- gsub(pattern = '^.*\\.', '', i)
    if (i == 'legend.position' || i == 'legend.direction') {
      if (!is.null(LegendPosition) && i == 'legend.position') {
        default['legend.position'] <- 'XY'
        default['legend.position.x'] <- LegendPosition[1]
        default['legend.position.y'] <- LegendPosition[2]
      } else {
        default[i] <- gg$theme[i]
      }
    }
    else {
      default[[anchor]][[element]] <- gg[['theme']][[anchor]][[element]]
    }
  }
  return(default)
}
