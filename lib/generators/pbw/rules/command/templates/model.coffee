class <%= js_model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/commands/<%= class_name%>'

  defaults:
    token: null
    _type: '<%= class_name%>'
<% attributes.each do |attribute| -%>
<% unless attribute.name == 'process' %>
    <%= attribute.name %>: null
<% end %>
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= model_namespace %>
  url: '/pbw/commands/<%= class_name%>'