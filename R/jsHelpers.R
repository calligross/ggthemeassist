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

jsColourSelector <- I(
  '{
  option: function(item, escape) {
  return "<div><div style=\'width:25px; height:15px; background-color:" + item.rgb + "; float:left; vertical-align:bottom\'></div>&nbsp;" + escape(item.name) + "</div>";
  }
  }')
