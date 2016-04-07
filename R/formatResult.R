formatResult <- function(text, themestring, labelstring, oneline, formatR = TRUE) {
  result <- NULL

  if (!is.null(themestring) && length(themestring) > 0) {
    if (oneline) {
      result <- paste0(' + theme(', paste(themestring, collapse = ', '),')')
    } else {
       result <- paste0(paste(text, ' <- ', text, ' + theme(', themestring, ')', sep = ''), collapse = '\n')
    }
  }

  if (!is.null(labelstring)) {
    if (oneline) {
      result <- c(result, ' + ', labelstring)
    } else {
      labelstring <- paste0(text, ' <- ', text, ' + ', labelstring)
      result <- paste(c(result, labelstring), collapse = '\n')
    }
  }

  if (oneline) {
    if (formatR) {
      result <- formatR::tidy_source(text = result, output = FALSE, width.cutoff = 40)$text.tidy
      result <- gsub('^\\+theme', ' + theme', result)
    }
    result <- paste0(text, paste(result, collapse = ' '))

  }

  result <- paste(result, collapse = "\n")
  return(result)

}
