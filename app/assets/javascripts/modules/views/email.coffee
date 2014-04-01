require.define "views/email" : (exports, require, module) ->

  Emails = require "emails"

  module.exports = class EmailView extends Marionette.Layout
    template: JST['views/email/layout']
    className: 'l-email'

    initialize: ({@collection, @boxType}) ->

    regions:
      list    : '.email-table'

    events:
      'click .previous-button'         : "previousPage"
      'click .next-button'             : "nextPage"
      'click .load-from-server-button' : "getLatest"

    ui:
      previousPage: '.previous-button'
      nextPage:     '.next-button'

    collectionEvents:
      "sync" : "onRender"

    onRender: ->
      @list.show new EmailsView({@collection})
      @visibilityButtons()

    previousPage: ->
      @collection.fetch data: {box_type: @boxType, page: @collection.previousPage}

    nextPage: ->
      @collection.fetch data: {box_type: @boxType, page: @collection.nextPage}

    getLatest: ->


    visibilityButtons: ->
      @ui.previousPage.show() if @collection.previousPage
      @ui.previousPage.hide() unless @collection.previousPage

      @ui.nextPage.show() if @collection.nextPage
      @ui.nextPage.hide() unless @collection.nextPage

    templateHelpers: ->
      innerBox: if @boxType == "inbox" then true else false

  class EmailsViewItem extends Marionette.ItemView
    template: JST['views/email/emails_item']
    tagName: 'tr'

  class EmailsView extends Marionette.CompositeView
    template: JST['views/email/emails']
    itemView: EmailsViewItem
    tagName: 'table'
    attributes: { border: "1" }
    itemViewContainer: '.l-emails-list'
