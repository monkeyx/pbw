<%= user_view_namespace %> ||= {}

class <%= user_view_namespace %>.RecoveryView extends Backbone.View
  template: JST["<%= user_jst 'recover_password' %>"]

  events:
    "submit #new-user-password": "save"

  constructor: (options) ->
    super(options)
    @model = new <%= js_user_model_namespace %>Recovery
    
    @model.bind("change:errors", () =>
      this.render()
    )

    @model.bind("error", (model, xhr, options) =>
      display_errors 'There was a problem recovering your password', xhr
    )

  initialize: ->
    @_modelBinder = new Backbone.ModelBinder
    @bindings = 
      email: '[name=email]'

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(@model.attributes,
      success: (user_recovery, response, options) =>
        @model = user_recovery
        window.location.hash = "/"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    @_modelBinder.bind(@model, @el, @bindings)

    return this