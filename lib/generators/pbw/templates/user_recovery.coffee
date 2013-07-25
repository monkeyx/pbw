class <%= js_user_model_namespace %>Recovery extends Backbone.Model
  paramRoot: 'user'
  url: '/pbw/users/password.json'

  defaults:
    email: null