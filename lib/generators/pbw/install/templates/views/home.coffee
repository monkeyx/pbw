<%= home_view_namespace %> ||= {}

class <%= home_view_namespace %>.HomeView extends Backbone.View
  template: JST["<%= jst 'home' %>"]

  render: ->
    @$el.html(@template())
    return this