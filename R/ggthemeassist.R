
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
        miniContentPanel(
          plotOutput("ThePlot", width = 800, height = 400),
          fillCol(flex = c(5, 3, 2),
            fillRow(
              fillCol(
                numericInput('axis.text.size', label = 'Textsize', min = 1, max = 30, value = default$axis.text$size, step = 1, width = input.width),
                numericInput('axis.text.lineheight', label = 'Lineheight', value = default$axis.text$lineheight, width = input.width),
                selectInput('axis.text.colour', label = 'Textcolour', choices = colours.available, selected = default$axis.text$colour, width = input.width)
              ),
              fillCol(
                selectInput('axis.text.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.text$face),
                selectInput('axis.text.family', label = 'Family', choices = text.families, selected = default$axis.text$family, width = input.width)
              ),
              fillCol(
                numericInput('axis.text.angle', label = 'Angle', min = -180, max = 180, value = default$axis.text$angle, step = 5, width = input.width),
                numericInput('axis.text.hjust', 'Hjust', value = default$axis.text$hjust, step = 0.25, width = input.width),
                numericInput('axis.text.vjust', 'Vvust', value = default$axis.text$vjust, step = 0.25, width = input.width)
              )
            ),
            fillRow(
                selectInput('axis.line.type', label = 'Linetype', choices = linetypes, selected = default$axis.line$linetype, width = input.width),
                selectInput('axis.line.colour', label = 'Linecolour', choices = colours.available, selected = default$axis.line$colour, width = input.width),
                numericInput('axis.line.size', label = 'Linesize', step = 0.1, value = default$axis.line$size, width = input.width)
            )
          )
        )
      ) ,
      miniTabPanel("Background", icon = icon('sliders'),
        miniContentPanel(
          plotOutput("ThePlot2", width = 800, height = 400),
          fillCol(flex = c(5, 3, 2),
            fillRow(
              selectInput('panel.background.fill', label = 'Fillcolour', choices = c(NA, colours.available), width = input.width, selected = default$panel.background$fill),
              selectInput('panel.background.colour', label = 'Colour', choices = c(colours.available), width = input.width, selected = default$panel.background$colour),
              numericInput('panel.background.size', label = 'Backgroundsize', step = 0.1, value = default$panel.background$size, width = input.width),
              selectInput('panel.background.linetype', label = 'Backgroundlinetype', choices = linetypes, selected = default$panel.background$linetype, width = input.width)
            )
            )
        )
      ),
      miniTabPanel("Legend", icon = icon('sliders'),
                   miniContentPanel(
                             plotOutput("ThePlot3", width = 800, height = 400),
                             fillCol(flex = c(5, 3, 2),
                                     fillRow(
                                       fillCol(
                                         numericInput('legend.text.size', label = 'Legend Text Size', min = 1, max = 30, value = default$legend.text$size, step = 1, width = input.width),
                                         selectInput('legend.text.face', label = 'Legend Textface', choices = text.faces, selected = default$legend.text$face, width = input.width),
                                         selectInput('legend.text.colour', label = 'Legend Textcolour', choices = colours.available, selected = default$axis.text$colour, width = input.width),
                                         selectInput('legend.text.family', label = 'Legend Textfamily', choices = text.families, selected = default$legend.text$family, width = input.width)
                                         ),
                                       fillCol(
                                         numericInput('legend.title.size', label = 'Legend Title Size', min = 1, max = 30, value = default$legend.title$size, step = 1, width = input.width),
                                         selectInput('legend.title.face', label = 'Legend Titleface', choices = text.faces, selected = default$legend.title$face, width = input.width),
                                         selectInput('legend.title.colour', label = 'Legend Titlecolour', choices = colours.available, selected = default$legend.title$colour, width = input.width),
                                         selectInput('legend.title.family', label = 'Legend Titlefamily', choices = text.families, selected = default$legend.title$family, width = input.width)
                                       )
                     )
                   )
      )
    )
  ))

  server <- function(input, output, session) {

    theme <- observe({
      gg_original
      if(! is.null(gg_original$theme$axis.text$size)) {
        if(gg_original$theme$axis.text$size != 0.8)
          updateNumericInput(session, 'axis.text.size', value = gg_original$theme$axis.text$size)
      }
      if(!is.null(gg_original$theme$axis.text$face)) {
        updateSelectInput(session, 'axis.text.face', selected = gg_original$theme$axis.text$face)
      }
      if(!is.null(gg_original$theme$axis.text$angle)) {
        updateSelectInput(session, 'axis.text.angle', selected = gg_original$theme$axis.text$angle)
      }
      if(!is.null(gg_original$theme$axis.text$lineheight)) {
        updateSelectInput(session, 'axis.text.lineheight', selected = gg_original$theme$axis.text$lineheight)
      }
      if(!is.null(gg_original$theme$axis.text$hjust)) {
        updateSelectInput(session, 'axis.text.hjust', selected = gg_original$theme$axis.text$hjust)
      }
      if(!is.null(gg_original$theme$axis.text$vjust)) {
        updateSelectInput(session, 'axis.text.vjust', selected = gg_original$theme$axis.text$vjust)
      }
      if(!is.null(gg_original$theme$axis.text$family)) {
        updateSelectInput(session, 'axis.text.family', selected = gg_original$theme$axis.text$family)
      }
      if(!is.null(gg_original$theme$axis.text$colour)) {
        updateSelectInput(session, 'axis.text.colour', selected = gg_original$theme$axis.text$colour)
      }
      if(!is.null(gg_original$theme$axis.line$linetype)) {
        updateSelectInput(session, 'axis.line.type', selected = gg_original$theme$axis.line$linetype)
      }
      if(!is.null(gg_original$theme$axis.line$colour)) {
        updateSelectInput(session, 'axis.line.colour', selected = gg_original$theme$axis.line$colour)
      }
      if(!is.null(gg_original$theme$axis.line$size)) {
        updateSelectInput(session, 'axis.line.size', selected = gg_original$theme$axis.line$size)
      }
      if(!is.null(gg_original$theme$panel.background$fill)) {
        updateSelectInput(session, 'panel.background.fill', selected = gg_original$theme$panel.background$fill)
      }
      if(!is.null(gg_original$theme$panel.background$size)) {
        updateSelectInput(session, 'panel.background.size', selected = gg_original$theme$panel.background$size)
      }
      if(!is.null(gg_original$theme$panel.background$colour)) {
        updateSelectInput(session, 'panel.background.colour', selected = gg_original$theme$panel.background$colour)
      }
      if(!is.null(gg_original$theme$panel.background$linetype)) {
        updateSelectInput(session, 'panel.background.linetype', selected = gg_original$theme$panel.background$linetype)
      }
      #
      if(!is.null(gg_original$theme$legend.text$size)) {
        updateSelectInput(session, 'legend.text.size', selected = gg_original$theme$legend.text$size)
      }
      if(!is.null(gg_original$theme$legend.text$face)) {
        updateSelectInput(session, 'legend.text.face', selected = gg_original$theme$legend.text$face)
      }
      if(!is.null(gg_original$theme$legend.text$colour)) {
        updateSelectInput(session, 'legend.text$colour', selected = gg_original$theme$legend.text$colour)
      }
      if(!is.null(gg_original$theme$legend.text$family)) {
        updateSelectInput(session, 'legend.text$family', selected = gg_original$theme$legend.text$family)
      }
      if(!is.null(gg_original$theme$legend.text$size)) {
        updateSelectInput(session, 'legend.title.size', selected = gg_original$theme$legend.text$size)
      }
      if(!is.null(gg_original$theme$legend.text$face)) {
        updateSelectInput(session, 'legend.title.face', selected = gg_original$theme$legend.text$face)
      }
      if(!is.null(gg_original$theme$legend.text$colour)) {
        updateSelectInput(session, 'legend.title$colour', selected = gg_original$theme$legend.text$colour)
      }
      if(!is.null(gg_original$theme$legend.text$family)) {
        updateSelectInput(session, 'legend.title$family', selected = gg_original$theme$legend.text$family)
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
          panel.background = element_rect(
            fill = input$panel.background.fill,
            colour = input$panel.background.colour,
            size = input$panel.background.size,
            linetype = input$panel.background.linetype
          ),
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
          )
          )
    })

  ThePlot <- renderPlot({
    print(gg_reactive())
  })
  output$ThePlot <- ThePlot
  output$ThePlot2 <- ThePlot
  output$ThePlot3 <- ThePlot

  observeEvent(input$done, {
    result <- construcThemeString('axis.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text')
    result <- c(result, construcThemeString('axis.line', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))
    result <- c(result, construcThemeString('panel.background', original = gg_original, new = gg_reactive(), std = default, element = 'element_rect'))
    result <- c(result, construcThemeString('legend.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))
    result <- c(result, construcThemeString('legend.title', original = gg_original, new = gg_reactive(), std = default, element = 'element_text'))

    if(!is.null(result)){
      result <- paste0(text, ' + theme(', paste(result, collapse = ', '),')')
      result <- formatR::tidy_source(text = result, output = FALSE, width.cutoff = 40)$text.tidy
      result <- paste(result, collapse = "\n")
      rstudioapi::insertText(result)
    }
    invisible(stopApp())
  })

  }

  viewer <- dialogViewer(dialogName = 'ggthemassist', width = 990, height = 900)
  runGadget(ui, server, viewer = viewer)

}
