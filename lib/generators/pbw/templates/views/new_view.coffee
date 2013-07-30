<%= view_namespace %> ||= {}

class <%= view_namespace %>.NewView extends Backbone.View
  template: JST["<%= jst 'new' %>"]

  events:
    "submit #new-<%= singular_name %>": "save"

  constructor: (options) ->
    super(options)
    @model = options.model

    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem saving <%= singular_name %>', xhr, "/<%=plural_model_name%>/new"
    )

  initialize: ->
    @_modelBinder = new Backbone.ModelBinder
    @bindings = <% default_attributes.each do |attribute| -%><% unless attribute[:name].start_with?('_') %>
      <%= attribute[:name] %> : '[name=<%= attribute[:name] %>]'
<% end %><% end %><% attributes.each do |attribute| -%>
      <%= attribute.name %> : '[name=<%= attribute.name %>]'
<% end %>

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(null,
      success: (<%= singular_name %>, response, options) =>
        @model = <%= singular_name %>
        window.location.hash = "/<%=plural_model_name%>/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    @_modelBinder.bind(@model, @el, @bindings)

    return this