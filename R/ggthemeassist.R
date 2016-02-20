
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
          fillCol(flex = c(5, 3, 2),
            plotOutput("ThePlot", width = 800, height = 400),
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
      ) #,
      # miniTabPanel("Background", icon = icon('sliders'),
      #   miniContentPanel(
      #     fillCol(flex = c(5, 3, 2),
      #       plotOutput("ThePlot2", width = 800, height = 400)
      #       )
      #   )
      # )
    )
  )

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
            size = input$axis.line.size)
          )
    })

  ThePlot <- renderPlot({
    print(gg_reactive())
  })
  output$ThePlot <- ThePlot
  output$ThePlot2 <- ThePlot

  observeEvent(input$done, {
    result <- construcThemeString('axis.text', original = gg_original, new = gg_reactive(), std = default, element = 'element_text')
    result <- c(result, construcThemeString('axis.line', original = gg_original, new = gg_reactive(), std = default, element = 'element_line'))

    if(!is.null(result)){
      result <- paste0(text, ' + theme(', paste(result, collapse = ', '),')')
      result <- formatR::tidy_source(text = result, output = FALSE, width.cutoff = 40)$text.tidy
      result <- paste(result, collapse = "\n")
      rstudioapi::insertText(result)
    }
    invisible(stopApp())
  })

  }

  viewer <- dialogViewer(dialogName = 'ggthemassist', width = 900, height = 900)
  runGadget(ui, server, viewer = viewer)

}
