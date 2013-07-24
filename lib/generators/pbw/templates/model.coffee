class <%= js_model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/<%=model_namespace.downcase%>/<%= class_name%>'

  defaults:
    name: null
    _type: '<%= class_name%>'
<% attributes.each do |attribute| -%>
    <%= attribute.name %>: null
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= js_model_namespace %>
  url: '/pbw/<%=model_namespace.downcase%>/<%= class_name%>'