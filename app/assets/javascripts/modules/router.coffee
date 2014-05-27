require.define "router" : (exports, require, module) ->

#----------------------- views --------------------------
  Layout = require "layout"
  EmailView = require "views/email"
  NewMailView = require "views/new_mail"

  #------------------models---------------
  Emails = require "emails"

  module.exports = class Router extends Backbone.Router

    initialize: ({@currentUser}) ->
      @container = $('body')
      @defaultMailBox = "inbox"
      @layout = new Layout el: @container, currentUser: @currentUser
      @on "route", (name) =>
        @container.removeClass(@currentContainerClass)
        @currentContainerClass = _.str.dasherize(name)
        @container.addClass(@currentContainerClass)

    routes:
      ""                        :  "mainPage"
      "emails/box/:box_type"    :  "emails"
      "emails/get_latest"       :  "getEmailsFromServer"
      "emails/new"              :  "newMail"

    mainPage: ->
      @emails(@defaultMailBox)

    emails: (boxType) ->
      collection = new Emails.Collection
      view = new EmailView({collection, boxType})
      @layout.show view
      collection.fetch  data: {box_type: boxType}

    getEmailsFromServer: ->
      $.ajax
        type: 'GET',
        url: '/emails/get_latest.json',
        data:
          box_type: @defaultMailBox
        success: => @emails(@defaultMailBox)

    newMail: ->
      view = new NewMailView model: new Emails.Model
      @layout.show view
