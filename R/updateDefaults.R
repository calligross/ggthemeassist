updateDefaults <- function(gg, defaults) {

  ThemeOptions <- unlist(gg$theme)

  # get common names
  NamesThemes <- names(ThemeOptions)
  NamesDefaults <- names(unlist(default))
  CommonNames <- NamesThemes[NamesThemes %in% NamesDefaults]

  # have to get rid of the for loop later

  for (i in CommonNames) {
    anchor <- gsub(pattern = '\\.[a-z]*$', '', i)
    element <- gsub(pattern = '^.*\\.', '', i)
    default[[anchor]][[element]] <- gg[['theme']][[anchor]][[element]]
  }
  return(default)
}
