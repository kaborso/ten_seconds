class Resource
  constructor: (@game, @name) ->
    $.ajax
      url: "/#{ @resourcePath() }.json",
      dataType: "json",
      success: @onLoad

module.exports.Resource = Resource