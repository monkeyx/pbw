<%= view_namespace %> ||= {}

class <%= view_namespace %>.NewView extends Backbone.View
  template: JST["<%= jst 'new' %>"]

  events:
    "submit #new-<%= singular_name %>": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      form_errors 'There was a problem saving <%= singular_name %>', xhr
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (<%= singular_name %>, response, options) =>
        @model = <%= singular_name %>
        window.location.hash = "/<%=model_namespace.downcase%>/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this