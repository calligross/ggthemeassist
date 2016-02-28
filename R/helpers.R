headingOutput <- function(heading, height = '20px', css = 'color: #ad1d28; text-decoration: underline;') {

  fillCol(tags$div(style = css, strong(heading)), height = height)

}

addQuotes <- function(x){
  chars <- grepl(pattern = '[a-zA-Z]', x)
  chars[grep('[(NA)(NULL)(^c\\(.*\\)]', x)] <- FALSE
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
