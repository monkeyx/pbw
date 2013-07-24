<%= home_view_namespace %> ||= {}

class <%= home_view_namespace %>.IndexView extends Backbone.View
  template: JST["templates/home/index"]

  render: ->
    @$el.html(@template())
    return this