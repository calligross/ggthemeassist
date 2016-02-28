headingOutput <- function(heading, height = '30px', css = 'color: #ad1d28; text-decoration: underline;') {

  fillCol(tags$div(style = css, strong(heading)), height = height)

}

addQuotes <- function(x){
  if (!x %in% c('NA', 'NULL') && !grepl('^c\\(.*\\)$', x)) {
    chars <- grepl(pattern = '[a-zA-Z]', x)
    x[chars] <- paste("'", x[chars], "'", sep = '')
  }
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
