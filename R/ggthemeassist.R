
ggthemeassist <- function(){

  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text
  if (grepl('[\\+\\(]', text)) {
    gg_original <- eval(parse(text = text))
  } else {
    gg_original <- get(text, envir = .GlobalEnv)
  }

  default <- updateDefaults(gg_original, default)

  ui <- miniPage(
    gadgetTitleBar("ggplot Theme Assistant"),
    miniTabstripPanel(
      miniTabPanel("Axis", icon = icon('sliders'),
        miniContentPanel(scrollable = TRUE,
          fillCol(
            plotOutput("ThePlot", width = '100%', height = '99%'),
            fillCol(height = '450px', width = '950px',
              fillRow(
                selectInput('axis.text.family', label = 'Family', choices = text.families, selected = default$axis.text$family, width = input.width),
                selectInput('axis.text.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.text$face),
                selectInput('axis.text.colour', label = 'Textcolour', choices = colours.available, selected = default$axis.text$colour, width = input.width)
              ),
              fillRow(
                numericInput('axis.text.hjust', 'Hjust', value = default$axis.text$hjust, step = 0.25, width = input.width),
                numericInput('axis.text.size', label = 'Textsize', min = 1, max = 30, value = default$axis.text$size, step = 1, width = input.width),
                numericInput('axis.text.vjust', 'Vjust', value = default$axis.text$vjust, step = 0.25, width = input.width)
              ),
              fillRow(width = '33%',
                numericInput('axis.text.angle', label = 'Angle', min = -180, max = 180, value = default$axis.text$angle, step = 5, width = input.width)
              ),
              fillRow(
                selectInput('axis.line.type', label = 'Linetype', choices = linetypes, selected = default$axis.line$linetype, width = input.width),
                selectInput('axis.line.colour', label = 'Linecolour', choices = colours.available, selected = default$axis.line$colour, width = input.width),
                numericInput('axis.line.size', label = 'Linesize', step = 0.1, value = default$axis.line$size, min = 0,width = input.width)
              ),
              fillRow(
                selectInput('axis.ticks.type', label = 'Ticktype', choices = linetypes, selected = default$axis.ticks$linetype, width = input.width),
                selectInput('axis.ticks.colour', label = 'Tickcolour', choices = colours.available, selected = default$axis.ticks$colour, width = input.width),
                numericInput('axis.ticks.size', label = 'Ticksize', step = 0.1, value = default$axis.ticks$size, min = 0,width = input.width)
              )
            )
          )
        )
      ),
      miniTabPanel("Title", icon = icon('sliders'),
        miniContentPanel(scrollable = TRUE,
          fillCol(
            plotOutput("ThePlot4", width = '100%', height = '99%'),
            fillCol(height = '640px', width = '950px',
              fillRow(
                textInput('plot.title', label = 'Plot title', value = gg_original$labels$title, width = input.width),
                textInput('axis.title.x', label = 'x Axis', value = gg_original$labels$x, width = input.width),
                textInput('axis.title.y', label = 'x Axis', value = gg_original$labels$y, width = input.width)
              ),
              fillRow(
                selectInput('plot.title.family', label = 'Title Family', choices = text.families, selected = default$plot.title$family, width = input.width),
                selectInput('plot.title.face', label = 'Title Face', choices = text.faces, width = input.width, selected = default$plot.title$face),
                numericInput('plot.title.angle', label = 'Title Angle', min = -180, max = 180, value = default$plot.title$angle, step = 5, width = input.width)
              ),
              fillRow(
                numericInput('plot.title.hjust', 'Title Hjust', value = default$plot.title$hjust, step = 0.25, width = input.width),
                selectInput('plot.title.colour', label = 'Title  Textcolour', choices = colours.available, selected = default$plot.title$colour, width = input.width),
                numericInput('plot.title.size', label = 'Title  Textsize', min = 1, max = 30, value = default$plot.title$size, step = 1, width = input.width)
              ),
              fillRow(width = '33%',
                      numericInput('plot.title.vjust', 'Title  Vjust', value = default$plot.title$vjust, step = 0.25, width = input.width)
              ),
              fillRow(
                selectInput('axis.title.family', label = 'Axis Family', choices = text.families, selected = default$axis.title$family, width = input.width),
                selectInput('axis.title.face', label = 'Axis Face', choices = text.faces, width = input.width, selected = default$axis.title$face),
                numericInput('axis.title.angle', label = 'Angle', min = -180, max = 180, value = default$axis.title$angle, step = 5, width = input.width)
              ),
              fillRow(
                numericInput('axis.title.hjust', 'Axis Hjust', value = default$axis.title$hjust, step = 0.25, width = input.width),
                selectInput('axis.title.colour', label = 'Axis Textcolour', choices = colours.available, selected = default$axis.title$colour, width = input.width),
                numericInput('axis.title.size', label = 'Axis Textsize', min = 1, max = 30, value = default$axis.title$size, step = 1, width = input.width)
              ),
              fillRow(width = '33%',
                numericInput('axis.title.vjust', 'Axis Vjust', value = default$axis.title$vjust, step = 0.25, width = input.width)
              )
            )
          )
        )
      ),
      miniTabPanel("Panel", icon = icon('sliders'),
        miniContentPanel(
          fillCol(
            plotOutput("ThePlot2", width = '100%', height = '99%'),
            fillCol(height = '270px', width = '950px',
              fillRow(
                selectInput('panel.background.fill', label = 'Fillcolour', choices = colours.available, width = input.width, selected = default$panel.background$fill),
                selectInput('panel.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$panel.background$colour),
                numericInput('panel.background.size', label = 'Backgroundsize', step = 0.1, value = default$panel.background$size, width = input.width),
                selectInput('panel.background.linetype', label = 'Backgroundlinetype', choices = linetypes, selected = default$panel.background$linetype, width = input.width)
              ),
              fillRow(width = '75%',
                selectInput('panel.grid.major.type', label = 'Grid major type', choices = linetypes, selected = default$panel.grid.major$linetype, width = input.width),
                selectInput('panel.grid.major.colour', label = 'Grid major colour', choices = colours.available, selected = default$panel.grid.major$colour, width = input.width),
                numericInput('panel.grid.major.size', label = 'Grid major size', step = 0.1, value = default$panel.grid.major$size, min = 0, width = input.width)
              ),
              fillRow(width = '75%',
                selectInput('panel.grid.minor.type', label = 'Grid minor type', choices = linetypes, selected = default$panel.grid.minor$linetype, width = input.width),
                selectInput('panel.grid.minor.colour', label = 'Grid minor colour', choices = colours.available, selected = default$panel.grid.minor$colour, width = input.width),
                numericInput('panel.grid.minor.size', label = 'Grid minor size', step = 0.1, value = default$panel.grid.minor$size, min = 0, width = input.width)
              )

            )
          )
        )
      ),
      miniTabPanel("Legend", icon = icon('sliders'),
        miniContentPanel(
          fillCol(
            plotOutput("ThePlot3", width = '100%', height = '99%'),
            fillCol(height = '450px', width = '950px',
              fillRow(
                selectInput('legend.position', label = 'Position', choices = legend.positions, selected = default$legend.position, width = input.width),
                selectInput('legend.direction', label = 'Direction', choices = legend.directions, selected = default$legend.direction, width = input.width),
                textInput('legend.lab.fill', label = 'Legend (fill)', value = gg_original$labels$fill, width = input.width),
                textInput('legend.lab.colour', label = 'Legend (colour)', value = gg_original$labels$colour, width = input.width)
              ),
              fillRow(
                numericInput('legend.title.size', label = 'Legend Title Size', min = 1, max = 30, value = default$legend.title$size, step = 1, width = input.width),
                selectInput('legend.title.face', label = 'Legend Titleface', choices = text.faces, selected = default$legend.title$face, width = input.width),
                selectInput('legend.title.colour', label = 'Titlecolour', choices = colours.available, selected = default$legend.title$colour, width = input.width),
                selectInput('legend.title.family', label = 'Titlefamily', choices = text.families, selected = default$legend.title$family, width = input.width)
              ),
              fillRow(
                numericInput('legend.text.size', label = 'Legend Text Size', min = 1, max = 30, value = default$legend.text$size, step = 1, width = input.width),
                selectInput('legend.text.face', label = 'Legend Textface', choices = text.faces, selected = default$legend.text$face, width = input.width),
                selectInput('legend.text.colour', label = 'Textcolour', choices = colours.available, selected = default$legend.text$colour, width = input.width),
                selectInput('legend.text.family', label = 'Legendfamily', choices = text.families, selected = default$legend.text$family, width = input.width)
              ),
              fillRow(
                selectInput('legend.background.fill', label = 'Background', choices = colours.available, width = input.width, selected = default$legend.background$fill),
                selectInput('legend.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$legend.background$colour),
                numericInput('legend.background.size', label = 'Linesize', step = 0.1, value = default$legend.background$size, width = input.width),
                selectInput('legend.background.linetype', label = 'Linetype', choices = linetypes, selected = default$legend.background$linetype, width = input.width)
              ),
              fillRow(
                selectInput('legend.key.fill', label = 'Key Background', choices = colours.available, width = input.width, selected = default$legend.key$fill),
                selectInput('legend.key.colour', label = 'Keycolour', choices = colours.available, width = input.width, selected = default$legend.key$colour),
                numericInput('legend.key.size', label = 'Keysize', step = 0.1, value = default$legend.key$size, width = input.width),
                selectInput('legend.key.linetype', label = 'Keylinetype', choices = linetypes, selected = default$legend.key$linetype, width = input.width)
              )
            )
          )
        )
      )
    )
  )

  server <- function(input, output, session) {

    gg_reactive <- reactive({
      gg_original +
        labs(title = input$plot.title,
          x = input$axis.title.x,
          y = input$axis.title.y,
          fill = input$legend.lab.fill,
          colour = input$legend.lab.colour) +
        theme(axis.text = element_text(
          size = input$axis.text.size,
          colour = input$axis.text.colour,
          face = input$axis.text.face,
          family = input$axis.text.family,
          angle = input$axis.text.angle,
          hjust = input$axis.text.hjust,
          vjust = input$axis.text.vjust,
          lineheight = input$axis.text.lineheight),
          axis.line = element_line(
            linetype = input$axis.line.type,
            colour = input$axis.line.colour,
            size = input$axis.line.size),
          axis.ticks = element_line(
            linetype = input$axis.ticks.type,
            colour = input$axis.ticks.colour,
            size = input$axis.ticks.size),
          axis.title = element_text(
            size = input$axis.title.size,
            colour = input$axis.title.colour,
            face = input$axis.title.face,
            family = input$axis.title.family,
            angle = input$axis.title.angle,
            hjust = input$axis.title.hjust,
            vjust = input$axis.title.vjust,
            lineheight = input$axis.title.lineheight),
          plot.title = element_text(
            size = input$plot.title.size,
            colour = input$plot.title.colour,
            face = input$plot.title.face,
            family = input$plot.title.family,
            angle = input$plot.title.angle,
            hjust = input$plot.title.hjust,
            vjust = input$plot.title.vjust,
            lineheight = input$plot.title.lineheight),
          panel.background = element_rect(
            fill = input$panel.background.fill,
            colour = input$panel.background.colour,
            size = input$panel.background.size,
            linetype = input$panel.background.linetype
          ),
          panel.grid.major = element_line(
            linetype = input$panel.grid.major.type,
            colour = input$panel.grid.major.colour,
            size = input$panel.grid.major.size),
          panel.grid.minor = element_line(
            linetype = input$panel.grid.minor.type,
            colour = input$panel.grid.minor.colour,
            size = input$panel.grid.minor.size),
          legend.text = element_text(
            size = input$legend.text.size,
            face = input$legend.text.face,
            colour = input$legend.text.colour,
            family = input$legend.text.family
          ),
          legend.title = element_text(
            size = input$legend.title.size,
            face = input$legend.title.face,
            colour = input$legend.title.colour,
            family = input$legend.title.family
          ),
          legend.background = element_rect(
            fill = input$legend.background.fill,
            colour = input$legend.background.colour,
            size = input$legend.background.size,
            linetype = input$legend.background.linetype
          ),
          legend.key = element_rect(
            fill = input$legend.key.fill,
            colour = input$legend.key.colour,
            size = input$legend.key.size,
            linetype = input$legend.key.linetype
          ),
          legend.position = input$legend.position,
          legend.direction = input$legend.direction
          )
    })

  ThePlot <- renderPlot({
    print(gg_reactive())
  })
  output$ThePlot <- ThePlot
  output$ThePlot2 <- ThePlot
  output$ThePlot3 <- ThePlot
  output$ThePlot4 <- ThePlot

  observeEvent(input$done, {
    result <- construcThemeString('axis.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text')
    result <- c(result, construcThemeString('axis.line', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('axis.ticks', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('axis.title', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('plot.title', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('panel.background', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('panel.grid.major', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('panel.grid.minor', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('legend.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('legend.title', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('legend.background', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('legend.key', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('legend.position', original = gg_original, new = gg_reactive(), std = default))
    result <- c(result, construcThemeString('legend.direction', original = gg_original, new = gg_reactive(), std = default))

    labelResult <- construcThemeString('labs', original = gg_original, new = gg_reactive(), std = default, category = 'labels')

    if(!is.null(result) || !is.null(labelResult)) {
      if(!is.null(result)) {
        result <- paste0(' + theme(', paste(result, collapse = ', '),')')
      }
      if(!is.null(labelResult)) {
        result <- c(result, ' + ', labelResult)
      }
      result <- paste0(text, paste(result, collapse = ' '))

      result <- formatR::tidy_source(text = result, output = FALSE, width.cutoff = 40)$text.tidy
      result <- paste(result, collapse = "\n")
      rstudioapi::insertText(result)
    }
    invisible(stopApp())
  })

  observeEvent(input$cancel, {
    invisible(stopApp())
  })

  }

  viewer <- dialogViewer(dialogName = 'ggthemeassist', width = 990, height = 900)
  runGadget(ui, server, stopOnCancel = FALSE, viewer = viewer)

}
