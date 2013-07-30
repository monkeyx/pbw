<%= user_view_namespace %> ||= {}

class <%= user_view_namespace %>.LoginView extends Backbone.View
  template: JST["<%= user_jst 'login' %>"]

  events:
    "submit #new-user-session": "save"

  constructor: (options) ->
    super(options)
    @model = new <%= js_user_model_namespace %>Session
    
    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem logging in', xhr
    )

    @model.bind("sync", (model, xhr, options) =>
      window.<%=js_app_name%>.User = xhr
    )

  initialize: ->
    @_modelBinder = new Backbone.ModelBinder
    @bindings = 
      'email': '[name=email]'
      'password': '[name=password]'
      'remember_me': '[name=remember_me]'

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(null,
      success: ->
        if window.<%=js_app_name%>.backlink
          window.location.hash = window.<%=js_app_name%>.backlink
        else
          window.location.hash = "/"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    @_modelBinder.bind(@model, @el, @bindings)

    return this