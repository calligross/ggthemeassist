construcThemeString <- function(theme, original, new, std = default, element = NULL, category = 'theme') {
  result <- NULL
  std <- unlist(std[[theme]])
  std[is.na(std)] <- 'NA'

  if (category == 'theme') {
    # if you value good style of coding, don't read the next few lines, it's an ugly workaround for legend.position
    if (theme == 'legend.position' && length(new[[category]][[theme]]) > 1) {
      legend_position <- new[[category]][[theme]]
      legend_position <- paste0('c(',paste(legend_position, collapse = ', '), ')')
      new[[category]][[theme]] <- legend_position
    }

    new <- unlist(new[[category]][[theme]])

    if (theme == 'legend.position' && length(original[[category]][[theme]]) > 1) {
      legend_position <- original[[category]][[theme]]
      legend_position <- paste0('c(',paste(legend_position, collapse = ', '), ')')
      original[[category]][[theme]] <- legend_position
    }

    original <- unlist(original[[category]][[theme]])

  } else if (category == 'labels') {
    new <- unlist(new[[category]])
    original <- unlist(original[[category]])

    new_names <- names(new)
    original_names <- names(original)

    lost_names <- original_names[!original_names %in% new_names]

    if(length(lost_names) > 0) {
      new[lost_names] <- 'NULL'
    }

  }

  if (is.list(std) || length(std) > 1){
    DifferentToStandard <- names(std)[!new[names(std)] == std[names(std)]]
    DifferentToStandard <- DifferentToStandard[!is.na(DifferentToStandard)]
    DifferentToStandard <- new[DifferentToStandard]

    if (!is.null(original)) {
      DifferentToOriginal <- (!new[names(new)] == original[names(new)])
      DifferentToOriginal[is.na(DifferentToOriginal)] <- TRUE
      DifferentToOriginal <- names(DifferentToOriginal)[DifferentToOriginal]

      Different <- ((names(DifferentToStandard) %in% DifferentToOriginal))
      result <- DifferentToStandard[Different]
    } else {
      result <- DifferentToStandard
    }

    if (!is.null(result) && length(result) > 0) {
      result <- addQuotes(result)
      if (category == 'labels') {
        result <- paste0(theme, '(', element, '', paste(names(result), ' = ', result, collapse = ', '),')')
      } else {
        result <- paste0(theme, ' = ', element, '(', paste(names(result), ' = ', result, collapse = ', '),')')
      }
      return(result)
    } else {
      NULL
    }
  } else if (length(std) == 1 && class(std) == 'character' && !is.null(new)) {
    if (is.null(original)) {
      original <- ''
    }
    if (new != std && new != original) {
      result <- paste0(theme, ' = ', addQuotes(new))
      return(result)
    }
  }
}
