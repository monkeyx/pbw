class AppRouter extends Backbone.Router
  initialize: (options) ->
    

  routes:
    ""    : "home"
    

  home: ->
    @view = new <%= "#{js_app_name}.Home.HomeView" %>
    $("#app").html(@view.render().el)