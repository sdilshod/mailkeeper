require.define 'jquery/serialize_json': (exports, require, module) ->
  # %form
  #   %input{name: 'field', value: 'value'}
  #
  # coffeescript:
  #   $.fn.serializeJSON = require "serialize_json"
  #   $('form').serializeJSON() # => {field: 'value'}
  module.exports = ->
    json = {}
    _($(this).serializeArray()).each (field) ->
      json[field.name] = field.value
    json
