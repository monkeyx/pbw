#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

Backbone.Model.prototype.idAttribute = "_id";

window.<%= js_app_name %> =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}