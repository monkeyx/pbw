class <%= js_model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/<%=model_namespace.downcase%>/<%= class_namespace %>'

  defaults:
<% default_attributes.each do |attribute| -%>
    <%= attribute[:name] %>: '<%=attribute[:default_value]%>'
<% end -%>
<% attributes.each do |attribute| -%>
    <%= attribute.name %>: null
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= js_model_namespace %>
  url: '/pbw/<%=model_namespace.downcase%>/<%= class_namespace %>'