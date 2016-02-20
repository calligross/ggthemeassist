construcThemeString <- function(theme, original, new, std = default, element) {
  result <- NULL
  std <- unlist(std[[theme]])
  new <- unlist(new$theme[[theme]])
  # class(new) <- 'list' # ugly workaround
  original <- unlist(original$theme[[theme]])
  # class(original) <- 'list' # and again

  DifferentToStandard <- names(std)[!new[names(std)] == std[names(std)]]
  DifferentToStandard <- DifferentToStandard[!is.na(DifferentToStandard)]
  DifferentToStandard <- new[DifferentToStandard]
  if(!is.null(original)){
    DifferentToOriginal <- names(original)[!original[names(original)] == new[names(original)]]

    Different <- ((names(DifferentToStandard) %in% DifferentToOriginal))
    result <- DifferentToStandard[Different]
  } else {
    result <- DifferentToStandard
  }


  if(!is.null(result) && length(result) > 0) {
    result <- addQuotes(result)
    paste0(theme, ' = ', element, '(', paste(names(result), ' = ', result, collapse = ', '),')')
  } else {
    NULL
  }
}

addQuotes <- function(x){
  chars <- grepl(pattern = '[a-zA-Z]', x)
  x[chars] <- paste("'", x[chars], "'", sep = '')
  x
}
