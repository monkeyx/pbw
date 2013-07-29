# PBW Helper Methods

# Debugging to console
@debug = (message) ->
  window.console && console.log message

# User session
@current_user = ->
  window.<%= js_app_name %>.User

# Error handling
@display_errors = (message, jqXHR) ->
  debug message
  debug jqXHR
  $("#error").html('<h3>' + message + '</h3><ul>')
  if jqXHR && jqXHR.responseText
    _.each($.parseJSON(jqXHR.responseText), (value,key) ->
      $("#error").append('<li>' + value + '</li>')
    )
  $("#error").append('</ul>')
  $("#error").show()
