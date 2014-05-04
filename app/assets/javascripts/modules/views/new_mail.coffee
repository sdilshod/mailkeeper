require.define "views/new_mail" : (exports, require, module) ->

  module.exports = class NewMailView extends Backbone.View
    template: JST['views/new_mail']
    className: 'l-sent-mail'

    initialize: ->
      @listenTo @model, "sync:start", @_showSpinner

    events:
      "click input[type=submit]" : "_save"
      "click input[name=subject]": "showValue"

    ui:
      emailAddress: ->
        $('.email-address').val()
      subject: ->
        $('.subject').val()
      message: ->
        $('.message').val()
      fileField: ->
        $('.file-field')

    render: ->
      @$el.html @template @model.toJSON()
      this

    buildFormData: ->
      formData = new FormData
      formData.append "email[email_address]", @ui.emailAddress()
      formData.append "email[subject]", @ui.subject()
      formData.append "email[message]", @ui.message()
      formData.append "email_attachments[attached_file]", @ui.fileField()[0].files[0]
      formData.append $('meta[name=csrf-param]').attr('content'), $('meta[name=csrf-token]').attr('content')
      formData.append "email[box_type]", "sent"
      formData

    _save: (e) ->
      e.preventDefault()
      formData = @buildFormData()
      @model.save formData,
        url: "create.json"
        data: formData,
        processData: false,
        contentType: false,
        success: =>
          Backbone.history.navigate "", true
        error: (model, response) =>
          alert response.responseText
          #@$('form').form_errors(JSON.parse(response.responseText).errors)

    _showSpinner: ->
      @$el.text "Loading..."
