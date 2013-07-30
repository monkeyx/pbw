<%= view_namespace %> ||= {}

class <%= view_namespace %>.EditView extends Backbone.View
  template: JST["<%= jst 'edit' %>"]

  events:
    "submit #edit-<%= singular_name %>": "update"

  constructor: (options) ->
    super(options)
    @model = options.model
    
    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem saving <%= singular_name %>', xhr, "/<%=plural_model_name%>/#{@model.id}/edit"
    )

  initialize: ->
    @_modelBinder = new Backbone.ModelBinder
    @bindings = <% default_attributes.each do |attribute| -%><% unless attribute[:name].start_with?('_') %>
      '<%=attribute[:name]%>' : '[name=<%= attribute[:name]] %>'<% end %><% end %>
      

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (<%= singular_name %>, response, options) =>
        @model = <%= singular_name %>
        window.location.hash = "/<%=plural_model_name%>/#{@model.id}"
      error: (model, xhr, options) =>
        display_errors 'There was a problem saving <%= singular_name %>', xhr
    )

  render: ->
    @model.fetch
      success: (model) =>
        @$el.html(@template(model.toJSON() ))
        @_modelBinder.bind(@model, @el, @bindings)
      error: (model, response) ->
        debug response
    return this