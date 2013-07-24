class <%= js_model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/constraints/<%= class_name%>'

  defaults:
    name: null
    _type: '<%= class_name%>'
<% attributes.each do |attribute| -%>
    <%= attribute.name %>: null
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= model_namespace %>
  url: '/pbw/constraints/<%= class_name%>'