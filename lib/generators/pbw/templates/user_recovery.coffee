class <%= js_user_model_namespace %>Recovery extends Backbone.Model
  url: '/pbw/users/password.json'

  defaults:
    email: null