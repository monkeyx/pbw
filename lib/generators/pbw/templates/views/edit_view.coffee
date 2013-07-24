<%= view_namespace %> ||= {}

class <%= view_namespace %>.EditView extends Backbone.View
  template: JST["<%= jst 'edit' %>"]

  events:
    "submit #edit-<%= singular_name %>": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (<%= singular_name %>) =>
        @model = <%= singular_name %>
        window.location.hash = "/<%=model_namespace.downcase%>/#{@model.id}"
      error: (model, jqXHR) =>
        $("#error").html('<h2>There was a problem saving the <%= singular_name %></h2><ul>')
        _.each($.parseJSON(jqXHR.responseText), (value,key) ->
          $("#error").append('<li>' + value + '</li>')
        )
        $("#error").append('</ul>')
        $("#error").show()
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this