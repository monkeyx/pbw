<%= view_namespace %> ||= {}

class <%= view_namespace %>.ShowView extends Backbone.View
  template: JST["<%= jst 'show' %>"]

  initialize: () ->
    @model = options.model

  render: ->
  	@model.fetch
  	  success: (model) =>
        @$el.html(@template(model.toJSON() ))
      error: (model, response)
        debug response
    return this