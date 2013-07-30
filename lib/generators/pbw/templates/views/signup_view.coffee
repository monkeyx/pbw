<%= user_view_namespace %> ||= {}

class <%= user_view_namespace %>.SignupView extends Backbone.View
  template: JST["<%= user_jst 'signup' %>"]

  events:
    "submit #new-user": "save"

  constructor: (options) ->
    super(options)
    @model = new <%= js_user_model_namespace %>Registration
    
    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem signing up', xhr
    )

  initialize: ->
    @_modelBinder = new Backbone.ModelBinder
    @bindings = 
      'name': '[name=name]'
      'email': '[name=name]'
      'password': '[name=password]'
      'password_confirmation': '[name=password_confirmation]'

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(@model.attributes,
      success: (user, response, options) =>
        @model = user
        if window.<%=js_app_name%>.backlink
          window.location.hash = window.<%=js_app_name%>.backlink
        else
          window.location.hash = "/"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    @_modelBinder.bind(@model, @el, @bindings)

    return this