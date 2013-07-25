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

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @model.save(@model.attributes,
      success: (user_recovery) =>
        @model = user_recovery
        window.location.hash = "/"

      error: (model, jqXHR) =>
        form_errors 'There was a problem recovering your password', jqXHR
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this