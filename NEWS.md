# ggThemeAssist

# ggThemeAssist 0.1.5.9000

* Added support for strip.background and strip.text

# ggThemeAssist 0.1.5

This is a bug fix release. When theme$text$size was NULL, ggThemeAssist crashed at start. (#65)

# ggThemeAssist 0.1.4

Second CRAN release after 0.1.0

* Removed invalidateLater() due to rendering problems with facetted plots.

# ggThemeAssist 0.1.3

## New features

* Enable/disable formatR
* Multiline results

Multiline results look like:

```r
gg <- gg + theme(panel.grid.major = element_line(size  =  0.6))
gg <- gg + theme(panel.grid.minor = element_line(size  =  0.6))
gg <- gg + theme(panel.background = element_rect(size  =  0.6))
```
Multiline results are only available, if an ggplot2 object has been highlighted.

## Bugfixes

* Handling of empty theme strings. Closes #55


# ggThemeAssist 0.1.2

## New features
* subtitle* 
* caption*
* Set legend position by click
* Set the plot dimensions
* Run ggThemeAssist from the console, e.g.: ggThemeAssistGadget(gg)
* Legend labels now support size, shape, alpha and linetype
* Previews for colour selection

*) Please consider that subtitle and captions require the [latest version of `ggplot2` from GitHub](https://github.com/hadley/ggplot2#installation).


## Bugfixes
* Plot height is now a relative value to improve visibility in combinations with lower screen resolutions. Closes #32.
* Apply preset themes correctly to input widgets. Closes #36
* Added validate checks for colours. Closes #41
* Reduce the given fonts if extrafont package is installed. Closes #35
* Handle newlines correctly. Closes #44



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
