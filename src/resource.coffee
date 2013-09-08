class Resource
  constructor: (@game, @name) ->
    $.ajax
      url: "/resources/#{ @resourcePath() }.json",
      dataType: "json",
      success: @onLoad


module.exports.Resource = Resource
