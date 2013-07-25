class <%= js_user_model_namespace %>Session extends Backbone.Model
  paramRoot: 'user'
  url: '/pbw/users/sign_in.json'

  defaults:
    email: null
    password: null
    remember_me: null