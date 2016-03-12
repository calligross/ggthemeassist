#' ggThemeAssist
#'
#' \code{ggThemeAssist} is a RStudio-Addin that delivers a graphical interface for editing ggplot2 theme elements.
#'
#' @details To run the addin, highlight a ggplot2-object in your current script and select \code{ggThemeAssist} from the Addins-menu within RStudio. After editing themes and terminating the addin, a character string containing the desired changes is inserted in your current script.
#' @return \code{ggThemeAssist} returns a character vector.
#' @import miniUI
#' @import shiny
#' @import ggplot2
#' @import formatR
#' @import rstudioapi
ggThemeAssist <- function(){

  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text

  stopifnot(nchar(text) > 0)

  if (grepl('[\\+\\(]', text)) {
    gg_original <- eval(parse(text = text))
  } else {
    gg_original <- get(text, envir = .GlobalEnv)
  }

  stopifnot(is.ggplot(gg_original))

  default <- updateDefaults(gg_original, default)

  ui <- miniPage(
    gadgetTitleBar("ggplot Theme Assistant"),
    miniTabstripPanel(
      miniTabPanel("Panel & Background", icon = icon('sliders'),
                   plotOutput("ThePlot2", width = '100%', height = '45%'),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = heading.height, width = '100%',
                                            headingOutput('Plot Background'),
                                            headingOutput('Panel Background'),
                                            headingOutput('Grid Major'),
                                            headingOutput('Grid Minor')
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('plot.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$plot.background$fill),
                                            selectInput('panel.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$panel.background$fill),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('plot.background.linetype', label = 'Type', choices = linetypes, selected = default$plot.background$linetype, width = input.width),
                                            selectInput('panel.background.linetype', label = 'Type', choices = linetypes, selected = default$panel.background$linetype, width = input.width),
                                            selectInput('panel.grid.major.type', label = 'Type', choices = linetypes, selected = default$panel.grid.major$linetype, width = input.width),
                                            selectInput('panel.grid.minor.type', label = 'Type', choices = linetypes, selected = default$panel.grid.minor$linetype, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('plot.background.size', label = 'Size', step = 0.1, value = default$plot.background$size, width = input.width),
                                            numericInput('panel.background.size', label = 'Size', step = 0.1, value = default$panel.background$size, width = input.width),
                                            numericInput('panel.grid.major.size', label = 'Size', step = 0.1, value = default$panel.grid.major$size, min = 0, width = input.width),
                                            numericInput('panel.grid.minor.size', label = 'Size', step = 0.1, value = default$panel.grid.minor$size, min = 0, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('plot.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$plot.background$colour),
                                            selectInput('panel.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$panel.background$colour),
                                            selectInput('panel.grid.major.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.major$colour, width = input.width),
                                            selectInput('panel.grid.minor.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.minor$colour, width = input.width)
                                    )
                   )
      ),
      miniTabPanel("Axis", icon = icon('sliders'),
                   plotOutput("ThePlot", width = '100%', height = '45%'),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = heading.height, width = '100%',
                                            headingOutput('Axis text'),
                                            headingOutput('Axis text.x'),
                                            headingOutput('Axis text.y'),
                                            headingOutput('Axis line'),
                                            headingOutput('Axis ticks')
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.family', label = 'Family', choices = text.families, selected = default$axis.text$family, width = input.width),
                                            selectInput('axis.text.x.family', label = 'Family', choices = c('None' = 'NULL', text.families), selected = NULL, width = input.width),
                                            selectInput('axis.text.y.family', label = 'Family', choices = c('None' = 'NULL', text.families), selected = NULL, width = input.width),
                                            selectInput('axis.line.type', label = 'Type', choices = linetypes, selected = default$axis.line$linetype, width = input.width),
                                            selectInput('axis.ticks.type', label = 'Type', choices = linetypes, selected = default$axis.ticks$linetype, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.text$face),
                                            selectInput('axis.text.x.face', label = 'Face', choices = c('None' = 'NULL', text.faces), width = input.width, selected = NULL),
                                            selectInput('axis.text.y.face', label = 'Face', choices = c('None' = 'NULL', text.faces), width = input.width, selected = NULL),
                                            numericInput('axis.line.size', label = 'Size', step = 0.1, value = default$axis.line$size, min = 0,width = input.width),
                                            numericInput('axis.ticks.size', label = 'Size', step = 0.1, value = default$axis.ticks$size, min = 0,width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.size', label = 'Size', min = 1, max = 30, value = default$axis.text$size, step = 1, width = input.width),
                                            numericInput('axis.text.x.size', label = 'Size', min = 1, max = 30, value = NULL, step = 1, width = input.width),
                                            numericInput('axis.text.y.size', label = 'Size', min = 1, max = 30, value = NULL, step = 1, width = input.width),
                                            selectInput('axis.line.colour', label = 'Colour', choices = colours.available, selected = default$axis.line$colour, width = input.width),
                                            selectInput('axis.ticks.colour', label = 'Colour', choices = colours.available, selected = default$axis.ticks$colour, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectInput('axis.text.colour', label = 'Colour', choices = colours.available, selected = default$axis.text$colour, width = input.width),
                                            selectInput('axis.text.x.colour', label = 'Colour', choices = c('None' = 'NULL', colours.available), selected = NULL, width = input.width),
                                            selectInput('axis.text.y.colour', label = 'Colour', choices = c('None' = 'NULL', colours.available), selected = NULL, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.hjust', 'Hjust', value = default$axis.text$hjust, step = 0.25, width = input.width),
                                            numericInput('axis.text.hjust.x', 'Hjust', value = NULL, step = 0.25, width = input.width),
                                            numericInput('axis.text.hjust.y', 'Hjust', value = NULL, step = 0.25, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.vjust', 'Vjust', value = default$axis.text$vjust, step = 0.25, width = input.width),
                                            numericInput('axis.text.x.vjust', 'Vjust', value = NULL, step = 0.25, width = input.width),
                                            numericInput('axis.text.y.vjust', 'Vjust', value = NULL, step = 0.25, width = input.width),
                                            "",
                                            ""
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('axis.text.angle', label = 'Angle', min = -180, max = 180, value = default$axis.text$angle, step = 5, width = input.width),
                                            numericInput('axis.text.x.angle', label = 'Angle', min = -180, max = 180, value = NULL, step = 5, width = input.width),
                                            numericInput('axis.text.y.angle', label = 'Angle', min = -180, max = 180, value = NULL, step = 5, width = input.width),
                                            "",
                                            ""
                                    )
                   )),
      miniTabPanel("Title and label", icon = icon('sliders'),
                   plotOutput("ThePlot4", width = '100%', height = '45%'),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = heading.height, width = '100%',
                                            headingOutput('Labels'),
                                            headingOutput('Plot Title'),
                                            headingOutput('Axis Labels')
                                    ),
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
      miniTabPanel("Legend", icon = icon('sliders'),
                   plotOutput("ThePlot3", width = '100%', height = '45%', click = 'legend.click'),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = heading.height, width = '100%',
                                            headingOutput('Legend position'),
                                            headingOutput('Legend Title'),
                                            headingOutput('Legend Text'),
                                            headingOutput("Legend Background"),
                                            headingOutput("Legend Keys")
                                    ),
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
                                            conditionalPanel(
                                              condition = "input['legend.position'] == 'XY'",
                                              numericInput('legend.position.x', label = 'X Coord', min = 0, max = 1, value = default$legend.position.x, step = 0.01, width = input.width)
                                            ),
                                            numericInput('legend.title.size', label = 'Size', min = 1, max = 30, value = default$legend.title$size, step = 1, width = input.width),
                                            numericInput('legend.text.size', label = 'Size', min = 1, max = 30, value = default$legend.text$size, step = 1, width = input.width),
                                            numericInput('legend.background.size', label = 'Size', step = 0.1, value = default$legend.background$size, width = input.width),
                                            numericInput('legend.key.size', label = 'Size', step = 0.1, value = default$legend.key$size, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            conditionalPanel(
                                              condition = "input['legend.position'] == 'XY'",
                                              numericInput('legend.position.y', label = 'Y Coord', min = 0, max = 1, value = default$legend.position.y, step = 0.01, width = input.width)
                                            ),
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
        labs(title = if (input$plot.title == '') { NULL } else { input$plot.title },
             x = if (input$axis.title.x == '') { NULL } else { input$axis.title.x },
             y = if (input$axis.title.y == '') { NULL } else { input$axis.title.y },
             fill = if (input$legend.fill.title == '') { NULL } else { input$legend.fill.title },
             colour = if (input$legend.colour.title == '') { NULL } else { input$legend.colour.title }) +
        theme(
          axis.text = element_text(
            size = input$axis.text.size,
            colour = input$axis.text.colour,
            face = input$axis.text.face,
            family = input$axis.text.family,
            angle = input$axis.text.angle,
            hjust = input$axis.text.hjust,
            vjust = input$axis.text.vjust,
            lineheight = input$axis.text.lineheight),
          axis.text.x = element_text(
            size = setNull(input$axis.text.x.size),
            colour = setNull(input$axis.text.x.colour),
            family = setNull(input$axis.text.x.family),
            angle = setNull(input$axis.text.x.angle),
            hjust = setNull(input$axis.text.x.hjust),
            vjust = setNull(input$axis.text.x.vjust)
            ),
          axis.text.y = element_text(
            size = setNull(input$axis.text.y.size),
            colour = setNull(input$axis.text.y.colour),
            family = setNull(input$axis.text.y.family),
            angle = setNull(input$axis.text.y.angle),
            hjust = setNull(input$axis.text.y.hjust),
            vjust = setNull(input$axis.text.y.vjust)
          ),
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
          plot.background = element_rect(
            fill = input$plot.background.fill,
            colour = input$plot.background.colour,
            size = input$plot.background.size,
            linetype = input$plot.background.linetype
          ),
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
          legend.position = (if (input$legend.position == 'XY') {
            c(input$legend.position.x, input$legend.position.y)
          } else {
            input$legend.position
          }),
          legend.direction = input$legend.direction
        )
    })

    observeEvent(input$legend.click, {
      x.click <- input$legend.click$x / (input$legend.click$domain$right - input$legend.click$domain$left)
      y.click <- input$legend.click$y / (input$legend.click$domain$top - input$legend.click$domain$bottom)
      updateSelectInput(session, 'legend.position', selected = 'XY')
      updateSelectInput(session, 'legend.position.x', selected = round(x.click, 4))
      updateSelectInput(session, 'legend.position.y', selected = round(y.click, 4))
    })

    ThePlot <- renderPlot({
      print(gg_reactive())
    })
    output$ThePlot <- ThePlot
    output$ThePlot2 <- ThePlot
    output$ThePlot3 <- ThePlot
    output$ThePlot4 <- ThePlot

    observeEvent(input$done, {
      result <- sapply(AvailableElements, compileResults, new = gg_reactive(), original = gg_original, std = default, USE.NAMES = FALSE)
      result <- result[!is.na(result)]

      labelResult <- construcThemeString('labs', original = gg_original, new = gg_reactive(), std = default, category = 'labels')

      if(!is.null(result) || !is.null(labelResult)) {
        if(!is.null(result) && length(result) > 0) {
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

  viewer <- dialogViewer(dialogName = 'ggThemeAssist', width = 990, height = 900)
  runGadget(ui, server, stopOnCancel = FALSE, viewer = viewer)

}
