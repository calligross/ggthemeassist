# Choices to pick from
colours.available <- c('None' = NA, colors())
text.faces <- c('plain', 'italic', 'bold', 'bold.italic')
text.families <- names(pdfFonts())
legend.positions <- c('none', 'left', 'right', 'top', 'bottom', 'XY')
legend.directions <- c('horizontal', 'vertical')
linetypes <- c('blank', 'solid', 'dashed', 'dotted', 'dotdash', 'longdash', 'twodash')

# Configurations
input.width <- '50%'
line.height <- '70px'
heading.height <- '30px'


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
  plot.background = list(
    fill = NULL,
    colour = 'white',
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
    fill = 'grey100',
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
  legend.position.x = 0.5,
  legend.position.y = 0.5,
  legend.direction = 'vertical',
  labs = list(
    title = '',
    x = '',
    y = '',
    colour = '',
    fill = ''
  )
)

AvailableElements <- list(
  axis.line = list(
    name = 'axis.line',
    type = 'element_line',
    enabled = TRUE
  ),
  axis.ticks = list(
    name = 'axis.ticks',
    type = 'element_line',
    enabled = TRUE
  ),
  panel.ticks.major = list(
    name = 'panel.ticks.major',
    type = 'element_line',
    enabled = TRUE
  ),
  panel.ticks.minor = list(
    name = 'panel.ticks.minor',
    type = 'element_line',
    enabled = TRUE
  ),
  axis.title = list(
    name = 'axis.title',
    type = 'element_text',
    enabled = TRUE
  ),
  axis.text = list(
    name = 'axis.text',
    type = 'element_text',
    enabled = TRUE
  ),
  plot.title = list(
    name = 'plot.title',
    type = 'element_text',
    enabled = TRUE
  ),
  legend.text = list(
    name = 'legend.text',
    type = 'element_text',
    enabled = TRUE
  ),
  legend.title = list(
    name = 'legend.title',
    type = 'element_text',
    enabled = TRUE
  ),
    panel.background = list(
    name = 'panel.background',
    type = 'element_rect',
    enabled = TRUE
  ),
  plot.background = list(
    name = 'plot.background',
    type = 'element_rect',
    enabled = TRUE
  ),
  legend.key = list(
    name = 'legend.key',
    type = 'element_rect',
    enabled = TRUE
  ),
  legend.background = list(
    name = 'legend.background',
    type = 'element_rect',
    enabled = TRUE
  ),
  legend.position = list(
    name = 'legend.position',
    type = '',
    enabled = TRUE
  ),
  legend.direction = list(
    name = 'legend.direction',
    type = '',
    enabled = TRUE
  )
)
