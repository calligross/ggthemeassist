
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
                   plotOutput("ThePlot", width = '100%', height = '400px'),
                   fillRow(height = line.height, width = '100%',
                           headingOutput('Axis text'),headingOutput('Axis line'),headingOutput('Axis ticks')
                   ),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.family', label = 'Family', choices = text.families, selected = default$axis.text$family, width = input.width),
                                            selectInput('axis.line.type', label = 'Type', choices = linetypes, selected = default$axis.line$linetype, width = input.width),
                                            selectInput('axis.ticks.type', label = 'Type', choices = linetypes, selected = default$axis.ticks$linetype, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.text$face),
                                            numericInput('axis.line.size', label = 'Size', step = 0.1, value = default$axis.line$size, min = 0,width = input.width),
                                            numericInput('axis.ticks.size', label = 'Size', step = 0.1, value = default$axis.ticks$size, min = 0,width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.size', label = 'Size', min = 1, max = 30, value = default$axis.text$size, step = 1, width = input.width),
                                            selectInput('axis.line.colour', label = 'Colour', choices = colours.available, selected = default$axis.line$colour, width = input.width),
                                            selectInput('axis.ticks.colour', label = 'Colour', choices = colours.available, selected = default$axis.ticks$colour, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.colour', label = 'Colour', choices = colours.available, selected = default$axis.text$colour, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.hjust', 'Hjust', value = default$axis.text$hjust, step = 0.25, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.vjust', 'Vjust', value = default$axis.text$vjust, step = 0.25, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.angle', label = 'Angle', min = -180, max = 180, value = default$axis.text$angle, step = 5, width = input.width),
                                            "",
                                            ""
                                    )
                   )),
      miniTabPanel("Title and label", icon = icon('sliders'),
                   plotOutput("ThePlot4", width = '100%', height = '400px'),
                   fillRow(height = line.height, width = '100%',
                           headingOutput('Labels'),headingOutput('Plot Title'),headingOutput('Axis Labels')
                   ),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = line.height, width = '100%',
                                            textInput('plot.title', label = 'Title', value = gg_original$labels$title, width = input.width),
                                            selectInput('plot.title.family', label = 'Family', choices = text.families, selected = default$plot.title$family, width = input.width),
                                            selectInput('axis.title.family', label = 'Family', choices = text.families, selected = default$axis.title$family, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('axis.title.x', label = 'x-Axis', value = gg_original$labels$x, width = input.width),
                                            selectInput('plot.title.face', label = 'Face', choices = text.faces, width = input.width, selected = default$plot.title$face),
                                            selectInput('axis.title.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.title$face)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('axis.title.y', label = 'y-Axis', value = gg_original$labels$y, width = input.width),
                                            numericInput('plot.title.size', label = 'Size', min = 1, max = 30, value = default$plot.title$size, step = 1, width = input.width),
                                            numericInput('axis.title.size', label = 'Size', min = 1, max = 30, value = default$axis.title$size, step = 1, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('legend.colour.title', label = 'Colour', value = gg_original$labels$colour, width = input.width),
                                            selectInput('plot.title.colour', label = 'Colour', choices = colours.available, selected = default$plot.title$colour, width = input.width),
                                            selectInput('axis.title.colour', label = 'Colour', choices = colours.available, selected = default$axis.title$colour, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('legend.fill.title', label = 'Fill', value = gg_original$labels$fill, width = input.width),
                                            numericInput('plot.title.hjust', 'Hjust', value = default$plot.title$hjust, step = 0.25, width = input.width),
                                            numericInput('axis.title.hjust', 'Hjust', value = default$axis.title$hjust, step = 0.25, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            "",
                                            numericInput('plot.title.vjust', 'Vjust', value = default$plot.title$vjust, step = 0.25, width = input.width),
                                            numericInput('axis.title.vjust', 'Vjust', value = default$axis.title$vjust, step = 0.25, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            "",
                                            numericInput('plot.title.angle', label = 'Angle', min = -180, max = 180, value = default$plot.title$angle, step = 5, width = input.width),
                                            numericInput('axis.title.angle', label = 'Angle', min = -180, max = 180, value = default$axis.title$angle, step = 5, width = input.width)
                                    )
                   )
      ),
      miniTabPanel("Panel", icon = icon('sliders'),
                   plotOutput("ThePlot2", width = '100%', height = '400px'),
                   fillRow(height = line.height, width = '100%',
                           headingOutput('Panel Background'),headingOutput('Grid Major'),headingOutput('Grid Minor')
                   ),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('panel.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$panel.background$fill),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('panel.background.linetype', label = 'Type', choices = linetypes, selected = default$panel.background$linetype, width = input.width),
                                            selectInput('panel.grid.major.type', label = 'Type', choices = linetypes, selected = default$panel.grid.major$linetype, width = input.width),
                                            selectInput('panel.grid.minor.type', label = 'Type', choices = linetypes, selected = default$panel.grid.minor$linetype, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('panel.background.size', label = 'Size', step = 0.1, value = default$panel.background$size, width = input.width),
                                            numericInput('panel.grid.major.size', label = 'Size', step = 0.1, value = default$panel.grid.major$size, min = 0, width = input.width),
                                            numericInput('panel.grid.minor.size', label = 'Size', step = 0.1, value = default$panel.grid.minor$size, min = 0, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('panel.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$panel.background$colour),
                                            selectInput('panel.grid.major.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.major$colour, width = input.width),
                                            selectInput('panel.grid.minor.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.minor$colour, width = input.width)
                                    )
                   )
      ),
      miniTabPanel("Legend", icon = icon('sliders'),
                   plotOutput("ThePlot3", width = '100%', height = '400px'),
                   fillRow(height = line.height, width = '100%',
                           headingOutput('Legend position'),headingOutput('Legend Title'),headingOutput('Legend Text'), headingOutput("Legend Background"), headingOutput("Legend Keys")
                   ),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('legend.position', label = 'Position', choices = legend.positions, selected = default$legend.position, width = input.width),
                                            selectInput('legend.title.family', label = 'Family', choices = text.families, selected = default$legend.title$family, width = input.width),
                                            selectInput('legend.text.family', label = 'Family', choices = text.families, selected = default$legend.text$family, width = input.width),
                                            selectInput('legend.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$legend.background$fill),
                                            selectInput('legend.key.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$legend.key$fill)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('legend.direction', label = 'Direction', choices = legend.directions, selected = default$legend.direction, width = input.width),
                                            selectInput('legend.title.face', label = 'Face', choices = text.faces, selected = default$legend.title$face, width = input.width),
                                            selectInput('legend.text.face', label = 'Face', choices = text.faces, selected = default$legend.text$face, width = input.width),
                                            selectInput('legend.background.linetype', label = 'Type', choices = linetypes, selected = default$legend.background$linetype, width = input.width),
                                            selectInput('legend.key.linetype', label = 'Type', choices = linetypes, selected = default$legend.key$linetype, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('legend.position.x', label = 'X Coord', min = 0, max = 1, value = 0.5, step = 0.01, width = input.width),
                                            numericInput('legend.title.size', label = 'Size', min = 1, max = 30, value = default$legend.title$size, step = 1, width = input.width),
                                            numericInput('legend.text.size', label = 'Size', min = 1, max = 30, value = default$legend.text$size, step = 1, width = input.width),
                                            numericInput('legend.background.size', label = 'Size', step = 0.1, value = default$legend.background$size, width = input.width),
                                            numericInput('legend.key.size', label = 'Size', step = 0.1, value = default$legend.key$size, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('legend.position.y', label = 'Y Coord', min = 0, max = 1, value = 0.5, step = 0.01, width = input.width),
                                            selectInput('legend.title.colour', label = 'Colour', choices = colours.available, selected = default$legend.title$colour, width = input.width),
                                            selectInput('legend.text.colour', label = 'Colour', choices = colours.available, selected = default$legend.text$colour, width = input.width),
                                            selectInput('legend.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$legend.background$colour),
                                            selectInput('legend.key.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$legend.key$colour)
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
             fill = input$legend.fill.title,
             colour = input$legend.colour.title) +
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
