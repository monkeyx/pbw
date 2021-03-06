class <%= router_name %> extends Backbone.Router
  initialize: (options) ->
    

  routes:
    ""    : "home"
    "login" : "login"
    "logout" : "logout"
    "signup" : "signup"
    "password_recovery" : "passwordRecovery"
    

  home: ->
    @view = new <%= "#{js_app_name}.Views.Home.IndexView" %>
    $("#app").html(@view.render().el)

  login: ->
    @view = new <%= "#{js_app_name}.Views.Users.LoginView" %>
    $("#app").html(@view.render().el)

  logout: ->
    $.ajax 
      url: '/pbw/users/sign_out.json'
      type: 'DELETE'
      complete: ->
        window.<%= js_app_name %>.User = null
        window.location.hash = "/"
    
  signup: ->
    @view = new <%= "#{js_app_name}.Views.Users.SignupView" %>
    $("#app").html(@view.render().el)

  passwordRecovery: ->
    @view = new <%= "#{js_app_name}.Views.Users.RecoveryView" %>
    $("#app").html(@view.render().el)