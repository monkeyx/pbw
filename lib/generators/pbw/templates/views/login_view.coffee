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

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(@model.attributes,
      success: (user, response, options) =>
        @model = user
        window.<%= js_app_name %>.User = @model
        window.location.hash = "/"

      error: (model, xhr, options) =>
        form_errors 'There was a problem logging in', xhr
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this