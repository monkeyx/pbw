# PBW Helper Methods

# Debugging to console
@debug = (message) ->
  window.console && console.log message

# User session
@current_user = ->
  window.<%= js_app_name %>.User

@is_admin = ->
  current_user() && (current_user().role == 'superadmin' || current_user().role == 'admin')

# Error handling
@display_errors = (message, jqXHR, backlink) ->
  debug message
  debug jqXHR
  if jqXHR && jqXHR.status == 401
    if backlink
      window.<%=js_app_name%>.backlink = backlink
    window.location.hash = '/login'

  _.defer =>
    $("#error").html('<h3>' + message + '</h3><ul>')
    if jqXHR && jqXHR.responseText
      _.each($.parseJSON(jqXHR.responseText), (value,key) ->
        $("#error").append('<li>' + value + '</li>')
      )
    $("#error").append('</ul>')
    $("#error").show()
