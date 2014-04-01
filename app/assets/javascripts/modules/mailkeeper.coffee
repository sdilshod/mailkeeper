require.define "mailkeeper": (exports, require, module) ->
  Router = require "router"

  module.exports = class Mailkeeper
    root: "/"

    constructor: ({@currentUser}) ->

    start: =>
      @router = new Router({@currentUser})
      Backbone.history.start(pushState: on)
