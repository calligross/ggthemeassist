headingOutput <- function(heading, height = '20px', css = 'color: #ad1d28; text-decoration: underline;') {

  fillCol(tags$div(style = css, strong(heading)), height = height)

}

addQuotes <- function(x){
  chars <- grepl(pattern = '[a-zA-Z]', x)
  chars[grep('^(c\\(.*|NA|NULL)*$', x)] <- FALSE
  x[chars] <- paste("'", x[chars], "'", sep = '')
  x
}

setNullNA <- function(x) {
  if (x == 'NULL') {
    x <- NULL
  } else if (x == 'NA') {
    x <- NA
  }
  return(x)
}

compileResults <- function(element, original, new, std = default) {
  if(element$enabled == TRUE) {
    result <- construcThemeString(element$name, original = original, new = new, std = std, element = element$type)
    if(is.null(result))
      result <- NA
    return(result)
  } else {
    return(NA)
  }
}
