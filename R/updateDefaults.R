updateDefaults <- function(gg, defaults, linetypes = linetypes) {

  # Set default values for all elements
  for (i in c('rect', 'line', 'text')) {
    #substitute numeric linetypes to named, otherwise input widgets can't handle them
    if (i %in% c('rect', 'line') && !is.null(gg$theme[[i]]['linetype']) && is.numeric(gg$theme[[i]][['linetype']])) {
      gg$theme[[i]]['linetype'] <- linetypes[(gg$theme[[i]][['linetype']] + 1)]
    }

    # find elements in defaults with the class of i
    ThemeClass <- class(gg$theme[[i]])[1]
    DefaultClasses <- sapply(defaults, class)
    DefaultClasses <- DefaultClasses[DefaultClasses == ThemeClass]
    DefaultClasses <- names(DefaultClasses)
    if (length(DefaultClasses) > 0) {
      for (j in DefaultClasses) {
        gg$theme[[i]][which(gg$theme[[i]][names(default[[j]])] == '')] <- NULL
        default[[j]][names(gg$theme[[i]])] <- lapply(gg$theme[[i]][names(gg$theme[[i]])], unname)
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
  NamesDefaults <- names(unlist(defaults))
  CommonNames <- NamesThemes[NamesThemes %in% NamesDefaults]

  CommonNames <- CommonNames[!CommonNames %in% c('legend.position.x', 'legend.position.y')]

  # have to get rid of the for loop later

  for (i in CommonNames) {
    anchor <- gsub(pattern = '\\.[a-z]*$', '', i)
    element <- gsub(pattern = '^.*\\.', '', i)
    if (i == 'legend.position' || i == 'legend.direction') {
      if (!is.null(LegendPosition) && i == 'legend.position') {
        defaults['legend.position'] <- 'XY'
        defaults['legend.position.x'] <- LegendPosition[1]
        defaults['legend.position.y'] <- LegendPosition[2]
      } else {
        defaults[i] <- gg$theme[i]
      }
    }
    else {
      # Relative size needs to be converted to absolute sizes
      if (class(gg[['theme']][[anchor]][[element]]) == 'rel') {
        defaults[[anchor]][[element]] <- as.numeric(gg[['theme']][[anchor]][[element]]) * gg$theme$text$size
      } else {
        if (element == 'linetype' && is.numeric(gg[['theme']][[anchor]][[element]])) {
          defaults[[anchor]][[element]] <- linetypes[gg[['theme']][[anchor]][[element]] + 1]
        } else {
          defaults[[anchor]][[element]] <- gg[['theme']][[anchor]][[element]]
        }
      }
    }
  }

  # substitute grey with gray
  defaults <- rapply(defaults, function(x) { gsub('grey', 'gray', x) }, how = 'list')
  return(defaults)
}
