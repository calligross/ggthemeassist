jscodeHeight <-
  '$(document).on("shiny:connected", function(e) {
    var jsHeight = document.documentElement.clientHeight;
    Shiny.onInputChange("ViewerHeight",jsHeight);
  });'

jscodeWidth <-
  '$(document).on("shiny:connected", function(e) {
    var jsWidth = document.documentElement.clientWidth;
    Shiny.onInputChange("ViewerWidth",jsWidth);
  });'
