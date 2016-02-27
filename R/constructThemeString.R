construcThemeString <- function(theme, original, new, std = default, element = NULL, category = 'theme') {
  result <- NULL
  std <- unlist(std[[theme]])

  if(category == 'theme') {
    new <- unlist(new[[category]][[theme]])
    original <- unlist(original[[category]][[theme]])
  } else if(category == 'labels') {
    new <- unlist(new[[category]])
    original <- unlist(original[[category]])
  }

  if(is.list(std) || length(std) > 1){
    DifferentToStandard <- names(std)[!new[names(std)] == std[names(std)]]
    DifferentToStandard <- DifferentToStandard[!is.na(DifferentToStandard)]
    DifferentToStandard <- new[DifferentToStandard]

    if(!is.null(original)) {
      DifferentToOriginal <- (!new[names(new)] == original[names(new)])
      DifferentToOriginal[is.na(DifferentToOriginal)] <- TRUE
      DifferentToOriginal <- names(DifferentToOriginal)[DifferentToOriginal]

      Different <- ((names(DifferentToStandard) %in% DifferentToOriginal))
      result <- DifferentToStandard[Different]
    } else {
      result <- DifferentToStandard
    }

    if(!is.null(result) && length(result) > 0) {
      result <- addQuotes(result)
      if(category == 'labels') {
        result <- paste0(theme, '(', element, '', paste(names(result), ' = ', result, collapse = ', '),')')
      } else {
        result <- paste0(theme, ' = ', element, '(', paste(names(result), ' = ', result, collapse = ', '),')')
      }
      return(result)
    } else {
      NULL
    }
  } else if(length(std) == 1 && class(std) == 'character') {
    if(is.null(original) && new != std) {
      result <- paste0(theme, ' = ', addQuotes(new))
      return(result)
    }
  }
}

addQuotes <- function(x){
  if(! x %in% c('NA', 'NULL')) {
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
