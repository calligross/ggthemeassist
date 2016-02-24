# Choices to pick from
colours.available <- c('None' = NA, colors())
text.faces <- c('plain', 'italic', 'bold', 'bold.italic')
text.families <- names(pdfFonts())
legend.positions <- c('none', 'left', 'right', 'top', 'bottom')
legend.directions <- c('horizontal', 'vertical')
linetypes <- c('blank', 'solid', 'dashed', 'dotted', 'dotdash', 'longdash', 'twodash')

# Configurations
input.width <- '50%'


# default values
default <- list(
  axis.text = list(
    family = 'sans',
    size = 10,
    face = 'plain',
    colour = 'grey30',
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
  axis.ticks = list(
    colour = 'grey20',
    size = 0.5,
    linetype = 'solid'
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
  plot.title = list(
    family = 'sans',
    size = 13,
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
  panel.grid.major = list(
    colour = 'grey100',
    size = 0.5,
    linetype = 'solid'
  ),
  panel.grid.minor = list(
    colour = 'grey100',
    size = 0.5,
    linetype = 'solid'
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
    fill = 'grey95',
    colour = 'NA',
    size = 0.5,
    linetype = 'blank'
  ),
  legend.position = 'right',
  legend.direction = 'vertical',
  labs = list(
    title = '',
    x = '',
    y = '',
    colour = '',
    fill = ''
  )
)
