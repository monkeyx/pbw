<%= view_namespace %> ||= {}

class <%= view_namespace %>.ShowView extends Backbone.View
  template: JST["<%= jst 'show' %>"]

  initialize: () ->
    @model = options.model
    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem displaying <%= singular_name %>', xhr, "/<%=model_namespace.downcase%>/#{@model.id}"
    )

  render: ->
  	@model.fetch
  	  success: (model) =>
        @$el.html(@template(model.toJSON() ))
      error: (model, response) ->
        debug response
    return this