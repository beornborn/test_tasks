$(document).ready ->
  $("#banner_container").click ->
    $.post "/banner_for_platforms/" + $(this).attr("bfp_id") + "/click"
