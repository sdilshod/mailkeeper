require.define "emails" : (exports, require, module) ->

  Emails = {}

  class Emails.Model extends Backbone.Model
    urlRoot: "/emails"


  class Emails.Collection extends Backbone.Collection
    model: Emails.Model

    url: "/emails"

    parse: (response) ->
      @previousPage = response.previous_page
      @nextPage = response.next_page
      response.emails


   module.exports = Emails
