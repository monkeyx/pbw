class <%= model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/commands/<%= class_name%>'

  defaults:
    _type: '<%= class_name%>'
<% attributes.each do |attribute| -%>
    <%= attribute.name %>: null
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= model_namespace %>
  url: '/pbw/commands/<%= class_name%>'