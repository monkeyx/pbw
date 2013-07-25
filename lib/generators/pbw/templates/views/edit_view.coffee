<%= view_namespace %> ||= {}

class <%= view_namespace %>.EditView extends Backbone.View
  template: JST["<%= jst 'edit' %>"]

  events:
    "submit #edit-<%= singular_name %>": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (<%= singular_name %>, response, options) =>
        @model = <%= singular_name %>
        window.location.hash = "/<%=model_namespace.downcase%>/#{@model.id}"
      error: (model, xhr, options) =>
        form_errors 'There was a problem saving <%= singular_name %>', xhr
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this