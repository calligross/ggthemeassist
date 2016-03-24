updateInputChoices <- function(session, input, gg, default) {

  # critical are colours, because they also can be e.g. RGB
  Elements <- reactiveValuesToList(input)
  ElementsColour <- names(Elements)
  ElementsColour <- ElementsColour[grepl('fill|colour', ElementsColour)]

  for (i in ElementsColour) {
    anchor <- gsub(pattern = '\\.[a-z]*$', '', i)
    element <- gsub(pattern = '^.*\\.', '', i)
    value <- default[[anchor]][[element]]
    if (!(is.null(value) || is.na(value))) {
      updateSelectizeInput(session, inputId = i, choices = unique(c(value, colours.available)), selected = value)
    }
  }
}
