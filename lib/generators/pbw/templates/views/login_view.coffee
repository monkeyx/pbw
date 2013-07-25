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
      success: (user) =>
        @model = user
        window.<%= js_app_name %>.User = @model
        window.location.hash = "/"

      error: (model, jqXHR) =>
        $("#error").html('<h2>There was a problem registering</h2><ul>')
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