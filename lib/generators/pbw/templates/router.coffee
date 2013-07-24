class <%= router_name %> extends Backbone.Router
  initialize: (options) ->
    

  routes:
    ""    : "home"
    

  home: ->
    @view = new <%= "#{js_app_name}.Views.Home.IndexView" %>
    $("#app").html(@view.render().el)