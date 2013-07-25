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

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(@model.attributes,
      success: (user) =>
        window.console && console.log user
        @model = user
        window.<%= js_app_name %>.User = @model
        window.location.hash = "/"

      error: (model, jqXHR) =>
        form_errors 'There was a problem signing up', jqXHR
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this