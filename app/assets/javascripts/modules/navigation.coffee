require.define "navigation" : (exports, require, module) ->

  module.exports = class Navigation extends Marionette.ItemView
    template: JST['navigation']
    className: 'h-navigation'

    templateHelpers: ->
      currentUser: @model.get "login"
