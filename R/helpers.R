headingOutput <- function(heading, height = '20px', css = 'color: #ad1d28; text-decoration: underline;') {

  fillCol(tags$div(style = css, strong(heading)), height = height)

}

addQuotes <- function(x){
  chars <- grepl(pattern = '[a-zA-Z#]', x)
  chars[grep('^(c\\(.*|NA|NULL)*$', x)] <- FALSE
  x[chars] <- paste("'", x[chars], "'", sep = '')
  x
}

setNull <- function(x) {
  if(is.null(x)) {
    return(NULL)
  } else if (is.na(x)) {
    x <- NULL
  } else if (x == 'NULL') {
    x <- NULL
  } else if (x == 'NA') {
    x <- NULL
  }
  return(x)
}

compileResults <- function(element, original, new, std = default) {
  if (element$enabled == TRUE) {
    result <- construcThemeString(element$name, original = original, new = new, std = std, element = element$type)
    if (is.null(result))
      result <- NA
    return(result)
  } else {
    return(NA)
  }
}

is.validColour <- function(x) {
  if (is.null(x)) {
    return(TRUE)
  } else if (x %in% c(colours.available, 'NA', 'NULL')) {
    return(TRUE)
  } else if (grepl('#[0-9a-fA-F]{6}$', x)) {
    return(TRUE)
  }
  else {
    return(FALSE)
  }
}

is.valid <- function(x) {
  if (!is.null(x) && !is.na(x)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

checkInputText <- function(x) {
  if (x == '') {
    return(NULL)
  } else {
    x <- gsub('\\\\n', '\\\n', x)
    return(x)
  }
}

preserveNewlines <- function(x) {
  if (is.null(x)) {
    return('')
  } else {
  x <- gsub('\\\n', '\\\\n', x)
  return(x)
  }
}

getRGBHexColours <- function(gg) {
  theme <- unlist(gg$theme)
  colours <- theme[grep('#[0-9a-fA-F]{6}', theme)]
  colours <- unname(colours)
  colours <- unique(colours)
  return(colours)
}

colours2RGB <- function(colours, Inherit = FALSE) {
  #return a df of rgb colours
  colours[is.na(colours)] <- 'NA'
  rgbcolours <- matrix(as.character(as.character.hexmode(col2rgb(colours), width = 2)), nrow = 3)
  rgbcolours <- apply(rgbcolours, 2, paste, collapse = '')
  rgbcolours <- paste('#', rgbcolours, sep = '')
  rgbcolours <- data.frame(name = colours, colour = colours, rgb = rgbcolours, stringsAsFactors = FALSE)
  rgbcolours[1, 1] <- 'None'
  if (Inherit) {
    rgbcolours <- rbind(data.frame(name = 'Inherit', colour = 'NULL', rgb = '#ffffff'), rgbcolours)
  }
  rgbcolours <- rbind(data.frame(name = 'None', colour = NA, rgb = '#ffffff'), rgbcolours)
  #rgbcolours <- rgbcolours[orderRGB(rgbcolours$rgb), ]
  return(rgbcolours)
}

orderRGB <- function(colours) {
  # simple method, not very accurate
  colours <- gsub('#', '', colours)
  colours <- strsplit(tolower(colours), "")
  rgb <- sapply(colours, function(x) sum((match(x, c(0L:9L, letters[1L:6L])) - 1L) * 16 ^ (rev(seq_along(x) - 1))))
  rgb <- order(rgb)
  return(rgb)
}

NA2text <- function(x) {
  if (is.na(x)) {
    return('NA')
  } else {
    return(x)
  }
}

hasLegend <- function(gg) {
  mappings <- names(gg$mapping)
  mappings <- mappings[!mappings %in% c('x', 'y')]
  length(mappings) > 0
}

