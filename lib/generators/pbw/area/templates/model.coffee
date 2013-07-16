class <%= model_namespace %> extends Backbone.Model
  paramRoot: '<%= singular_table_name %>'
  urlRoot: '/pbw/areas'

  defaults:
    name: null
<% attributes.each do |attribute| -%>
    <%= attribute.name %>: null
<% end -%>

class <%= collection_namespace %>Collection extends Backbone.Collection
  model: <%= model_namespace %>
  url: '/pbw/areas'