<%= home_view_namespace %> ||= {}

class <%= home_view_namespace %>.HomeView extends Backbone.View
  template: JST["templates/home/index"]

  render: ->
    @$el.html(@template())
    return this