#' ggThemeAssist
#'
#' \code{ggThemeAssist} is a RStudio-Addin that delivers a graphical interface for editing ggplot2 theme elements.
#'
#' @details To run as an RStudio addin, highlight a ggplot2 object in your current script and select \code{ggThemeAssist} from the Addins-menu within RStudio. After editing themes and terminating the addin, a character string containing the desired changes is inserted in your current script.
#'
#' To run as a Shiny Gadget outside of RStudio, pass the name of the ggplot2-objeobject to the `text` parameter of this function.  The gadget will be opened in the default browser.  After editing themes and terminating the addin, a character string containing the desired changes will be echoed on thethe command line.
#' 
#' @param text (string) The name of a ggplot2 object, or code to create a ggplot2 object.  Only for use in the console; has no effect when running as an RStudio addin.
#'
#' @return \code{ggThemeAssist} returns a character vector.
#' @import miniUI
#' @import shiny
#' @import ggplot2
#' @import formatR
#' @import rstudioapi
#' @export
ggThemeAssist <- function(text = ""){

  # Check if subtitles are supported
  SubtitlesSupport <- any(names(formals(ggtitle)) == 'subtitle')

  # Find out whether it is being run as an RStudio add-in or in the console
  addin <- missing(text) && rstudioapi::isAvailable()

  # If this is being run as an RStudio addin, then get the document context.
  if (addin) {
    context <- rstudioapi::getActiveDocumentContext()

    # Set the default data to use based on the selection.
    text <- context$selection[[1]]$text
  }

  if (nchar(text) == 0) {
    stop('Please highlight a ggplot2 plot before selecting this addin, or, if using in the console, please provide a ggplot2 object to the `text` parameter.')
  }

  if (grepl('[\\+\\(]', text)) {
    gg_original <- eval(parse(text = text))
  } else {
    text <- gsub('\\s+', '', text)
    gg_original <- get(text, envir = .GlobalEnv)
  }

  if (!is.ggplot(gg_original)) {
    stop('No ggplot2 object has been selected. Fool someone else!')
  }
  # add rgb colours to the available colours
  colours.available <- c(colours.available, getRGBHexColours(gg_original))
  default <- updateDefaults(gg_original, default, linetypes = linetypes)

  ui <- miniPage(
    tags$script(jscodeWidth),
    tags$script(jscodeHeight),

    gadgetTitleBar("ggplot Theme Assistant"),
    miniTabstripPanel(selected = 'Panel & Background',
      miniTabPanel("Settings", icon = icon('sliders'),
                   plotOutput("ThePlot5", width = '100%', height = '45%'),
                   miniContentPanel(scrollable = TRUE,
                                    fillRow(height = heading.height, width = '100%',
                                            headingOutput('Plot dimensions')
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            numericInput('plot.width', label = 'Width', min = 0, max = 10, step = 1, value = 10),
                                            numericInput('plot.height', label = 'Height', min = 0, max = 10, step = 1, value = 5)
                                    )
                   )
      ),
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
                                            selectizeInput('plot.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$plot.background$fill, options = list(create = TRUE)),
                                            selectizeInput('panel.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$panel.background$fill, options = list(create = TRUE)),
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
                                            selectizeInput('plot.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$plot.background$colour, options = list(create = TRUE)),
                                            selectizeInput('panel.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$panel.background$colour, options = list(create = TRUE)),
                                            selectizeInput('panel.grid.major.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.major$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('panel.grid.minor.colour', label = 'Colour', choices = colours.available, selected = default$panel.grid.minor$colour, width = input.width, options = list(create = TRUE))
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
                                            selectizeInput('axis.line.colour', label = 'Colour', choices = colours.available, selected = default$axis.line$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('axis.ticks.colour', label = 'Colour', choices = colours.available, selected = default$axis.ticks$colour, width = input.width, options = list(create = TRUE))
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            selectizeInput('axis.text.colour', label = 'Colour', choices = colours.available, selected = default$axis.text$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('axis.text.x.colour', label = 'Colour', choices = c('None' = 'NULL', colours.available), selected = NULL, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('axis.text.y.colour', label = 'Colour', choices = c('None' = 'NULL', colours.available), selected = NULL, width = input.width, options = list(create = TRUE)),
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
                                            textInput('plot.title', label = 'Title', value = preserveNewlines(gg_original$labels$title), width = input.width),
                                            selectInput('plot.title.family', label = 'Family', choices = text.families, selected = default$plot.title$family, width = input.width),
                                            selectInput('axis.title.family', label = 'Family', choices = text.families, selected = default$axis.title$family, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('axis.title.x', label = 'x-Axis', value = preserveNewlines(gg_original$labels$x), width = input.width),
                                            selectInput('plot.title.face', label = 'Face', choices = text.faces, width = input.width, selected = default$plot.title$face),
                                            selectInput('axis.title.face', label = 'Face', choices = text.faces, width = input.width, selected = default$axis.title$face)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('axis.title.y', label = 'y-Axis', value = preserveNewlines(gg_original$labels$y), width = input.width),
                                            numericInput('plot.title.size', label = 'Size', min = 1, max = 30, value = default$plot.title$size, step = 1, width = input.width),
                                            numericInput('axis.title.size', label = 'Size', min = 1, max = 30, value = default$axis.title$size, step = 1, width = input.width)
                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('legend.colour.title', label = 'Colour', value = preserveNewlines(gg_original$labels$colour), width = input.width),
                                            selectizeInput('plot.title.colour', label = 'Colour', choices = colours.available, selected = default$plot.title$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('axis.title.colour', label = 'Colour', choices = colours.available, selected = default$axis.title$colour, width = input.width, options = list(create = TRUE))

                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            textInput('legend.fill.title', label = 'Fill', value = preserveNewlines(gg_original$labels$fill), width = input.width),
                                            numericInput('plot.title.hjust', 'Hjust', value = default$plot.title$hjust, step = 0.25, width = input.width),
                                            numericInput('axis.title.hjust', 'Hjust', value = default$axis.title$hjust, step = 0.25, width = input.width)

                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            '',
                                            numericInput('plot.title.vjust', 'Vjust', value = default$plot.title$vjust, step = 0.25, width = input.width),
                                            numericInput('axis.title.vjust', 'Vjust', value = default$axis.title$vjust, step = 0.25, width = input.width)

                                    ),
                                    fillRow(height = line.height, width = '100%',
                                            '',
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
                                            selectizeInput('legend.background.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$legend.background$fill, options = list(create = TRUE)),
                                            selectizeInput('legend.key.fill', label = 'Fill', choices = colours.available, width = input.width, selected = default$legend.key$fill, options = list(create = TRUE))
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
                                            selectizeInput('legend.title.colour', label = 'Colour', choices = colours.available, selected = default$legend.title$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('legend.text.colour', label = 'Colour', choices = colours.available, selected = default$legend.text$colour, width = input.width, options = list(create = TRUE)),
                                            selectizeInput('legend.background.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$legend.background$colour, options = list(create = TRUE)),
                                            selectizeInput('legend.key.colour', label = 'Colour', choices = colours.available, width = input.width, selected = default$legend.key$colour, options = list(create = TRUE))
                                    )
                   )
      ),
      if (SubtitlesSupport) {
        miniTabPanel("Subtitle and Caption", icon = icon('sliders'),
                     plotOutput("ThePlot6", width = '100%', height = '45%'),
                     miniContentPanel(scrollable = TRUE,
                                      fillRow(width = '100%', height = heading.height,
                                              headingOutput('Subtitle')
                                      ),
                                      fillRow(width = '100%', height = line.height,
                                              tags$div(style="display:table; width:100%; margin:auto",
                                                       tags$textarea(id="plot.subtitle.text", label="Subtitle",
                                                                     rows=3, cols=80, gg_original$labels$subtitle,
                                                                     style="width:inherit; font-size:9pt; padding:5px"
                                                       )
                                              )
                                      ),
                                      fillRow(width = '100%', height = line.height,
                                              selectInput('plot.subtitle.family', label = 'Family', choices = text.families, selected = default$plot.subtitle$family, width = input.width2),
                                              selectInput('plot.subtitle.face', label = 'Face', choices = text.faces, width = input.width2, selected = default$plot.subtitle$face),
                                              numericInput('plot.subtitle.size', label = 'Size', min = 1, max = 30, value = default$plot.subtitle$size, step = 1, width = input.width2),
                                              selectizeInput('plot.subtitle.colour', label = 'Colour', choices = colours.available, selected = default$plot.subtitle$colour, width = input.width2, options = list(create = TRUE)),
                                              numericInput('plot.subtitle.hjust', 'Hjust', value = default$plot.subtitle$hjust, step = 0.25, width = input.width2)
                                      ),
                                      fillRow(width = '100%', height = heading.height,
                                              headingOutput('Caption')
                                      ),
                                      fillRow(width = '100%', height = line.height,
                                              tags$div(style="display:table; width:100%; margin:auto",
                                                       tags$textarea(id="plot.caption.text", label="Subtitle",
                                                                     rows=3, cols=80, gg_original$labels$caption,
                                                                     style="width:inherit; font-size:9pt; padding:5px"
                                                       )
                                              )
                                      ),
                                      fillRow(width = '100%', height = line.height,
                                              selectInput('plot.caption.family', label = 'Family', choices = text.families, selected = default$plot.caption$family, width = input.width2),
                                              selectInput('plot.caption.face', label = 'Face', choices = text.faces, width = input.width2, selected = default$plot.caption$face),
                                              numericInput('plot.caption.size', label = 'Size', min = 1, max = 30, value = default$plot.caption$size, step = 1, width = input.width2),
                                              selectizeInput('plot.caption.colour', label = 'Colour', choices = colours.available, selected = default$plot.caption$colour, width = input.width2, options = list(create = TRUE)),
                                              numericInput('plot.caption.hjust', 'Hjust', value = default$plot.caption$hjust, step = 0.25, width = input.width2)
                                      )


                     )
        )
        }
    ))



  server <- function(input, output, session) {

    gg_reactive <- reactive({

      validate(
        need(is.validColour(input$plot.background.fill), ''),
        need(is.validColour(input$panel.background.fill), ''),
        need(is.validColour(input$plot.background.colour), ''),
        need(is.validColour(input$panel.background.colour), ''),
        need(is.validColour(input$panel.grid.major.colour), ''),
        need(is.validColour(input$panel.grid.minor.colour), ''),
        need(is.validColour(input$axis.line.colour), ''),
        need(is.validColour(input$axis.ticks.colour), ''),
        need(is.validColour(input$axis.text.colour), ''),
        need(is.validColour(input$axis.text.x.colour), ''),
        need(is.validColour(input$axis.text.y.colour), ''),
        need(is.validColour(input$plot.title.colour), ''),
        need(is.validColour(input$axis.title.colour), ''),
        need(is.validColour(input$legend.background.fill), ''),
        need(is.validColour(input$legend.key.fill), ''),
        need(is.validColour(input$legend.title.colour), ''),
        need(is.validColour(input$legend.text.colour), ''),
        need(is.validColour(input$legend.background.colour), ''),
        need(is.validColour(input$legend.key.colour), '')
      )

      gg <- gg_original +
        labs(
          title = checkInputText(input$plot.title),
             x = checkInputText(input$axis.title.x),
             y = checkInputText(input$axis.title.y),
             fill = checkInputText(input$legend.fill.title),
             colour = checkInputText(input$legend.colour.title)
             ) +
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
      if (SubtitlesSupport) {
        gg <- gg + labs(
          subtitle = if (input$plot.subtitle.text == '') {NULL} else {input$plot.subtitle.text},
          caption = if (input$plot.caption.text == '') {NULL} else {input$plot.caption.text}
        ) +
          theme(
            plot.subtitle = element_text(
              size = input$plot.subtitle.size,
              colour = input$plot.subtitle.colour,
              face = input$plot.subtitle.face,
              family = input$plot.subtitle.family,
              #angle = input$plot.subtitle.angle,
              hjust = input$plot.subtitle.hjust,
              #vjust = input$plot.subtitle.vjust,
              lineheight = input$plot.subtitle.lineheight),
            plot.caption = element_text(
              size = input$plot.caption.size,
              colour = input$plot.caption.colour,
              face = input$plot.caption.face,
              family = input$plot.caption.family,
              #angle = input$plot.caption.angle,
              hjust = input$plot.caption.hjust,
              #vjust = input$plot.caption.vjust,
              lineheight = input$plot.caption.lineheight)
          )
      }

      return(gg)

    })

    observeEvent(input$legend.click, {
      x.click <- input$legend.click$x / (input$legend.click$domain$right - input$legend.click$domain$left)
      y.click <- input$legend.click$y / (input$legend.click$domain$top - input$legend.click$domain$bottom)
      updateSelectInput(session, 'legend.position', selected = 'XY')
      updateSelectInput(session, 'legend.position.x', selected = round(x.click, 4))
      updateSelectInput(session, 'legend.position.y', selected = round(y.click, 4))
    })

    ThePlot <- renderPlot(width = function() {
        validate(
          need(is.numeric(input$plot.width), ''),
                 need(is.numeric(input$plot.height), ''),
                 need(!is.null(input$ViewerWidth), '')
                 )
        min(input$plot.width / input$plot.height * input$ViewerWidth * 45 / 100,
            input$ViewerWidth
            )
    },
      {
      print(gg_reactive())
    })
    output$ThePlot <- ThePlot
    output$ThePlot2 <- ThePlot
    output$ThePlot3 <- ThePlot
    output$ThePlot4 <- ThePlot
    output$ThePlot5 <- ThePlot
    output$ThePlot6 <- ThePlot

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
        if (addin) {
          rstudioapi::insertText(result)
        }
      }
      if (addin) {
        invisible(stopApp())
      } else {
        stopApp(result)
      }
    })

    observeEvent(input$cancel, {
      invisible(stopApp())
    })

  }

  viewer <- dialogViewer(dialogName = 'ggThemeAssist', width = 990, height = 900)
  runGadget(ui, server, stopOnCancel = FALSE, viewer = viewer)

}
