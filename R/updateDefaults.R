updateDefaults <- function(gg, defaults, linetypes = linetypes) {

  # Set default values for all elements
  for (i in c('rect', 'line', 'text')) {
    #substitute numeric linetypes to named, otherwise input widgets can't handle them
    if (i %in% c('rect', 'line') && !is.null(gg$theme[[i]]['linetype']) && is.numeric(gg$theme[[i]][['linetype']])) {
      gg$theme[[i]]['linetype'] <- linetypes[(gg$theme[[i]][['linetype']] + 1)]
    }

    # find elements in defaults with the class of i
    ThemeClass <- class(gg$theme[[i]])[1]
    DefaultClasses <- sapply(default, class)
    DefaultClasses <- DefaultClasses[DefaultClasses == ThemeClass]
    DefaultClasses <- names(DefaultClasses)
    if (length(DefaultClasses) > 0) {
      for (j in DefaultClasses) {
        default[[j]][names(default[[j]])] <- lapply(gg$theme[[i]][names(default[[j]])], unname)
      }
    }
  }


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
      # Relative size needs to be converted to absolute sizes
      if (class(gg[['theme']][[anchor]][[element]]) == 'rel') {
        default[[anchor]][[element]] <- as.numeric(gg[['theme']][[anchor]][[element]]) * gg$theme$text$size
      } else {
        if (element == 'linetype' && is.numeric(gg[['theme']][[anchor]][[element]])) {
          default[[anchor]][[element]] <- linetypes[gg[['theme']][[anchor]][[element]] + 1]
        } else {
          default[[anchor]][[element]] <- gg[['theme']][[anchor]][[element]]
        }
      }
    }
  }
  return(default)
}
