require.define "layout" : (exports, require, module) ->
  Navigation = require "navigation"
  SidebarMenu = require "sidebar_menu"


  module.exports = class Layout extends Marionette.Layout
    template: JST["layout"]

    regions:
      navigation  : '.l-navigation'
      sidebarMenu : '.l-sidebar-menu'
      main        : '.l-main'

    initialize: ({@el, @currentUser}) ->
      @el.html @template()
      console.log @currentUser
      @navigation.show new Navigation(model: new Backbone.Model @currentUser)
      @sidebarMenu.show new SidebarMenu

    show: (view) ->
      @main.show view
