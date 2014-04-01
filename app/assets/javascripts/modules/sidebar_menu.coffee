require.define "sidebar_menu" : (exports, require, module) ->

  module.exports = class SidebarMenu extends Marionette.ItemView
    template: JST['sidebar_menu']

    className: 'h-sidebar-menu'
