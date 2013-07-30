class <%= js_user_model_namespace %>Registration extends Backbone.Model
  url: '/pbw/users.json'

  defaults:
    name: null
    email: null
    password: null
    password_confirmation: null