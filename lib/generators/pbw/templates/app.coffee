#= require_self
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

Backbone.Model.prototype.idAttribute = "_id";

window.<%= js_app_name %> =
  User: null
  Models: {Areas: {}, Items: {}, Commands: {}, Tokens: {}}
  Collections: {Areas: {}, Items: {}, Commands: {}, Tokens: {}}
  Routers: {}
  Views: {Areas: {}, Items: {}, Commands: {}, Tokens: {}}