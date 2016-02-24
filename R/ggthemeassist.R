
ggthemeassist <- function(){

  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text
  gg_original <- get(text, envir = .GlobalEnv)

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
            fillCol(height = '270px', width = '950px',
              fillRow(
                selectInput('axis.title.family', label = 'Family', choices = text.families, selected = default$axis.title$family, width = input.width),
                selectInput('axis.title.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.title$face),
                numericInput('axis.title.angle', label = 'Angle', min = -180, max = 180, value = default$axis.title$angle, step = 5, width = input.width)
              ),
              fillRow(
                numericInput('axis.title.hjust', 'Hjust', value = default$axis.title$hjust, step = 0.25, width = input.width),
                selectInput('axis.title.colour', label = 'Textcolour', choices = colours.available, selected = default$axis.title$colour, width = input.width),
                numericInput('axis.title.size', label = 'Textsize', min = 1, max = 30, value = default$axis.title$size, step = 1, width = input.width)
              ),
              fillRow(width = '33%',
                numericInput('axis.title.vjust', 'Vjust', value = default$axis.title$vjust, step = 0.25, width = input.width)
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
                selectInput('legend.position', label = 'Position', choices = legend.positions, selected =default$legend.position, width = input.width),
                selectInput('legend.direction', label = 'Direction', choices = legend.directions, selected =default$legend.direction, width = input.width)
              ),
              fillRow(
                numericInput('legend.text.size', label = 'Legend Text Size', min = 1, max = 30, value = default$legend.text$size, step = 1, width = input.width),
                selectInput('legend.text.face', label = 'Legend Textface', choices = text.faces, selected = default$legend.text$face, width = input.width),
                selectInput('legend.text.colour', label = 'Textcolour', choices = colours.available, selected = default$legend.text$colour, width = input.width),
                selectInput('legend.text.family', label = 'Legend Textfamily', choices = text.families, selected = default$legend.text$family, width = input.width)
              ),
              fillRow(
                numericInput('legend.title.size', label = 'Legend Title Size', min = 1, max = 30, value = default$legend.title$size, step = 1, width = input.width),
                selectInput('legend.title.face', label = 'Legend Titleface', choices = text.faces, selected = default$legend.title$face, width = input.width),
                selectInput('legend.title.colour', label = 'Titlecolour', choices = colours.available, selected = default$legend.title$colour, width = input.width),
                selectInput('legend.title.family', label = 'Titlefamily', choices = text.families, selected = default$legend.title$family, width = input.width)
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

    theme <- observe({
      gg_original
      if(is.valid(gg_original$theme$axis.text$size)) {
        if(gg_original$theme$axis.text$size != 0.8)
          updateNumericInput(session, 'axis.text.size', value = gg_original$theme$axis.text$size)
      }
      if(is.valid(gg_original$theme$axis.text$face)) {
        updateSelectInput(session, 'axis.text.face', selected = gg_original$theme$axis.text$face)
      }
      if(is.valid(gg_original$theme$axis.text$angle)) {
        updateNumericInput(session, 'axis.text.angle', value = gg_original$theme$axis.text$angle)
      }
      if(is.valid(gg_original$theme$axis.text$lineheight)) {
        updateNumericInput(session, 'axis.text.lineheight', value = gg_original$theme$axis.text$lineheight)
      }
      if(is.valid(gg_original$theme$axis.text$hjust)) {
        updateNumericInput(session, 'axis.text.hjust', value = gg_original$theme$axis.text$hjust)
      }
      if(is.valid(gg_original$theme$axis.text$vjust)) {
        updateNumericInput(session, 'axis.text.vjust', value = gg_original$theme$axis.text$vjust)
      }
      if(is.valid(gg_original$theme$axis.text$family)) {
        updateSelectInput(session, 'axis.text.family', selected = gg_original$theme$axis.text$family)
      }
      if(is.valid(gg_original$theme$axis.text$colour)) {
        updateSelectInput(session, 'axis.text.colour', selected = gg_original$theme$axis.text$colour)
      }
      if(is.valid(gg_original$theme$axis.line$linetype)) {
        updateSelectInput(session, 'axis.line.type', selected = gg_original$theme$axis.line$linetype)
      }
      if(is.valid(gg_original$theme$axis.line$colour)) {
        updateSelectInput(session, 'axis.line.colour', selected = gg_original$theme$axis.line$colour)
      }
      if(is.valid(gg_original$theme$axis.line$size)) {
        updateNumericInput(session, 'axis.line.size', value = gg_original$theme$axis.line$size)
      }
      if(is.valid(gg_original$theme$axis.ticks$linetype)) {
        updateSelectInput(session, 'axis.ticks.type', selected = gg_original$theme$axis.ticks$linetype)
      }
      if(is.valid(gg_original$theme$axis.ticks$colour)) {
        updateSelectInput(session, 'axis.ticks.colour', selected = gg_original$theme$axis.ticks$colour)
      }
      if(is.valid(gg_original$theme$axis.ticks$size)) {
        updateNumericInput(session, 'axis.ticks.size', value = gg_original$theme$axis.ticks$size)
      }
      #
      if(! is.null(gg_original$theme$axis.title$size)) {
        if(gg_original$theme$axis.title$size != 0.8)
          updateNumericInput(session, 'axis.title.size', value = gg_original$theme$axis.title$size)
      }
      if(is.valid(gg_original$theme$axis.title$face)) {
        updateSelectInput(session, 'axis.title.face', selected = gg_original$theme$axis.title$face)
      }
      if(is.valid(gg_original$theme$axis.title$angle)) {
        updateNumericInput(session, 'axis.title.angle', value = gg_original$theme$axis.title$angle)
      }
      if(is.valid(gg_original$theme$axis.title$lineheight)) {
        updateNumericInput(session, 'axis.title.lineheight', value = gg_original$theme$axis.title$lineheight)
      }
      if(is.valid(gg_original$theme$axis.title$hjust)) {
        updateNumericInput(session, 'axis.title.hjust', value = gg_original$theme$axis.title$hjust)
      }
      if(is.valid(gg_original$theme$axis.title$vjust)) {
        updateNumericInput(session, 'axis.title.vjust', value = gg_original$theme$axis.title$vjust)
      }
      if(is.valid(gg_original$theme$axis.title$family)) {
        updateSelectInput(session, 'axis.title.family', selected = gg_original$theme$axis.title$family)
      }
      if(is.valid(gg_original$theme$axis.title$colour)) {
        updateSelectInput(session, 'axis.title.colour', selected = gg_original$theme$axis.title$colour)
      }
      #
      if(is.valid(gg_original$theme$panel.background$fill)) {
        updateSelectInput(session, 'panel.background.fill', selected = gg_original$theme$panel.background$fill)
      }
      if(is.valid(gg_original$theme$panel.background$size)) {
        updateNumericInput(session, 'panel.background.size', value = gg_original$theme$panel.background$size)
      }
      if(is.valid(gg_original$theme$panel.background$colour)) {
        updateSelectInput(session, 'panel.background.colour', selected = gg_original$theme$panel.background$colour)
      }
      if(is.valid(gg_original$theme$panel.background$linetype)) {
        updateSelectInput(session, 'panel.background.linetype', selected = gg_original$theme$panel.background$linetype)
      }
      if(is.valid(gg_original$theme$panel.grid.major$linetype)) {
        updateSelectInput(session, 'panel.grid.major.type', selected = gg_original$theme$panel.grid.major$linetype)
      }
      if(is.valid(gg_original$theme$panel.grid.major$colour)) {
        updateSelectInput(session, 'panel.grid.major.colour', selected = gg_original$theme$panel.grid.major$colour)
      }
      if(is.valid(gg_original$theme$panel.grid.major$size)) {
        updateNumericInput(session, 'panel.grid.major.size', value = gg_original$theme$panel.grid.major$size)
      }
      if(is.valid(gg_original$theme$panel.grid.minor$linetype)) {
        updateSelectInput(session, 'panel.grid.minor.type', selected = gg_original$theme$panel.grid.minor$linetype)
      }
      if(is.valid(gg_original$theme$panel.grid.minor$colour)) {
        updateSelectInput(session, 'panel.grid.minor.colour', selected = gg_original$theme$panel.grid.minor$colour)
      }
      if(is.valid(gg_original$theme$panel.grid.minor$size)) {
        updateNumericInput(session, 'panel.grid.minor.size', value = gg_original$theme$panel.grid.minor$size)
      }
      #
      if(is.valid(gg_original$theme$legend.text$size)) {
        if(gg_original$theme$legend.text$size != 0.8)
          updateNumericInput(session, 'legend.text.size', value = gg_original$theme$legend.text$size)
      }
      if(is.valid(gg_original$theme$legend.text$face)) {
        updateSelectInput(session, 'legend.text.face', selected = gg_original$theme$legend.text$face)
      }
      if(is.valid(gg_original$theme$legend.text$colour)) {
        updateSelectInput(session, 'legend.text$colour', selected = gg_original$theme$legend.text$colour)
      }
      if(is.valid(gg_original$theme$legend.text$family)) {
        updateSelectInput(session, 'legend.text$family', selected = gg_original$theme$legend.text$family)
      }
      if(is.valid(gg_original$theme$legend.title$size)) {
        if(gg_original$theme$legend.title$size != 0.8)
          updateNumericInput(session, 'legend.title.size', value = gg_original$theme$legend.title$size)
      }
      if(is.valid(gg_original$theme$legend.title$face)) {
        updateSelectInput(session, 'legend.title.face', selected = gg_original$theme$legend.tile$face)
      }
      if(is.valid(gg_original$theme$legend.title$colour)) {
        updateSelectInput(session, 'legend.title$colour', selected = gg_original$theme$legend.title$colour)
      }
      if(is.valid(gg_original$theme$legend.text$family)) {
        updateSelectInput(session, 'legend.title$family', selected = gg_original$theme$legend.title$family)
      }
      if(is.valid(gg_original$theme$legend.background$fill)) {
        updateSelectInput(session, 'legend.background.fill', selected = gg_original$theme$legend.background$fill)
      }
      if(is.valid(gg_original$theme$legend.background$size)) {
        updateNumericInput(session, 'legend.background.size', value = gg_original$theme$legend.background$size)
      }
      if(is.valid(gg_original$theme$legend.background$colour)) {
        updateSelectInput(session, 'legend.background.colour', selected = gg_original$theme$legend.background$colour)
      }
      if(is.valid(gg_original$theme$legend.background$linetype)) {
        updateSelectInput(session, 'legend.background.linetype', selected = gg_original$theme$legend.background$linetype)
      }
      if(is.valid(gg_original$theme$legend.key$fill)) {
        updateSelectInput(session, 'legend.key.fill', selected = gg_original$theme$legend.key$fill)
      }
      if(is.valid(gg_original$theme$legend.key$size)) {
        updateNumericInput(session, 'legend.key.size', value = gg_original$theme$legend.key$size)
      }
      if(is.valid(gg_original$theme$legend.key$colour)) {
        updateSelectInput(session, 'legend.key.colour', selected = gg_original$theme$legend.key$colour)
      }
      if(is.valid(gg_original$theme$legend.key$linetype)) {
        updateSelectInput(session, 'legend.key.linetype', selected = gg_original$theme$legend.key$linetype)
      }
      if(is.valid(gg_original$theme$legend.position)) {
        updateSelectInput(session, 'legend.position', selected = gg_original$theme$legend.position)
      }
      if(is.valid(gg_original$theme$legend.direction)) {
        updateSelectInput(session, 'legend.direction', selected = gg_original$theme$legend.direction)
      }



    })

    gg_reactive <- reactive({
      gg_original +
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
    result <- c(result, construcThemeString('panel.background', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('panel.grid.major', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('panel.grid.minor', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('legend.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('legend.title', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('legend.background', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('legend.key', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('legend.position', original = gg_original, new = gg_reactive(), std = default))
    result <- c(result, construcThemeString('legend.direction', original = gg_original, new = gg_reactive(), std = default))

        if(!is.null(result)){
      result <- paste0(text, ' + theme(', paste(result, collapse = ', '),')')
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
