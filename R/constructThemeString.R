construcThemeString <- function(theme, original, new, std = default, element = NULL) {
  result <- NULL
  std <- unlist(std[[theme]])
  new <- unlist(new$theme[[theme]])
  original <- unlist(original$theme[[theme]])


  if(is.list(std)){
    DifferentToStandard <- names(std)[!new[names(std)] == std[names(std)]]
    DifferentToStandard <- DifferentToStandard[!is.na(DifferentToStandard)]
    DifferentToStandard <- new[DifferentToStandard]
    if(!is.null(original)){
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
      result <- paste0(theme, ' = ', element, '(', paste(names(result), ' = ', result, collapse = ', '),')')
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
  chars <- grepl(pattern = '[a-zA-Z]', x)
  x[chars] <- paste("'", x[chars], "'", sep = '')
  x
}
