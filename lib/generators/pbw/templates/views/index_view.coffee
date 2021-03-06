<%= view_namespace %> ||= {}

class <%= view_namespace %>.IndexView extends Backbone.View
  template: JST["<%= jst 'index' %>"]

  initialize: () ->
    @options.<%= plural_model_name %>.bind('reset', @addAll)
    @options.<%= plural_model_name %>.bind("error", (model, xhr, options) =>
      display_errors '', xhr, "/<%=plural_model_name%>"
      @$("#<%=plural_model_name%>-table").hide()
    )

  addAll: () =>
    @options.<%= plural_model_name %>.fetch
      success: (collection) =>
        collection.each(@addOne)
      error: (collection, response) ->
        debug response

  addOne: (<%= singular_model_name %>) =>
    view = new <%= view_namespace %>.<%= singular_name.camelize %>View({model : <%= singular_model_name %>})
    @$("tbody").append(view.render().el)

  render: =>
    @$el.html(@template())
    @addAll()

    return this