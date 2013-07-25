class <%= router_name %> extends Backbone.Router
  initialize: (options) ->
    

  routes:
    ""    : "home"
    "login" : "login"
    "signup" : "signup"
    "password_recovery" : "passwordRecovery"
    

  home: ->
    @view = new <%= "#{js_app_name}.Views.Home.IndexView" %>
    $("#app").html(@view.render().el)

  login: ->
    @view = new <%= "#{js_app_name}.Views.Users.LoginView" %>
    $("#app").html(@view.render().el)

  signup: ->
    @view = new <%= "#{js_app_name}.Views.Users.SignupView" %>
    $("#app").html(@view.render().el)

  passwordRecovery: ->
    @view = new <%= "#{js_app_name}.Views.Users.RecoveryView" %>
    $("#app").html(@view.render().el)