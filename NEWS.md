# ggThemeAssist **dev**

[`dev`](https://github.com/calligross/ggthemeassist/tree/dev) now includes a first rough implementation of functionality for

* subtitle
* caption

Please consider that these features require the [latest version of `ggplot2` from GitHub](https://github.com/hadley/ggplot2#installation).

# ggThemeAssist 0.1.1

## New features
* Set legend position by click
* Set the plot dimensions


## Bugfixes
* Plot height is now a relative value to improve visibility in combinations with lower screen resolutions. Closes #32.
* Apply preset themes correctly to input widgets. Closes #36
* Added validate checks for colours. Closes #41
* Reduce the given fonts if extrafont package is installed. Closes #35



# ggThemeAssist 0.1.0

**ggThemeAssist** is now available on CRAN (v0.1.0).

Full list of supported themes:

* axis.title.x
* axis.title.y	
* axis.text	
* axis.ticks
* axis.line
* legend.background
* legend.key
* legend.text
* legend.title
* legend.position
* legend.direction
* panel.background
* panel.grid.major
* panel.grid.minor
* plot.background
* plot.title
