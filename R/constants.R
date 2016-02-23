# Choices to pick from
colours.available <- c('None' = NA, colors())
text.faces <- c('plain', 'italic', 'bold', 'bold.italic')
text.families <- names(pdfFonts())
linetypes <- c('blank', 'solid', 'dashed', 'dotted', 'dotdash', 'longdash', 'twodash')

# Configurations
input.width <- '50%'


# default values
default <- list(
  axis.text = list(
    family = 'sans',
    size = 10,
    face = 'plain',
    colour = 'black',
    hjust = 0.5,
    vjust = 0.5,
    angle = 0,
    lineheight = 1.1
    ),
  axis.line = list(
    colour = 'black',
    size = 1,
    linetype = 'blank'
    ),
  axis.title = list(
    family = 'sans',
    size = 11,
    face = 'plain',
    colour = 'black',
    hjust = 0.5,
    vjust = 0.5,
    angle = 0,
    lineheight = 1.1
  ),
  panel.background = list(
    fill = 'grey92',
    colour = 'NA',
    size = 0.5,
    linetype = 'blank'
  ),
  legend.text = list(
    size = 10,
    face = 'plain',
    family = 'sans',
    colour = 'black'
  ),
  legend.title = list(
    size = 10,
    face = 'plain',
    family = 'sans',
    colour = 'black'
  ),
  legend.background = list(
    fill = 'NA',
    colour = 'NA',
    size = 0.5,
    linetype = 'blank'
  ),
  legend.key = list(
    fill = 'grey94',
    colour = 'NA',
    size = 0.5,
    linetype = 'blank'
  )
)
